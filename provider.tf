# /************************************************
#   Provider definition
# ************************************************/

terraform {
  required_version = ">= 1.9"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 5.40.0, < 7.0.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = ">= 5.40.0, < 7.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
    fortios = {
      source = "fortinetdev/fortios"
    }
  }
}

provider "google" {
  project = var.infra_project_id
  region  = var.region
}

provider "google-beta" {
  project = var.infra_project_id
  region  = var.region
}