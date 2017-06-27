variable "PROJ_ID"              { }
variable "SELECTEL_ACCOUNT"     { }
variable "USER"                 { }
variable "PASSWORD"             { }

variable "server_name"          { }
variable "server_region"        { }
variable "server_network_id"    { }
variable "server_floating_ip"   { }
variable "server_ip"            { }
variable "server_disk1_name"    { }
variable "server_disk1_size"    { }
variable "server_disk1_type"    { }
variable "server_flavor"        { }
variable "server_image"         { }
variable "server_key_pair"      { }

provider "openstack" {
  domain_name = "${var.SELECTEL_ACCOUNT}"
  auth_url    = "https://api.selvpc.ru/identity/v3"
  tenant_name = "${var.PROJ_ID}"
  tenant_id   = "${var.PROJ_ID}"
  user_name   = "${var.USER}"
  password    = "${var.PASSWORD}"
}

resource "openstack_blockstorage_volume_v2" "disk1" {
  name        = "${var.server_disk1_name}"
  region      = "${var.server_region}"
  size        = "${var.server_disk1_size}"
  image_id    = "${var.server_image}"
  volume_type = "${var.server_disk1_type}"
  lifecycle {
    prevent_destroy = true
  }
}

resource "openstack_compute_instance_v2" "server" {
  name        = "${var.server_name}"
  flavor_name = "${var.server_flavor}"
  region      = "${var.server_region}"
  key_pair    = "${var.server_key_pair}"


  network {
    uuid        = "${var.server_network_id}"
    fixed_ip_v4 = "${var.server_ip}"
    floating_ip = "${var.server_floating_ip}"
  }


  metadata = {
    "x_sel_server_default_addr"  = "{\"ipv4\":\"\"}"
  }


  block_device {
    uuid   = "${openstack_blockstorage_volume_v2.disk1.id}"
    source_type      = "volume"
    boot_index       = 0
    destination_type = "volume"
  }
}