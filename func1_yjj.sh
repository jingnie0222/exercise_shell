#!/bin/bash
#test func

function hello ()
{
  echo "hello,today is `date`"
}

echo "now going to the function hello"
hello
echo "back from the function hello"
