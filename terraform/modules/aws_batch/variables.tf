variable "aws_batch_job_definition_name" {}
variable "aws_batch_job_definition_container_properties" {}
variable "aws_batch_compute_environment_compute_environment_name" {}
variable "aws_batch_compute_environment_instance_role" {}
variable "aws_batch_compute_environment_security_group_ids" {}
variable "aws_batch_compute_environment_instance_type" {}
variable "aws_batch_compute_environment_subnets" {}
variable "aws_batch_compute_environment_compute_resources_type" { default = "EC2" }
variable "aws_batch_compute_environment_max_vcpus" {}
variable "aws_batch_compute_environment_min_vcpus" {}
variable "aws_batch_compute_environment_desired_vcpus" {}
variable "aws_batch_compute_environment_service_role" {}
variable "aws_batch_compute_environment_type" { default = "MANAGED" }
variable "aws_batch_job_queue_name" {}
variable "aws_batch_job_queue_state" { default = "ENABLED" }
variable "aws_batch_job_queue_priority" { default = 1 }