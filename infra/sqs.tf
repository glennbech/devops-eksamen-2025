
#oppretter en sqs resource for å motta bilder asynkront fra lambda_sqs.py

resource "aws_sqs_queue" "image_async_queue" {
    name = "image_async_queue"
}