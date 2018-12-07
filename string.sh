#!/bin/sh

echo ${PWD%%a*}
echo ${PWD%a*}

var="telephone"
echo ${var:0:4}
