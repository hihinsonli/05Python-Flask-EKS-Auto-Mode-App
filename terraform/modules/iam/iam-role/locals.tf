locals {
  # Convert set to list:
  managed_policy_arns = tolist(var.managed_policy_arns)
}
