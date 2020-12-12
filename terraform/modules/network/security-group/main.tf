resource "aws_security_group" "security_group" {
  name        = "${var.security_group_name}"
  description = "${var.security_group_description}"
  vpc_id      = "${var.security_group_vpc_id}"

  tags {
    "Name" = "${var.security_group_name}"
  }
}

resource "aws_security_group_rule" "security_group_rule" {
  count             = "${length(var.security_group_rule_description)}"
  description       = "${element(var.security_group_rule_description, count.index)}"
  security_group_id = "${aws_security_group.security_group.id}"
  type              = "${element(var.security_group_rule_type, count.index)}"
  from_port         = "${element(var.security_group_rule_from_port, count.index)}"
  to_port           = "${element(var.security_group_rule_to_port, count.index)}"
  protocol          = "${element(var.security_group_rule_protocol, count.index)}"
  cidr_blocks       = "${element(var.security_group_rule_cidr_blocks, count.index)}"
  self              = "${element(var.security_group_rule_self, count.index)}"
}
