variable "environment" {
  type = string
}

variable "subnetwork_cidrs" {
  type = list(any)
}

variable "regions" {
  type = list(any)
}
