#ressurs for å opprette lambda funksjonen
resource "aws_lambda_function" "image_generator_function" {
  filename         = "lambda_sqs.zip"
  function_name    = "image-Generator-Function-45"
  role             = aws_iam_role.lambda_execution.arn
  handler          = "lambda_sqs.lambda_handler"
  runtime          = "python3.8"
  timeout          = 30
    
  #s3 bucket for lagring av bilder
  environment {
    variables = {
      S3_BUCKET = "pgr301-couch-explorers"
    }
  }
}

#kobler sqs køen med lambda funksjonen når funksjonen kjøres, med 10 meldinger per batch
resource "aws_lambda_event_source_mapping" "sqs_trigger" {
  event_source_arn = aws_sqs_queue.image_async_queue.arn
  function_name    = aws_lambda_function.image_generator_function.arn
  batch_size       = 10
}