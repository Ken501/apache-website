variable "region" {
  description = "Preferred AWS Region"
  default     = "us-east-1"
}

variable "access_key" {
  description = "AWS Access key ID"
  default     = ""
}

variable "secret_key" {
  description = "AWS Secret access key"
  default     = ""
}

variable "additional_tags" {
  description = "Tags used to identify the project and other details"
  default     = {}
  type        = map(string)
}

variable "app_name" {
  description = "Name of application"
  default     = "Demo-Website"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}