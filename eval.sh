#!/bin/sh

echo "eg1:"
message=hello
hello="good morning"
echo $message
eval message=\$$message
echo $message

echo
echo "eg2:"
message2=world
world="good bye"
echo ${message2}
echo ${!message2}


a=b
b=c
eval echo \$$a
