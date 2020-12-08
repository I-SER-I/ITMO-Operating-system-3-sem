#!/bash/bash

if [[ $# > 1 ]]; 
then
    echo "Many arguments"
    exit 1
fi

if [[ $# < 1 ]]; 
then
    echo "Few arguments"
    exit 1
fi

if [[ ! -f $1 ]]; 
then
    echo "File not found"
    exit 1
fi

if [[ ! -e "/home/user/.trash" ]];
then
    mkdir /home/user/.trash
fi

value=$(find "/home/user/.trash/" -type f -name "[1-9]" | sed -e 's,.trash/,,')
value=$(echo $value | awk '{print NF}')

if [ -z $value ];
then
    ln "/home/user/lab4/"$1 "/home/user/.trash/1"
else
    value=$(($value + 1))
    ln "/home/user/lab4/"$1 "/home/user/.trash/"$value
fi

echo $(readlink -f $1) $value  >> /home/user/.trash.log
rm $1