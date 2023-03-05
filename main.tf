resource "aws_instance" "Sahar" {
  ami           = "ami-0557a15b87f6559cf"
  instance_type = "t1.micro"

  tags = {
    Created_by = "Sahar and terraform"
  }
}
