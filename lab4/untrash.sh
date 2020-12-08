#!/bin/bash

TRDIR="/home/user/.trash/"
TRLOG="/home/user/.trash.log"
HOM="/home/user"

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

if [[ ! -d $TRDIR ]];
then
    echo "Directory not found"
    exit 1
fi

if [[ ! -f $TRLOG ]];
then
    echo "Log file not found"
    exit 1
fi

if [ ! "`echo $1 | sed 's/[a-z,0-9,_,-]*//'`" == "" ];
then
    echo "Bad input"
    exit 1
fi

file=$1
a=""
num=""
for i in $(grep "$1" $TRLOG | awk '{print $1}');
do
    a=$(echo $i | sed -e 's,/home/user/lab4/,,')
    if [ $a == $file ];
    then
        break;
    fi
done

if [ $a == $file ];
    then
        echo "nice!"
    else
        echo "error"
        exit 1
fi


for i in $(grep "$1" $TRLOG | awk '{print $NF}');
do
    FN=$(grep $i $TRLOG | awk '{$NF=""; print $0}')
    FN=$(echo "$FN" | sed 's/ *$//')
    read -p "${FN} Are you sure?: [y/n] " ans
    case "$ans" in
        "y")
            NFN=""
            TN=$i
            RDIR=$(echo "$FN" | awk 'BEGIN{FS=OFS="/"}; {$NF=""; print $0}')
            FNN=$(echo "$FN" | awk 'BEGIN{FS="/"}; {print $NF}')
            if [[ ! -d $RDIR ]];
            then
                echo "Directory ${RDIR} not found. File \"${FNN}\" restored in HomeDirectory"
                if [[ -f "${HOM}/${FNN}" ]];
                then
                    read -p "File \"${HOM}/${FNN}\" already exist. Add new name: " NFN
                    ln "${TRDIR}/${TN}" "${HOM}/${NFN}"
                    rm "${TRDIR}/${TN}"
                else
                    ln "${TRDIR}/${TN}" "${HOM}/${FNN}"
                    rm "${TRDIR}/${TN}"
                fi
            else
                if [[ -f "${FN}" ]];
                then
                    read -p "File \"${FN}\" already exist. Add new name: " NFN
                    ln "${TRDIR}/${TN}" "${RDIR}/${NFN}"
                    rm "${TRDIR}/${TN}"
                else
                    ln "${TRDIR}/${TN}" "${FN}"
                    rm "${TRDIR}/${TN}"
                fi
            fi
            sed "/${i}/d" $TRLOG > .trash.log2 && mv .trash.log2 $TRLOG
            echo "Success!"
            continue
        ;;
        *)
            continue
        ;;
    esac
done