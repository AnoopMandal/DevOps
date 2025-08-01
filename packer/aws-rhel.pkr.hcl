packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "rhel8" {
  ami_name      = "learn-packer-linux-aws-ubuntutest"
  profile       = "rashmieks"
  instance_type = "t2.micro"
  region        = "ap-south-1"
  source_ami    = "ami-0521bc4c70257a054"
  # source_ami_filter {
  #   filters = {
  #     name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
  #     root-device-type    = "ebs"
  #     virtualization-type = "hvm"
  #   }
  #  most_recent = true
  #  owners      = ["099720109477"]
  #}
  ssh_username = "ec2-user"
  tags = {
    "Name"        = "MyUbuntuImage"
    "Environment" = "TestDevC"
    "OS_Version"  = "Ubuntu 22.04"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}
build {
  name = "learn-packer"
  sources = [
    "source.amazon-ebs.rhel8"
  ]
  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo yum update -y",
      "echo starting nginx",
      "sudo yum install -y nginx"
    ]
  }
  provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }
  provisioner "shell" {
    inline = [
      "echo starting with setup",
      "sudo sh /tmp/assets/setup-web.sh",
      "echo setup complete",
      "sleep 60"
    ]
  }
  post-processor "manifest" {}
}

#packer build -var-file="variables.pkrvars.hcl" .


