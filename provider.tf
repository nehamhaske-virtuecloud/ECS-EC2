provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "Project" : "ecs-ec2"
      "Environment" : "Dev"
    }
  }
}