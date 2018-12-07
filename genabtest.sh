#!/bin/bash

for i in `seq 1 100`
do
     if [[ i -ge 1 && i -le 5 ]];then
        echo "&vrAbtest=1" >> abt
     elif [[ i -ge 6 && i -le 15 ]];then
        echo "&vrAbtest=2" >> abt
     elif [[ i -ge 16 && i -le 25 ]];then
        echo "&vrAbtest=3" >> abt
     elif [[ i -ge 26 && i -le 50 ]];then
        echo "&vrAbtest=4" >> abt
     elif [[ i -ge 51 && i -le 75 ]];then
        echo "&vrAbtest=5" >> abt
     else
        echo "&vrAbtest=6" >> abt
     fi
done
