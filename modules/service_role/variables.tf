

variable "name" {
  type    = string
  default = null
}

variable "description" {
  type    = string
  default = null
}

variable "assume_role_principals" {
  type = list(string)
  description = "List of Assume Role Principals"
}


variable "attached_policies" {
  type        = set(string)
  default     = []
  description = "Policies to attach to the role"
}

variable "inline_policies" {
  type        = map(string)
  default     = {}
  description = "Json of policies to attach (inline) to the role"
}