resource "aws_s3_bucket" "my_bucket" {
bucket = var.bucket_name

tags = {
Name        = "My S3 Bucket"
Environment = "Dev"
}
}

# Define the encryption key for the volume
resource "aws_kms_key" "my_aes_key" {
  description = "KMS key for AES volume encryption"
  key_usage   = "ENCRYPT_DECRYPT"
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

# EC2 Key Pair (Optional: to connect to the instance via SSH)
resource "aws_key_pair" "ec2_key" {
  key_name   = "my-key-pair"
  public_key = file("~/.ssh/id_rsa.pub") # Replace with your SSH public key path
}
