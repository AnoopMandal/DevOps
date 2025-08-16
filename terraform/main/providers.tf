provider "aws" {
    region = var.region
    profile = "rashmieks"
    shared_credentials_files = ["/Users/amandal5/.aws/credentials"]
    shared_config_files      = ["/Users/amandal5/.aws/config"]
}