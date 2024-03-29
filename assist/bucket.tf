resource "cloudflare_r2_bucket" "assist_wakeword_training_data" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "assist-wakeword-training-data"
  location   = "ENAM"
}

resource "cloudflare_r2_bucket" "assist_wakeword_training_data_test" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "assist-wakeword-training-data-test"
  location   = "ENAM"
}
