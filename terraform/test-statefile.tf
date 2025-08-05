terraform {
  backend "s3" {
    bucket  = "anoop-clouddevopslabs"
    key     = "infra.tfstate"
    region  = "ap-south-1"
    profile = "rashmieks"
    #dynamodb_table = "terraform-statefile"
    use_lockfile = "false"
  }
}