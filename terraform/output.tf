output "Public_IP_for_Server1" {
    value = "${aws_instance.rhcsa8-server1.*.public_ip}"
}
#output "Private_IP_for_Server1" {
#    value = "${aws_instance.rhcsa8-server1.*.private_ip}"
#}
output "Public_IP_for_Server2" {
    value = "${aws_instance.rhcsa8-server2.*.public_ip}"
}
#output "Private_IP_for_Server2" {
#    value = "${aws_instance.rhcsa8-server2.*.private_ip}"
#}