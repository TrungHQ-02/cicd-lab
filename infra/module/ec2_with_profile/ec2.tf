resource "aws_iam_instance_profile" "example_instance_profile" {
  count = var.enable_role ? 1 : 0

  ###############

  name = var.role_name
  role = data.aws_iam_role.example[0].name

  ###############

  tags = merge(var.tags, {
    Name = "${var.role_name}-profile"
  })
}

resource "aws_key_pair" "ssh_auth" {
  count = var.has_key_pair ? 1 : 0

  ###############

  key_name   = var.key_pair_name
  public_key = file(var.key_pair_path)

  ###############

  tags = merge(var.tags, {
    Name = "${var.key_pair_name}"
  })
}

resource "aws_instance" "ec2_instance" {
  ami           = var.ami
  instance_type = var.instance_type

  subnet_id              = data.aws_subnet.example[0].id
  vpc_security_group_ids = [data.aws_security_group.security_group.id]
  user_data              = var.user_data

  key_name = var.has_key_pair ? aws_key_pair.ssh_auth[0].key_name : null

  iam_instance_profile = var.enable_role == 1 ? aws_iam_instance_profile.example_instance_profile[0].name : null

  tags = merge(var.tags, {
    Name = var.instance_name
  })
}

resource "aws_ebs_volume" "ebs_volume" {
  count = var.has_ebs ? 1 : 0

  availability_zone = aws_instance.ec2_instance.availability_zone
  size              = var.ebs_volume_size
  tags = merge(var.tags, {
    Name : "Volume-${var.ebs_device_name}-${var.ebs_volume_size}"
  })
}

resource "aws_volume_attachment" "example" {
  count = var.has_ebs ? 1 : 0


  device_name = var.ebs_device_name
  volume_id   = aws_ebs_volume.ebs_volume[0].id
  instance_id = aws_instance.ec2_instance.id
}

