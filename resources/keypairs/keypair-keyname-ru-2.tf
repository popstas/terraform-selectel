variable "PROJ_ID"              { }
variable "SELECTEL_ACCOUNT"     { }
variable "USER"                 { }
variable "PASSWORD"             { }

provider "openstack" {
  domain_name = "${var.SELECTEL_ACCOUNT}"
  auth_url    = "https://api.selvpc.ru/identity/v3"
  tenant_name = "${var.PROJ_ID}"
  tenant_id   = "${var.PROJ_ID}"
  user_name   = "${var.USER}"
  password    = "${var.PASSWORD}"
}

resource "openstack_compute_keypair_v2" "keyname" {
  name        = "keyname"
  region      = "ru-2"
  public_key  = "ssh-rsa ... user@example.com"
}
