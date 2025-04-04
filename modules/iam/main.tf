resource "aws_iam_group" "group" {
  name = var.groupname
}

resource "aws_iam_user" "iam_user" {
  name = var.username
}

resource "aws_iam_access_key" "credentials" {
  user = aws_iam_user.iam_user.name
}

resource "aws_iam_user_login_profile" "credentials" {
  user                    = aws_iam_user.iam_user.name
  password_reset_required = true
}

resource "aws_iam_group_policy_attachment" "admin_policy" {
  group      = aws_iam_group.group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_group_membership" "group_membership" {
  name  = "group-members"
  group = aws_iam_group.group.name
  users = [aws_iam_user.iam_user.name]
}