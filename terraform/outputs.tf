output "instance_ip" {
  value = aws_instance.demo-vm.public_ip
}
output "instance_id" {
  value = aws_instance.demo-vm.id
}
