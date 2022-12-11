resource "random_pet" "powersaving_name" {}

resource "google_compute_resource_policy" "powersaving" {
  name   = "powersaving-policy-${random_pet.powersaving_name.id}"
  region = "europe-west2"
  lifecycle {
    create_before_destroy = true
  }
  description = "Start and stop instances"
  instance_schedule_policy {
    vm_start_schedule {
      schedule = "0 6 * * *"
    }
    vm_stop_schedule {
      schedule = "0 20 * * *"
    }
    time_zone = "Europe/London"
  }
}
