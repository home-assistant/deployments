resource "aws_s3_bucket" "assist_wakeword_training_data" {
  bucket = "assist-wakeword-training-data-${local.environment}"
}
