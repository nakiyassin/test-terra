resource "aws_instance" "instance-ec2" {
  count         = 3
  ami           = element(var.amis, count.index)
  instance_type = var.instance_type
  tags = {
    Name          = "${var.name}-${count.index}"
    Environnement = var.env
  }
  subnet_id = var.subnet_id
}

terraform {
  backend "s3" {
    bucket         = "terraform-remote-state-95100yassin"
    key            = "tfstate/my_terraform.tfstate"
    region         = "eu-north-1"
    encrypt        = true
    dynamodb_table = "terraform-lockyassin"
  }
}


variable "amis" {
  description = "amis des instances EC2"
  type        = list(any)
  default     = ["ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c", "ami-05edb7c94b324f73c"]
}

variable "instance_type" {
  type        = string
  description = "Type d'instance"
  default     = "t3.micro"
}

variable "subnet_id" {
  type        = string
  description = "Subnet"
  default     = "subnet-02dbf55cf4ab64fc4"
}

variable "name" {
  description = "Le nom de l'instance EC2"
  default     = "ec2YassinTerraform2"
}

variable "env" {
  description = "Environnement"
  default     = "dev"
}



