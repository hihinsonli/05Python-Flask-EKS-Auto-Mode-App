variable "description" {
  type        = string
  description = "(Optional, Forces new resource) Description of the IAM policy."
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "name" {
  type        = string
  description = "(Optional, Forces new resource) Name of the policy. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "path" {
  type        = string
  description = "(Optional, default /) Path in which to create the policy."
  default     = "/"
}

variable "policy" {
  type        = string
  description = "(Required) Policy document. This is a JSON formatted string."
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Map of resource tags for the IAM Policy."
  default     = {}
}
