terraform {
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

variable "my_name" {
  description = "The user name"
}

variable "another_var" {
  default = "bla"
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network-${var.my_name}"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "default-subnet-${var.another_var}"
  network                  = google_compute_network.vpc_network.name
  ip_cidr_range            = "172.16.0.0/22"
}

output "vpc_name" {
  value = google_compute_network.vpc_network.name
  description = "The vpc name"
}

output "second_output" {
  value = var.another_var
  description = "The another_var value"
}