# Define the IAM Role
resource "aws_iam_role" "ssm_role" {
  provider = aws.useast1
  name     = "ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Attach the AmazonSSMManagedInstanceCore policy to the IAM Role
resource "aws_iam_role_policy_attachment" "ssm" {
  provider   = aws.useast1
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "ssm_profile" {
  provider = aws.useast1
  name     = "ssm_profile"
  role     = aws_iam_role.ssm_role.name
}

# Define the Bastion Host EC2 Instance
resource "aws_instance" "bastion" {
  provider                    = aws.useast1
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.useast1_public[0].id
  iam_instance_profile        = aws_iam_instance_profile.ssm_profile.name
  associate_public_ip_address = true
  tags = {
    Name = "BastionHost"
  }
}
