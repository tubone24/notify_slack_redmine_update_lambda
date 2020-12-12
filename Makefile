ENV = $1
TARGET = $2
ARGS = $3
CD_TF = cd terraform/components/${TARGET}
VARS = ${ENV}.tfvars
PROFILE = ${ENV}
BUCKET_NAME = redmine-${ENV}-tf
AWS = $(shell ls -a ~/ | grep .aws)

backend:
ifeq ($(AWS),.aws)
	aws s3api create-bucket --bucket ${BUCKET_NAME} --create-bucket-configuration LocationConstraint=ap-northeast-1 --profile ${PROFILE}
else
	aws s3api create-bucket --bucket ${BUCKET_NAME} --create-bucket-configuration LocationConstraint=ap-northeast-1
endif

tf:
	@${CD_TF} && \
		terraform workspace select ${PROFILE} && \
		terraform ${ARGS} \
		-var-file=${VARS}

import:
	@${CD_TF} && \
		terraform workspace select ${PROFILE} && \
		terraform import  \
		-var-file=${VARS} \
		${ARGS}

plan:
ifeq ($(AWS),.aws)
	@${CD_TF} && \
	    sh ../lambda_builder.sh 0 && \
		terraform workspace select ${PROFILE} && \
		terraform plan \
		-var-file=${VARS}
else
	@${CD_TF} && \
	    sh ../lambda_builder.sh 0 && \
		terraform workspace select ${PROFILE} && \
		terraform plan \
		-var-file=${VARS}
endif

apply:
ifeq ($(AWS),.aws)
	@${CD_TF} && \
		terraform workspace select ${PROFILE} && \
		terraform apply -var-file=${VARS}
else
	@${CD_TF} && \
		terraform workspace select ${PROFILE} && \
		terraform apply -var-file=${VARS}
endif

create-env:
	@${CD_TF} && \
		terraform workspace new ${PROFILE}

remote-enable:
	@${CD_TF} && \
		terraform init \
		-input=true \
		-reconfigure \
		-backend-config "bucket=${BUCKET_NAME}" \
		-backend-config "profile=${PROFILE}"

destory-plan:
	@${CD_TF} && \
		terraform workspace select ${ENV} && \
		terraform plan -destroy \
		-target=${TARGET} \
		-var-file=${VARS}