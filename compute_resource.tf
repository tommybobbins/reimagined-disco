resource "random_pet" "powersaving_name" {}

data "google_project" "project" {
}

output "project_number" {
  value = data.google_project.project.number
}


resource "google_project_iam_binding" "instance_schedule" {
  project = var.project
  role    = google_project_iam_custom_role.instance_scheduler.name

  members = [
    "serviceAccount:service-${data.google_project.project.number}@compute-system.iam.gserviceaccount.com",
  ]
}

resource "google_project_iam_custom_role" "instance_scheduler" {
  role_id     = "InstanceScheduler"
  title       = "InstanceScheduler"
  description = "Able to power instances on and off"
  permissions = ["compute.instances.stop", "compute.instances.start"]
}

resource "google_compute_resource_policy" "powersaving" {
  name   = "powersaving-policy-${random_pet.powersaving_name.id}"
  region = var.region 
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
