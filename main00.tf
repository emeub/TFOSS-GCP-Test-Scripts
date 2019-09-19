provider "google" {
  project = "{TFOSS-GCP}"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_compute_instance" "vm_instance" {
  count        = "30" // number of vm instances being set
  name         = "ubuntu1804_${count.index+1}"
  machine_type = "g1-small" // 0.5 vCPUs 1.7 GB RAM
  zone         = "us-central1" // datacenter location (closer is better)

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-1804-lts" // ubuntu 18.04 LTS
    }
  }

  network_interface {
    # A default network is created for all GCP projects
    network       = "${google_compute_network.vpc_network.self_link}" // does magic
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network" // terraform defaults (?) 
  auto_create_subnetworks = "true" // terraform defaults (?)
}