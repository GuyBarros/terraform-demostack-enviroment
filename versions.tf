
terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  # version = "~> 2.0"
  region  = var.primary_region
}


# Additional provider configuration for west coast region
provider "aws" {
  alias  = "demostack"
  region  = var.primary_region
}
