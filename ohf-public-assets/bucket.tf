resource "cloudflare_r2_bucket" "os_build_artifacts" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "ohf-public-assets"
  location   = "ENAM"
}