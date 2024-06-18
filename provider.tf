provider "aws" {
  shared_config_files      = [var.config_path]
  shared_credentials_files = [var.credential_path]
  #profile = "default"
}
