// Configure the Google Cloud provider
provider "google" {
 credentials = file("secrets/My_Project_7847-b6797c6771e2.json")
 project     = "healthy-terrain-281402"
 region      = "us-east4"
 version     = "~> 3.35.0"
 #source      = "hashicorp/google"
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
 byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
 name         = "signalfx-snowman-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"
 //machine_type = "n1-standard-4"
 zone         = "us-east4-c"

 boot_disk {
   initialize_params {
     #image = "debian-cloud/debian-9"
     image = "ubuntu-1804-lts"
   }
 }

 metadata = {
   ssh-keys = "sryder:${file("~/.ssh/id_rsa.pub")}"
 }

 // location of your startup scripts
 metadata_startup_script = file("scripts/installSnowmanSignalFxSmartAgent.txt")

 network_interface {
   network = "default"

   access_config {
     // Include this section to give the VM an external ip address
   }
 }
}
