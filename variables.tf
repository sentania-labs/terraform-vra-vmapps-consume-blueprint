variable "project_name" {
  type = string
}
variable "description" {
  type = string
}

variable "blueprint_name" {
  type = string
}

variable "deployment_name" {
  type = string
}
variable "inputs" {
  description = "Arbitrary inputs to pass to the blueprint"
  type        = any
  default     = {}
}
