variable "environment" {
  type    = string
  default = "dev"
}

variable "gcp_project_id" {
  type = string
}

variable "subnetwork_cidrs" {
  type = list(any)
}

variable "regions" {
  type = list(any)
}

variable "username" {
  type    = string
  default = "test"
}
