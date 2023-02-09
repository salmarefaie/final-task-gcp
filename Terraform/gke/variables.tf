variable "vpcID" {
  type        = string
  description = "id of vpc network"
}

variable "restricted-subnet" {
  type        = string
  description = "restricted subnet id"
}

variable "gke-name" {
  type        = string
  description = "GKE name"
}

variable "zone" {
  type        = string
  description = "zone of master cluster"
}

variable "cidr-subnet" {
  type        = string
  description = "cidr of management subnet"
}

variable "sumnet-name" {
  type        = string
  description = "management subnet name"

}

variable "machine-type" {
  type        = string
  description = "machine type of node"
}

variable "node-name" {
  type        = string
  description = "name of node"
}

variable "master-cidr" {
  type        = string
  description = "cidr of master"
}

variable "cluster-cidr" {
  type        = string
  description = "cidr of cluster"
}

variable "service-cidr" {
  type        = string
  description = "cidr of service"
}

variable "zone-node" {
  type        = string
  description = "zone of node"
}

variable "gke-service-account" {
  type        = string
  description = "service account for gke"
} 