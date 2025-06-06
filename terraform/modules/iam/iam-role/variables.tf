variable "name" {
  type        = string
  description = "(Optional, Forces new resource) Friendly name of the role. If omitted, Terraform will assign a random, unique name."
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "(Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with name."
  default     = null
}

variable "path" {
  type        = string
  description = "(Optional, default /) Path to the role."
  default     = "/"
}

variable "assume_role_policy" {
  type        = string
  description = "(Required) Policy that grants an entity permission to assume the role."
}

variable "description" {
  type        = string
  description = "(Optional) Description of the role."
  default     = null
}

variable "force_detach_policies" {
  type        = bool
  description = "(Optional) Whether to force detaching any policies the role has before destroying it. Defaults to true."
  default     = true
}

variable "inline_policies" {
  type = set(object({
    name   = string
    policy = string
  }))
  description = "(Optional) Configuration block defining an exclusive set of IAM inline policies associated with the IAM role."
  default     = []
}

variable "managed_policy_arns" {
  type        = set(string)
  description = "(Optional) Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(Optional) Key-value mapping of tags for the IAM role."
  default     = {}
}
