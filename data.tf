data "aws_ami" "linux_2" {
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm*"]
  }
  most_recent = true
}