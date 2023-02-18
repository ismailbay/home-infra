variable "vm_ssh_keys" {
    description = "ssh keys used in VMs"
    type = string
}

variable "num_k3s_masters" {
  default = 3
}

variable "k3s_master_ip_addresses" {
  description = "List of IP addresses for master node(s)"
  type        = list(string)
  default     = ["192.168.1.101/24", "192.168.1.102/24", "192.168.1.103/24"]
}

variable "num_k3s_workers" {
  default = 3
}

variable "k3s_worker_ip_addresses" {
  description = "List of IP addresses for master node(s)"
  type        = list(string)
  default     = ["192.168.1.104/24", "192.168.1.105/24", "192.168.1.106/24"]
}

variable "k8s_source_template" {
  default = "ubuntu-cloud"
}

variable "k3s_user" {
  default = "ismail"
}