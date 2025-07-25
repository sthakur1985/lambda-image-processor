# Assumed Role Policy for Lambda
data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# IAM Policy: Lambda can read/write to Bucket A
resource "aws_iam_policy" "lambda_rw_bucket_a" {
  name = "lambda-rw-bucket-a-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${var.bucket_a_arn}",
          "${var.bucket_a_arn}/*"
        ]
      }
    ]
  })
}

# IAM Policy: Lambda can read from Bucket B
resource "aws_iam_policy" "lambda_ro_bucket_b" {
  name = "lambda-ro-bucket-b-policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${var.bucket_b_arn}",
          "${var.bucket_b_arn}/*"
        ]
      }
    ]
  })
}

# IAM Role for Lambda function
resource "aws_iam_role" "lambda_function" {
  name               = "${var.name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# Attach Read/Write policy to Lambda Role
resource "aws_iam_role_policy_attachment" "attach_rw_bucket_a" {
  role       = aws_iam_role.lambda_function.name
  policy_arn = aws_iam_policy.lambda_rw_bucket_a.arn
}

# Attach Read-only policy to Lambda Role
resource "aws_iam_role_policy_attachment" "attach_ro_bucket_b" {
  role       = aws_iam_role.lambda_function.name
  policy_arn = aws_iam_policy.lambda_ro_bucket_b.arn
}

