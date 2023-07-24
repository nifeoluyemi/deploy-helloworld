/**
* # VPC module
* The VPC module is used to create an AWS VPC.
*/


resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
}