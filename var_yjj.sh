#!/bin/bash
# test for shell varibles

# $var返回变量值
# ${var}返回变量值
# ${#var}返回变量字符串的长度

var1=barry
echo "\$var1 = $var1"
echo "\${var1} = ${var1}"
echo "\${#var1} = ${#var1}"

# ${var:start_index}返回从start_index开始一直到字符串末尾。start_index为0表示从第一个字符开始，start_index为0-x，表示从倒数第x个字符开始。
# ${var:start_index:length}返回从start_index开始的length个字符，length可以为负值，-x表示剩余x个字符不要。

var2=0123456789
echo "\${var2:0} = ${var2:0}"
echo "\${var2:5} = ${var2:5}"
echo "\${var2:0-3} = ${var2:0-3}"

echo "\${var2:2:5} = ${var2:2:5}"
#echo "\${var2:5:-2} = ${var2:5:-2}"  ### bash版本不支持-2
#echo "\${var2:0-3:-1} = ${var2:0-3:-1}"  ### bash版本不支持-2
echo "\${var2:5:-2} = ${var2:5:$((${#var2}-2))}"
echo "\${var2:0-3:-1} = ${var2:0-3:$[${#var2}-1]}"    ### []运算符和(())运算符一样


# ${var#string}返回从左边删除string后的字符串，尽量短的匹配被删字符串
# ${var##string}返回从左边删除string后的字符串，尽量长的匹配被删字符串
# ${var%string}返回从右边删除string后的字符串，尽量短的匹配被删字符串
# ${var%%string}返回从右边删除string后的字符串，尽量长的匹配被删字符串

var3="http://127.0.0.1/index.php"
echo "\${var3#*/} = ${var3#*/}"
echo "\${var3##*/} = ${var3##*/}"    ###获取文件名,相当于basename
echo "\${var3%/*} = ${var3%/*}"      ###获取目录，相当于dirname
echo "\${var3%%/*} = ${var3%%/*}"


# ${var/substring/newstring}返回var中第一个substring被替换成newstring后的字符串。
# ${var//substring/newstring}返回var中所有的substring被替换成newstring后的字符串。

var4=08880
newstring=hello
echo "\${var4/0/newstring} = ${var4/0/$newstring}"
echo "\${var4//0/newstring} = ${var4//0/$newstring}"


# ${var:-string}如果var为空值或者未定义，则返回string，如果var不为空则返回var的值。
# ${var:=string}如果var为空值或者未定义，则返回string，并把string赋给var，如果var不为空则返回var的值。
# ${var:+string}如果var不为空，则返回string，如果var为空则返回空值。
# ${var:?string}如果var为空值或者未定义，则将string写入标准错误流，该语句失败。如果var不为空则返回原值。

echo "\${var_a:-abcd} = ${var_a:-abcd}";echo "\$var_a = $var_a"
echo "\$var_b = $var_b";echo "\${var_b:=1234} = ${var_b:=1234}";echo "\$var_b = $var_b"

