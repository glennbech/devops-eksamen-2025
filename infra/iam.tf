#iam rolle for at lambda skal kunne bruke sqs actions, legge til objekter i s3 bucket og invoke bedrock modellen
resource "aws_iam_role" "lambda_execution" {
  name = "lambda_execution_45_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "lambda_sqs_45_policy" {
  name        = "lambda_sqs_45_policy"
  description = "IAM policy for Lambda to access SQS and S3"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes"
        ],
        Effect   = "Allow",
        Resource = aws_sqs_queue.image_async_queue.arn
      },
      {
        Action   = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:s3:::pgr301-couch-explorers/*",
        Resource = "arn:aws:s3:::pgr301-2024-terraform-state/*"
      },
      {
        Action   = "bedrock:InvokeModel",
        Effect   = "Allow",
        Resource = "arn:aws:bedrock:us-east-1::foundation-model/amazon.titan-image-generator-v1"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_sqs_45_policy" {
  role       = aws_iam_role.lambda_execution.name
  policy_arn = aws_iam_policy.lambda_sqs_45_policy.arn
}
