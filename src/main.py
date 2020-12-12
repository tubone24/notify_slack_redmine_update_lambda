#!/usr/bin/python
# -*- coding: utf-8 -*-
"""The script that access the Redmine server in the private environment, detects ticket updates, and notifies Slack.
     * Access the Redmine for Redmine API
     * When updates, extract contents and push notify to Slack incoming webhook
Todo:
    * Any Tests
    * Documents
"""

from datetime import datetime, timedelta, timezone
import os
from os.path import join, dirname
import json
from dotenv import load_dotenv
import requests
from retrying import retry
import boto3
from boto3.dynamodb.conditions import Key

dotenv_path = join(dirname(__file__), "../.env")
load_dotenv(dotenv_path)

JST = timezone(timedelta(hours=+9))

REDMINE_URL = os.environ.get("REDMINE_URL")
REDMINE_TOKEN = os.environ.get("REDMINE_TOKEN")
SINCE_DYNAMODB = os.environ.get("SINCE_DYNAMODB")
SLACK_WEBHOOK_URL = os.environ.get("SLACK_WEBHOOK_URL")
REGION_NAME = os.getenv("AWS_REGION", "ap-northeast-1")
PROJECT_ID = os.getenv("PROJECT_ID")

dynamodb = boto3.resource("dynamodb", region_name=REGION_NAME)
redmine_last_update_table = dynamodb.Table("redmine_last_update")


def get_issues(project_id=None):
    first_offset = 0
    limit = 100
    if project_id:
        payload = {
            "key": REDMINE_TOKEN,
            "offset": first_offset,
            "limit": limit,
            "sort": "updated_on:desc",
            "project_id": project_id,
        }
    else:
        payload = {
            "key": REDMINE_TOKEN,
            "offset": first_offset,
            "limit": limit,
            "sort": "updated_on:desc",
        }
    resp = requests.get(f"{REDMINE_URL}/issues.json", params=payload)
    issues = extract_resp(resp)
    total_count = resp.json()["total_count"]
    for offset in range(first_offset, total_count, limit):
        payload = {"key": REDMINE_TOKEN, "offset": offset, "limit": limit}
        resp = requests.get(f"{REDMINE_URL}/issues.json", params=payload)
        new_issues = extract_resp(resp)
        issues.extend(new_issues)
    issues = list(map(json.loads, set(map(json.dumps, issues))))
    issues = sorted(issues, key=lambda x: x["updated_on"], reverse=True)
    return issues


def extract_resp(resp):
    return [
        {
            "subject": x["subject"],
            "id": x["id"],
            "updated_on": x["updated_on"],
            "status": x["status"]["name"],
        }
        for x in resp.json()["issues"]
    ]


def get_issues_from_last_updated_on(issues, updated_on):
    filtered_issues = []
    updated_on = datetime.strptime(updated_on, "%Y-%m-%dT%H:%M:%SZ").astimezone(JST)
    for issue in issues:
        if updated_on < datetime.strptime(
            issue["updated_on"], "%Y-%m-%dT%H:%M:%SZ"
        ).astimezone(JST):
            filtered_issues.append(issue)
    return filtered_issues


def get_issue_detail(issue):
    payload = {"key": REDMINE_TOKEN, "include": "attachments,journals,watchers"}
    resp = requests.get(f"{REDMINE_URL}/issues/{issue['id']}.json", params=payload)
    return resp.json()["issue"]


def create_message(detail_issue):
    text = f"""
【URL】
{REDMINE_URL}/issues/{detail_issue["id"]}

【Description】
{detail_issue["description"]}
{"="*60}

【Latest Journals】
"""

    if "journals" in detail_issue:
        journal_text = create_journal_message(detail_issue["journals"])
        text += journal_text
    return text


def create_journal_message(journals):
    formatted_text = []
    for journal in journals:
        text = f"""
{datetime.strftime(datetime.strptime(journal["created_on"], "%Y-%m-%dT%H:%M:%SZ").astimezone(JST), "%Y-%m-%d %H:%M:%S")} @ {journal["user"]["name"]}

{journal["notes"]}
{"="*60}

"""
        formatted_text.append(text)
    if formatted_text:
        return formatted_text[-1]
    else:
        return ""


@retry(
    stop_max_attempt_number=3,
    wait_incrementing_start=1000,
    wait_incrementing_increment=1000,
)
def call_slack_api(webhook, title, text):
    send_text = f"{title}\n```{text}```"
    payload = {"text": send_text}
    requests.post(webhook, json.dumps(payload), timeout=(3.0, 7.5))


def get_last_updated_on():
    try:
        return redmine_last_update_table.query(
            KeyConditionExpression=Key("project_id").eq(PROJECT_ID), ConsistentRead=True
        )["Items"][0]["last_updated_on"]
    except (KeyError, AttributeError):
        return ""


def update_last_updated_on(updated_on):
    return redmine_last_update_table.update_item(
        Key={"project_id": PROJECT_ID},
        AttributeUpdates={"last_updated_on": {"Action": "PUT", "Value": updated_on}},
        ReturnValues="ALL_OLD",
    )


def main():
    last_updated_on = get_last_updated_on()
    issues = get_issues(project_id=PROJECT_ID)
    filtered_issues = get_issues_from_last_updated_on(issues, last_updated_on)
    for i in filtered_issues:
        print(i)
        text = create_message(get_issue_detail(i))
        title = f"{'='*50}\n【Title】\n{i['subject']}"
        call_slack_api(SLACK_WEBHOOK_URL, title, text)
    update_last_updated_on(issues[0]["updated_on"])


if __name__ == "__main__":
    main()
