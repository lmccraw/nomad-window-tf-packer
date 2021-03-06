provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

data "aws_ami" "latest-windows" {
  most_recent = true
  owners      = ["729476260648"]
  
  filter {
    name = "name"
    values = ["windows2016Server-*"]
  }

}
resource "aws_instance" "nomad_server" {
  ami             = "${data.aws_ami.latest-windows.id}"
  instance_type   = "${var.server_type}"
  key_name        = "${var.key_name}"
  get_password_data = true
  vpc_security_group_ids = ["${aws_security_group.primary.id}"]
  count                  = "${var.server_count}"
  tags {
    Name           = "${var.name}-win-nomad-server-${count.index + 1}"
  }

  root_block_device = {
    volume_size = "100"
  }
}

resource "aws_instance" "nomad_client" {
  ami             = "${data.aws_ami.latest-windows.id}"
  instance_type   = "${var.client_type}"
  key_name        = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.primary.id}"]
  count                  = "${var.client_count}"

  tags {
    Name           = "${var.name}-win-nomad-client-${count.index + 1}"
  }

  root_block_device = {
    volume_size = "100"
  }   
}