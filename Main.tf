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
# Launch an EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0c02fb55956c7d316" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.ec2_key.key_name
  security_groups = [aws_security_group.ec2_sg.name]

  root_block_device {
    volume_size = 8
    encrypted   = true # Enable AES encryption for the root volume
  }

  tags = {
    Name = "My-AES-Instance"
  }
}
