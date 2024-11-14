output "lambda_function_name" {
  value = aws_lambda_function.image_generator_function.function_name
}

output "sqs_queue_url" {
  value = aws_sqs_queue.image_async_queue.url
}

output "lambda_execution_role_arn" {
  value = aws_iam_role.lambda_execution.arn
}
