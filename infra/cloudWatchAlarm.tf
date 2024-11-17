
# variabler
variable "email_address" {
  description = "Epostadressen for alarmvarsler"
  type        = string
}

variable "sqs_queue_name" {
  description = "sqs-køen"
  type        = string
}

# henter sqs-køens arn
data "aws_sqs_queue" "sqs_queue" {
  name = var.sqs_queue_name
}

# sns-topic
resource "aws_sns_topic" "sqs_alarm_topic" {
  name = "sqs-alarm-topic"
}

# sns-sub for e-post
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sqs_alarm_topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}

# alarm config
resource "aws_cloudwatch_metric_alarm" "old-message-sqs-alarm" {
    alarm_name          = "oldestMessage-sqs-alarm-45"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods  = 2
    metric_name         = "ApproximateAgeOfOldestMessage"
    namespace           = "AWS/SQS"
    period              = 120
    statistic           = "Maximum"
    threshold           = 300
    
    dimensions = {
    QueueName = var.sqs_queue_name
  }

  alarm_actions = [aws_sns_topic.sqs_alarm_topic.arn]
  
}