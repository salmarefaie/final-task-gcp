variable "vm-role" {
  type        = string
  description = "role of vm"
}

variable "gke-role" {
  type        = string
  description = "role of gke"
}

variable "project-id" {
  type        = string
  description = "project id"
}

variable "vm-sa-name" {
  type        = string
  description = " vm service account name"
}

variable "vm-sa-id" {
  type        = string
  description = "vm service account id"
}

variable "gke-sa-name" {
  type        = string
  description = "gke service account name"
}

variable "gke-sa-id" {
  type        = string
  description = "gke service account id"
}