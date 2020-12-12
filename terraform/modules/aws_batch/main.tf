#####################################
#AWS Batch
#####################################
resource "aws_batch_job_definition" "aws_batch_job_definition" {
  name = var.aws_batch_job_definition_name
  type = "container"
  container_properties = var.aws_batch_job_definition_container_properties
}

resource "aws_batch_compute_environment" "aws_batch_compute_environment" {
  compute_environment_name = var.aws_batch_compute_environment_compute_environment_name
  compute_resources {
    instance_role = var.aws_batch_compute_environment_instance_role
    instance_type = var.aws_batch_compute_environment_instance_type
    max_vcpus = var.aws_batch_compute_environment_max_vcpus
    min_vcpus = var.aws_batch_compute_environment_min_vcpus
    desired_vcpus = var.aws_batch_compute_environment_desired_vcpus
    security_group_ids = var.aws_batch_compute_environment_security_group_ids
    subnets = var.aws_batch_compute_environment_subnets
    type = var.aws_batch_compute_environment_compute_resources_type
  }
  service_role = var.aws_batch_compute_environment_service_role
  type = var.aws_batch_compute_environment_type
}

resource "aws_batch_job_queue" "aws_batch_job_queue" {
  name = var.aws_batch_job_queue_name
  state = var.aws_batch_job_queue_state
  priority = var.aws_batch_job_queue_priority
  compute_environments = [
    aws_batch_compute_environment.aws_batch_compute_environment.arn
  ]
}