
provider "aws" {
  version = "~> 2.0"
  region  = "us-east-1"
}

resource "aws_sqs_queue" "capture_sqs" {
  name                        = "test_sqs.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}



resource "aws_sqs_queue_policy" "capture_sqs_policy" {
  
  queue_url = aws_sqs_queue.capture_sqs.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "aws_sqs_queue.capture_sqs.arn",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": "SQS:*",
      "Resource": "aws_sqs_queue.capture_sqs.arn"
    }
  ]
}
POLICY
}