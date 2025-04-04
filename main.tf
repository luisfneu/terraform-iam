resource "aws_iam_group" "ext_admin" {
  name = "ext-admin"
}

resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.ext_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user" "jeferson" {
  name = "jeferson"
  path = "/devops/"
  
}

resource "aws_iam_user_login_profile" "user_login" {
  user    = aws_iam_user.jeferson.name
  password_reset_required = true
}

resource "aws_iam_group_membership" "ext_admin_membership" {
  name  = "ext-admin-members"
  group = aws_iam_group.ext_admin.name
  users = [aws_iam_user.jeferson.name]
}

resource "aws_iam_access_key" "jeferson_key" {
  user = aws_iam_user.jeferson.name
}

output "user_password" {
  description = "Senha temporária"
  value       = aws_iam_user_login_profile.user_login.password
  sensitive = true
} 