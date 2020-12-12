variable "security_group" {
  type = "map"
  default = {
    vpc_id = ""
    description = ""
  }
}

variable "security_group_rule" {
  type = "map"
  default = {
    type = []
    from_port = []
    to_port = []
    protocol = []
    cidr_blocks = []
    self = []
    description = []
  }
}

variable "lambda_function" {
  type = "map"
  default = {
    function_name = ""
    role = ""
    memory_size = 128
    source_code_hash = ""
    timeout = 60
    runtime = "python3.6"
  }
}

variable "environment" {
  type = "map"
  default = {
  }
}

variable "subnet_ids" {
  type = "list"
}