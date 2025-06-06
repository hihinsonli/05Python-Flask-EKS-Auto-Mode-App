locals {

  # IAM Policies Files Path:
  iam_policies_filepath = join("/", [path.cwd, "iam_json"])

  # Get List of IAM Policies JSON Files:
  iam_policies_files = fileset(local.iam_policies_filepath, "*Policy.json")

  # IAM Policies Setting Objects List:
  iam_policies_objects_list = [
    for item in local.iam_policies_files : {
      name        = jsondecode(file(format("%s/%s", local.iam_policies_filepath, item))).PolicyName
      path        = jsondecode(file(format("%s/%s", local.iam_policies_filepath, item))).Path
      description = lookup(jsondecode(file(format("%s/%s", local.iam_policies_filepath, item))), "Description", null)
      policy      = jsonencode(jsondecode(file(format("%s/%s", local.iam_policies_filepath, item))).Document)
      tags = {
        for tag_object in lookup(jsondecode(file(format("%s/%s", local.iam_policies_filepath, item))), "Tags", []) :
        tag_object.Key => tag_object.Value
      }
    }
  ]

  # IAM Policies Settings Map:
  iam_policies_objects_map = {
    for object in local.iam_policies_objects_list :
    object.name => object
  }

  # IAM Roles Files Path:
  iam_roles_filepath = join("/", [path.cwd, "iam_json"])

  # Get List of IAM Roles JSON Files:
  iam_roles_files = fileset(local.iam_roles_filepath, "*Role.json")

  # IAM Roles Settingd Objects List:
  iam_roles_objects_list = [
    for item in local.iam_roles_files : {
      name                  = jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))).RoleName
      path                  = jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))).Path
      description           = lookup(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))), "Description", null)
      trust_policy          = jsonencode(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))).TrustPolicy)
      managed_policies_arns = lookup(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))), "ManagedPoliciesArns", [])
      inline_policies = length(lookup(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))), "InlinePolicies", [])) <= 0 ? toset([{
        name   = null
        policy = null
        }]) : tolist(toset(flatten([
          for inline_policy in lookup(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))), "InlinePolicies", []) :
          {
            name   = inline_policy.PolicyName
            policy = jsonencode(inline_policy.Document)
          } if lookup(inline_policy, "PolicyName", null) != null && lookup(inline_policy, "Document", null) != null
      ])))
      tags = {
        for tag_object in lookup(jsondecode(file(format("%s/%s", local.iam_roles_filepath, item))), "Tags", []) :
        tag_object.Key => tag_object.Value
      }
    }
  ]

  # IAM Roles Settings Map:
  iam_roles_objects_map = {
    for object in local.iam_roles_objects_list :
    object.name => object
  }
}
