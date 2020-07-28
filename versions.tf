
terraform {
  required_version = ">= 0.12"
}


# Additional  configuration
provider "aws" {
  alias  = "demostack"
  region = var.primary_region
}
