#!/bin/bash

output_type="json"

usage()
{
    #echo
    #echo "sec_scan_proxy.sh options:"
    #echo -e "\t\t   apply -u username -p password -m maillist"
    #echo -e "\t\t   register -u username -p password -d department -r project"
    echo "sec_scan_proxy.sh [ apply | register ]"
    echo -e "\t\t apply: -u username -p password -m maillist"
    echo -e "\t\t register: -u username -p password -d department -r project"
    echo -e "\t\t -t: output in txt, support json and txt, default json"
    exit 1
}

_apply()
{
    while getopts "u:p:m:t:q:" opt
    do
        case "$opt" in
            u)
                username="$OPTARG"
                ;;
            m)
                maillist="$OPTARG"
                ;;
            p)
                password="$OPTARG"
                ;;
            q)
                qps="$OPTARG"
                ;;
            t)
                output_type="txt"
                ;;
            \?)
                usage
                ;;
        esac
    done

    if [ ${#username} -eq 0 -o ${#password} -eq 0 -o ${#maillist} -eq 0 ] ;then
        usage
    fi
    
    #echo "$username"
    #echo "$password"
    #echo "$maillist"
    #echo "$qps"
    if [ $output_type = "txt" ]; then
        if [ -n $qps ]; then
            ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/apply.php" --data "username=$username&password=$password&maillist=$maillist&return_type=txt&qps=$qps"`
        else
            ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/apply.php" --data "username=$username&password=$password&maillist=$maillist&return_type=txt"`
        fi
    else
        if [ -n $qps ]; then
            ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/apply.php" --data "username=$username&password=$password&maillist=$maillist&qps=$qps"`
        else
            ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/apply.php" --data "username=$username&password=$password&maillist=$maillist"`
        fi
    fi
    sleep 2
    echo "$ret"
}

_register()
{
    while getopts "u:p:d:r:t" opt
    do
        case "$opt" in
            u)
                username="$OPTARG"
                ;;
            p)
                password="$OPTARG"
                ;;
            d)
                department="$OPTARG"
                ;;
            r)
                project="$OPTARG"
                ;;
            t)
                output_type="txt"
                ;;
            \?)
                usage
                ;;
        esac
    done

    if [ ${#username} -eq 0 -o ${#password} -eq 0 -o ${#department} -eq 0 -o ${#project} -eq 0 ] ;then
        usage
    fi

    #echo "$username"
    #echo "$password"
    #echo "$department"
    #echo "$project"
    
    if [ $output_type = "txt" ]; then
        ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/register.php" --data "username=$username&password=$password&department=$department&project=$project&return_type=txt"`
    else
        ret=`curl -s "https://sec.sogou-inc.com/proxy/itf/register.php" --data "username=$username&password=$password&department=$department&project=$project"`
    fi
    echo "$ret"
}

case $1 in
    apply)
        if [ $# -lt 7 ]; then
            usage
        fi
        shift
        _apply "$@"
        ;;
    register)
        if [ $# -lt 9 ]; then
            usage
        fi
        shift
        _register "$@"
        ;;
    *)
        #echo Unsupported instruction: $1
        #echo 'Expecting one of [ apply | register ]'
        usage
        ;;
esac

