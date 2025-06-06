output "role_arn" {
  value = aws_iam_role.this.arn
}

output "role_create_date" {
  value = aws_iam_role.this.create_date
}

output "role_id" {
  value = aws_iam_role.this.id
}

output "role_name" {
  value = aws_iam_role.this.name
}

output "role_unique_id" {
  value = aws_iam_role.this.unique_id
}
