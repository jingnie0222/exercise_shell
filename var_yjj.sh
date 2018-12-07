#!/bin/bash
# test for shell varibles

# $var���ر���ֵ
# ${var}���ر���ֵ
# ${#var}���ر����ַ����ĳ���

var1=barry
echo "\$var1 = $var1"
echo "\${var1} = ${var1}"
echo "\${#var1} = ${#var1}"

# ${var:start_index}���ش�start_index��ʼһֱ���ַ���ĩβ��start_indexΪ0��ʾ�ӵ�һ���ַ���ʼ��start_indexΪ0-x����ʾ�ӵ�����x���ַ���ʼ��
# ${var:start_index:length}���ش�start_index��ʼ��length���ַ���length����Ϊ��ֵ��-x��ʾʣ��x���ַ���Ҫ��

var2=0123456789
echo "\${var2:0} = ${var2:0}"
echo "\${var2:5} = ${var2:5}"
echo "\${var2:0-3} = ${var2:0-3}"

echo "\${var2:2:5} = ${var2:2:5}"
#echo "\${var2:5:-2} = ${var2:5:-2}"  ### bash�汾��֧��-2
#echo "\${var2:0-3:-1} = ${var2:0-3:-1}"  ### bash�汾��֧��-2
echo "\${var2:5:-2} = ${var2:5:$((${#var2}-2))}"
echo "\${var2:0-3:-1} = ${var2:0-3:$[${#var2}-1]}"    ### []�������(())�����һ��


# ${var#string}���ش����ɾ��string����ַ����������̵�ƥ�䱻ɾ�ַ���
# ${var##string}���ش����ɾ��string����ַ�������������ƥ�䱻ɾ�ַ���
# ${var%string}���ش��ұ�ɾ��string����ַ����������̵�ƥ�䱻ɾ�ַ���
# ${var%%string}���ش��ұ�ɾ��string����ַ�������������ƥ�䱻ɾ�ַ���

var3="http://127.0.0.1/index.php"
echo "\${var3#*/} = ${var3#*/}"
echo "\${var3##*/} = ${var3##*/}"    ###��ȡ�ļ���,�൱��basename
echo "\${var3%/*} = ${var3%/*}"      ###��ȡĿ¼���൱��dirname
echo "\${var3%%/*} = ${var3%%/*}"


# ${var/substring/newstring}����var�е�һ��substring���滻��newstring����ַ�����
# ${var//substring/newstring}����var�����е�substring���滻��newstring����ַ�����

var4=08880
newstring=hello
echo "\${var4/0/newstring} = ${var4/0/$newstring}"
echo "\${var4//0/newstring} = ${var4//0/$newstring}"


# ${var:-string}���varΪ��ֵ����δ���壬�򷵻�string�����var��Ϊ���򷵻�var��ֵ��
# ${var:=string}���varΪ��ֵ����δ���壬�򷵻�string������string����var�����var��Ϊ���򷵻�var��ֵ��
# ${var:+string}���var��Ϊ�գ��򷵻�string�����varΪ���򷵻ؿ�ֵ��
# ${var:?string}���varΪ��ֵ����δ���壬��stringд���׼�������������ʧ�ܡ����var��Ϊ���򷵻�ԭֵ��

echo "\${var_a:-abcd} = ${var_a:-abcd}";echo "\$var_a = $var_a"
echo "\$var_b = $var_b";echo "\${var_b:=1234} = ${var_b:=1234}";echo "\$var_b = $var_b"

