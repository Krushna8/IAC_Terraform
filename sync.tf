terraform {
  backend "s3" {
    bucket = "kops-state852"
    key    = "terra-state/backend"
    region = "ap-south-1"
  }
}
