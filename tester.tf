
locals {
  lifecycle_powersaving = {
    "development" = [ google_compute_resource_policy.powersaving.self_link ]
    "live"        = null
  }
}

resource "google_compute_instance" "tester" {
  name         = "test-instance1"
  machine_type = "e2-micro"
  zone         = "${var.region}-c"
  tags         = ["nightly-shutdown", "test"]
  labels       = local.project_labels
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        tostop = "true"
      }
      size = 10
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.id
    access_config {
    }
  }

  #  resource_policies = var.project_lifecycle == "development" ? [google_compute_resource_policy.powersaving.self_link] : null
  resource_policies = lookup(local.lifecycle_powersaving, var.project_lifecycle)



}
