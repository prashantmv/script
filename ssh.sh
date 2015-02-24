#!/bin/bash
echo "please enter value for protocol"
read a
var=`curl -s ifconfig.me`
group=`aws ec2 describe-instances --filter Name=tag:Name,Values=nginx2 --output json --query 'Reservations[*].Instances[*].SecurityGroups[*].GroupId' --output text`
#open function
echo $b
open_ssh()      
{
echo "open"
echo $group
echo $var
aws ec2 authorize-security-group-ingress --group-id $1 --protocol tcp --port 22 --cidr $2/32
}

#close function
close_ssh()
{
echo "close"
echo $group
echo $var
aws ec2 revoke-security-group-ingress --group-id $1 --protocol tcp --port 22 --cidr $2/32
}

case $a in
 1)
open_ssh $group $var
;;
 2)
close_ssh $group $var
;;
esac
