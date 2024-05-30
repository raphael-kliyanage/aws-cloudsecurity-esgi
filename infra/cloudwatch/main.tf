resource "aws_cloudwatch_log_group" "logging" {
  name = "Logging"

  tags = {
    Environment = "production"
    Application = "serviceA"
  }
}
