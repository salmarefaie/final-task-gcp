variable "subnet" {
  type        = map(any)
  description = "subnets"
}

variable "vpc-name" {
  type        = string
  description = "vpc name"
}

variable "router-name" {
  type        = string
  description = "router name"
}

variable "nat-name" {
  type        = string
  description = "nat name"
}

variable "routing-mode" {
  type        = string
  description = "regional for routing mode"
}

variable "auto-subnets" {
  type        = bool
  description = "no auto subnets , custom subnets"
}