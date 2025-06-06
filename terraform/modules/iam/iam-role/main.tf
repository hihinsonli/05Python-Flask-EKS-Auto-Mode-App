# AWS IAM Role: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "this" {
  assume_role_policy    = var.assume_role_policy
  description           = var.description
  force_detach_policies = var.force_detach_policies

  # Use dynamic block for managing inline policies: https://www.terraform.io/language/expressions/dynamic-blocks
  dynamic "inline_policy" {
    for_each = var.inline_policies
    content {
      name   = inline_policy.value.name
      policy = inline_policy.value.policy
    }
  }

  name        = var.name_prefix != null ? null : var.name
  name_prefix = var.name_prefix
  path        = var.path
  tags        = var.tags
}

# AWS IAM Role Policy Attachments: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "this_policy_attachment" {
  count      = length(local.managed_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = local.managed_policy_arns[count.index]
}
