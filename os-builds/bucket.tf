resource "cloudflare_r2_bucket" "os_build_artifacts" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "os-build-artifacts"
  location   = "ENAM"
}

resource "cloudflare_r2_bucket" "os_build_cache" {
  account_id = var.CLOUDFLARE_ACCOUNT_ID
  name       = "os-build-cache"
  location   = "ENAM"
}