#!/bin/bash

NIMCC="nim"
FLAGS="c -d:release"
SFLAGS="-d:ssl"
STATIC="musl -d:release -d:libressl"
UNIFIED="nimbox.nim"
PROGS=( "basename" "cat" "chmod" "clear" "cmp" "cp" "dirname" "dos2unix" "echo" "false" "hostname" "httpd" "ln" "ls" "md5sum" "mkdir" "more" "mv" "nproc" "printenv" "pwd" "readlink" "rm" "seq" "sh" "sha1sum" "sleep" "touch" "true" "tty" "uname" "unzip" "uptime" "wget" "which" "whoami" "yes" )

if [[ $1 = "unified" ]]
then
    rm build_unified.log > /dev/null 2>&1
    $NIMCC $FLAGS $SFLAGS $UNIFIED >> build_unified.log 2>&1
    
    grep -r "Error" build_unified.log
elif [[ $1 = "all" ]]
then
    rm build_all.log > /dev/null 2>&1

    for i in "${PROGS[@]}"
    do
        if [[ $i = "wget" || $i = "httpd" ]]
        then
            $NIMCC $FLAGS $SFLAGS progs/$i/$i.nim >> build_all.log 2>&1
        else
            $NIMCC $FLAGS progs/$i/$i.nim >> build_all.log 2>&1
        fi
    done
    grep -r "Error" build_all.log
elif [[ $1 = "static" ]]
then
    rm build_unified.log > /dev/null 2>&1
    $NIMCC $STATIC $UNIFIED >> build_unified.log 2>&1
    
    grep -r "Error" build_unified.log
elif [[ $1 = "clean" ]]
then
    rm build_unified.log build_all.log nimbox > /dev/null 2>&1
    for i in "${PROGS[@]}"
    do
        rm progs/$i/$i > /dev/null 2>&1
    done    
else
    echo Needs 1 argument \(unified, static, all, clean\)
fi



