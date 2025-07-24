data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]

    
    }
  }
}

data "aws_iam_policy_document" "lambda_r" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${var.bucket_a_arn}/*",
      "${var.bucket_b_arn}/*"
    ]
    effect = "Allow"
  }

  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "lambda_rw" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.bucket_b_arn}/*"
    ]
    effect = "Allow"
  }

  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "lambda_function" {
  name = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}



resource "aws_iam_policy" "policy_r" {
  name   = "${var.name}-r-policy"
  policy = data.aws_iam_policy_document.lambda_r.json
}

resource "aws_iam_policy" "policy_rw" {
  name   = "${var.name}-rw-policy"
  policy = data.aws_iam_policy_document.lambda_rw.json
}

resource "aws_iam_role_policy_attachment" "attach_r" {
  policy_arn = aws_iam_policy.policy_r.arn
  role       = aws_iam_role.lambda_function.name
}

resource "aws_iam_role_policy_attachment" "attach_rw" {
  policy_arn = aws_iam_policy.policy_rw.arn
  role       = aws_iam_role.lambda_function.name
}


