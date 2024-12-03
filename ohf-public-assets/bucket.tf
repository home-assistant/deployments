resource "cloudflare_r2_bucket" "ohf_public_assets" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "ohf-public-assets"
  location   = "ENAM"
}
