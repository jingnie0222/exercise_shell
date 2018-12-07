#!/bin/bash
current_path=$(pwd)
source $current_path/char_name.sh


#read -p "what is your first name:" F_NAME
#if charname "$F_NAME";then
   #echo "|$F_NAME|"
   #echo "first name is ok"
#else
   #echo "|$F_NAME|"
   #name_error "$F_NAME"
#fi

read -p "what is your first name:" F_NAME
charname $F_NAME
if [ $? -eq 0 ]; then
   echo "|$F_NAME|"
   echo "first name is ok"
else
   name_error "$F_NAME"
fi



#如上代码功能等同于下面的写法

#read -p "what is your first name:" F_NAME
#echo $(charname "$F_NAME")
#([[ $(charname "$F_NAME") == "0" ]] && (echo "|$F_NAME|"; echo "first name is ok" )) || name_error "$F_NAME"
#
#
#read -p "what is your surname:" S_NAME
#[[ $(charname "$S_NAME") == "0" ]] && ( echo "|$S_NAME|" ; echo "surname is ok" )
#name_error "$S_NAME"
