resource "aws_cloudwatch_metric_alarm" "cloudwatch-s3-cpu" {
  alarm_name                = "CPU usage"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = 10
  statistic                 = "Average"
  threshold                 = 80
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []
}


resource "aws_cloudwatch_metric_alarm" "cloudwatch-s3-network" {
  alarm_name                = "Networking incoming traffic"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = 2
  metric_name               = "NetworkIn"
  namespace                 = "AWS/EC2"
  period                    = 10
  statistic                 = "Maximum"
  threshold                 = 5
  alarm_description         = "This metric monitors ec2 network incoming traffic"
  insufficient_data_actions = []
}

# create a logging stream cpu & network incoming traffic
# not working yet
#resource "aws_cloudwatch_metric_stream" "cpu-and-network-in" {
#  name          = "CPU & Networking incoming traffic"
#  role_arn      = aws_iam_role.metric_stream_to_firehose.arn
#  firehose_arn  = aws_kinesis_firehose_delivery_stream.s3_stream.arn
#  output_format = "json"
#
#  include_filter {
#    namespace    = "AWS/EC2"
#    metric_names = ["CPUUtilization", "NetworkIn"]
#  }
#
#  include_filter {
#    namespace    = "AWS/EBS"
#    metric_names = []
#  }
#}
