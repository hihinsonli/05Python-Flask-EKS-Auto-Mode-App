module "iam_policies" {
  source      = "../modules/iam/iam-policy"
  for_each    = local.iam_policies_objects_map
  name        = each.value.name
  path        = each.value.path
  description = each.value.description
  policy      = each.value.policy
  tags        = each.value.tags
}

module "iam_roles" {
  source              = "../modules/iam/iam-role"
  for_each            = local.iam_roles_objects_map
  assume_role_policy  = each.value.trust_policy
  description         = each.value.description
  inline_policies     = each.value.inline_policies
  managed_policy_arns = each.value.managed_policies_arns
  name                = each.value.name
  path                = each.value.path
  tags                = each.value.tags
  depends_on = [
    module.iam_policies
  ]
}
