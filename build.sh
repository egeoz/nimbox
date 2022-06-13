#!/bin/bash

NIMCC="/home/ege/.nimble/bin/nim"
FLAGS="c -d:release"
SFLAGS="-d:ssl"
UNIFIED="nimbox.nim"

if [[ $1 = "unified" ]]
then
    rm build_unified.log
    $NIMCC $FLAGS $SFLAGS $UNIFIED >> build_unified.log 2>&1
    
    grep -r "Error" build_unified.log
elif [[ $1 = "all" ]]
then
    rm build_all.log
    $NIMCC $FLAGS basename/basename.nim >> build_all.log 2>&1
    $NIMCC $FLAGS cat/cat.nim >> build_all.log 2>&1
    $NIMCC $FLAGS clear/clear.nim >> build_all.log 2>&1
    $NIMCC $FLAGS cp/cp.nim >> build_all.log 2>&1
    $NIMCC $FLAGS dirname/dirname.nim >> build_all.log 2>&1
    $NIMCC $FLAGS echo/echo.nim >> build_all.log 2>&1
    $NIMCC $FLAGS false/false.nim >> build_all.log 2>&1
    $NIMCC $FLAGS httpd/httpd.nim >> build_all.log 2>&1
    $NIMCC $FLAGS mkdir/mkdir.nim >> build_all.log 2>&1
    $NIMCC $FLAGS more/more.nim >> build_all.log 2>&1
    $NIMCC $FLAGS mv/mv.nim >> build_all.log 2>&1
    $NIMCC $FLAGS nproc/nproc.nim >> build_all.log 2>&1
    $NIMCC $FLAGS printenv/printenv.nim >> build_all.log 2>&1
    $NIMCC $FLAGS pwd/pwd.nim >> build_all.log 2>&1
    $NIMCC $FLAGS rm/rm.nim >> build_all.log 2>&1
    $NIMCC $FLAGS touch/touch.nim >> build_all.log 2>&1
    $NIMCC $FLAGS true/true.nim >> build_all.log 2>&1
    $NIMCC $FLAGS uname/uname.nim >> build_all.log 2>&1
    $NIMCC $FLAGS uptime/uptime.nim >> build_all.log 2>&1
    $NIMCC $FLAGS $SFLAGS wget/wget.nim >> build_all.log 2>&1
    $NIMCC $FLAGS yes/yes.nim >> build_all.log 2>&1

    grep -r "Error" build_all.log
else
    echo Needs 1 argument \(unified or all\)
fi



