resource "google_compute_network" "network" {
  name                    = "test-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = "subnetwork"
  ip_cidr_range = "10.132.23.0/24"
  region        = var.region
  network       = google_compute_network.network.id
}

resource "google_compute_firewall" "internal" {
  project     = var.project
  name        = "test-firewall"
  network     = google_compute_network.network.name
  description = "No internal firewall rules"

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "ipip"
  }

  allow {
    protocol = "udp"
  }

  source_tags = ["test"]
  target_tags = ["test"]
}
