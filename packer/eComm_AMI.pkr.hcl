packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}


source "amazon-ebs" "rhel10" {
  ami_name      = "eComm-RHEL-AMI"
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
    "Name"        = "eComm-RHEL10-AMI"
    "Environment" = "TestDeveComm"
    "OS_Version"  = "RHEL 10.0"
    "Release"     = "Latest"
    "Created-by"  = "Packer"
  }
}
build {
  name = "eComm-packer"
  sources = [
    "source.amazon-ebs.rhel10"
  ]
  provisioner "shell" {
    inline = [
      "echo Installing Updates",
      "sudo yum update -y",
      "echo installing JAVA",
      "sudo yum install java-21-openjdk-devel -y",
      "echo JAVA version is",
      "java -version",
      "echo install curl, net-tools,wget ...",
      "sudo yum install curl -y",
      "sudo yum install wget -y",
      "sudo yum install net-tools -y",
      "echo install unzip, zip,  ...",
      "sudo yum install zip -y",
      "sudo yum install unzip -y",
      "echo installing aws cli ...",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "aws --version",
      "echo installing HELM ...",
      "sudo curl -L 'https://mirror.openshift.com/pub/openshift-v4/clients/helm/latest/helm-linux-amd64' -o /usr/local/bin/helm",
      "sudo chmod +x /usr/local/bin/helm",
      "echo verion",
      "helm version",
      "echo installing KUBECTL ...",
      "curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",
      "curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256",
      "echo $(cat kubectl.sha256)  kubectl | sha256sum --check",
      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
      "echo installing maven..........",
      "curl -O https://dlcdn.apache.org/maven/maven-3/3.8.9/binaries/apache-maven-3.8.9-bin.zip",
      "unzip apache-maven-3.8.9-bin.zip",
      "echo 'export M2_HOME=/home/ec2-user/apache-maven-3.8.9' >> ~/.bash_profile",
      "echo 'export M2=$M2_HOME/bin' >> ~/.bash_profile",
      "echo 'export JAVA_HOME=/usr/lib/jvm/java-21-openjdk' >> ~/.bash_profile",
      "echo 'export PATH=$M2:$PATH:$JAVA_HOME/bin' >> ~/.bash_profile",
      "source ~/.bash_profile",
      "echo Installation complete. Best of luck.."

    ]
  }

  post-processor "manifest" {}
}

#packer build -var-file="variables.pkrvars.hcl" .


