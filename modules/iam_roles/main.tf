data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]

    
    }
  }
}

resource "aws_iam_user_policy" "lambda_b_policy" {
  name = "lambda-bucket-b-policy"
  user = aws_iam_user.user_a.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject", "s3:ListBucket"],
        Resource = [
          "arn:aws:s3:::${var.bucket_a_name}",
          "arn:aws:s3:::${var.bucket_a_name}/*"
        ]
      }
    ]
  })
}

 

resource "aws_iam_policy" "lambda_a_policy" {
  name = "lambda-bucket-a-policy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = ["s3:GetObject", "s3:ListBucket"],
        Resource = [
          "arn:aws:s3:::${var.bucket_b_name}",
          "arn:aws:s3:::${var.bucket_b_name}/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role" "lambda_function" {
  name = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



resource "aws_iam_role_policy_attachment" "attach_r" {
  policy_arn = aws_iam_policy.lambda_a_policy.arn
  role       = aws_iam_role.lambda_function.name
}

resource "aws_iam_role_policy_attachment" "attach_rw" {
  policy_arn = aws_iam_policy.lambda_b_policy.arn
  role       = aws_iam_role.lambda_function.name
}


