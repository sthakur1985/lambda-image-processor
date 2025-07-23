
resource "aws_iam_role" "lambda_function_r" {
  name = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_r" {
  name   = "${var.name}-policy"
  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.bucket_a_arn}/*",
      "${var.bucket_b_arn}/*"
    ]
  }

  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  policy_arn = aws_iam_policy.lamda_r.arn
  role       = aws_iam_role.lambda_function.name
}

resource "aws_iam_role" "lambda_function_rw" {
  name = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "lambda_rw" {
  name   = "${var.name}-policy"
  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "lambda" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${var.bucket_a_arn}/*",
      "${var.bucket_b_arn}/*"
    ]
  }

  statement {
    actions = ["logs:*"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "attach" {
  policy_arn = aws_iam_policy.lamda_r.arn
  role       = aws_iam_role.lambda_function.name
}


