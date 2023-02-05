variable "k8s_source_template" {
  description = "template to be used"
  type        = string

}

variable "k8s_masters" {
  description = "vm variables in a dictionary "
  type = map(any)
}
