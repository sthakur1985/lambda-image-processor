resource "aws_iam_user" "user_a" {
  name = "user-a"
}

resource "aws_iam_user" "user_b" {
  name = "user-b"
}

resource "aws_iam_user_policy" "user_a_policy" {
  name = "user-a-bucket-a-policy"
  user = aws_iam_user.user_a.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:ListBucket"],
        resources = [
          "${var.bucket_a_arn}/*",
          "${var.bucket_b_arn}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_user_policy" "user_b_policy" {
  name = "user-b-bucket-b-policy"
  user = aws_iam_user.user_b.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:ListBucket"],
        Resource = [
          "${var.bucket_a_arn}/*",
          "${var.bucket_b_arn}/*"
        ]
      }
    ]
  })
}
