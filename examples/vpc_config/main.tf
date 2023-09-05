locals {
  tags = {
    Name = random_pet.run.id
  }
}
resource "random_pet" "run" {
  length = 2
}

module "observe_lambda" {
  source = "../.."

  name                        = random_pet.run.id
  observe_collection_endpoint = var.observe_collection_endpoint
  observe_token               = var.observe_token

  vpc_config = {
    subnets         = [aws_subnet.private]
    security_groups = [aws_security_group.allow_outbound]
  }
}
