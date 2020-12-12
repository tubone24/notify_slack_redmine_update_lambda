variable "security_group_name" {}
variable "security_group_description" {}
variable "security_group_vpc_id" {}

variable "security_group_rule_description" {
  default = []
}

variable "security_group_rule_type" {
  default = []
}

variable "security_group_rule_from_port" {
  default = []
}

variable "security_group_rule_to_port" {
  default = []
}

variable "security_group_rule_protocol" {
  default = []
}

variable "security_group_rule_cidr_blocks" {
  default = []
}

variable "security_group_rule_self" {
  default = []
}
