resource "aws_iam_user" "user_a" {
  name = "user-a"
}

resource "aws_iam_user" "user_b" {
  name = "user-b"
}

resource "aws_iam_user_policy" "user_a_policy" {
  name = "user-a-bucket-policy"
  user = aws_iam_user.user_a.name

  policy = jsonencode({
   Verion = 
  }
  )
}
