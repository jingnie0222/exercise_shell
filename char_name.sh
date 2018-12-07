#!/bin/bash
#check name contains only letter

function charname()
{
    # $1 means the first parameter
    #_OnlyLetter=`echo "$1" | awk '{if(match($0,/[^a-zA-Z]/)) print "1"}'`
    _OnlyLetter=$(echo "$1" | awk '{if(match($0,/[^a-zA-Z]/)) print "1"}')
    [[ $_OnlyLetter == "1" ]] && return 1
    return 0
}

function name_error()
#print error message
{ 
    echo "$@ contains errors,it must contains only letters"
}
