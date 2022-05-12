terraform {
  cloud {
    organization = "lightricks"

    workspaces {
      tags = ["demo", "source:cli"]
    }
  }
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.20.0"
    }
  }
}

provider "google" {
  project = "ltx-ml-infra-playground"
  region  = "us-central1"
  zone    = "us-central1-c"
}


locals {
  workspaces = {
    demo-dev = {
      environment = "dev"
    }
    demo-prd = {
      environment = "prd"
    }
  }

  environment = local.workspaces[terraform.workspace]["environment"]
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-${local.environment}"
}

output "vpc_name" {
  value = google_compute_network.vpc_network.name
  description = "The vpc name"
}