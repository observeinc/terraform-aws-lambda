locals {
  tags = {
    Name = random_pet.run.id
  }
}
resource "random_pet" "run" {
  length = 2
}

module "observe_lambda" {
  source = "observeinc/lambda/aws"

  name             = random_pet.run.id
  observe_domain   = var.observe_domain
  observe_customer = var.observe_customer
  observe_token    = var.observe_token

  vpc_config = {
    subnets         = [aws_subnet.private]
    security_groups = [aws_security_group.allow_outbound]
  }
}
