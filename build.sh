#!/bin/bash

NIMCC="nim"
FLAGS="c -d:release"
SFLAGS="-d:ssl"
STATIC="musl -d:release -d:libressl"
UNIFIED="nimbox.nim"

if [[ $1 = "unified" ]]
then
    rm build_unified.log > /dev/null 2>&1
    $NIMCC $FLAGS $SFLAGS $UNIFIED >> build_unified.log 2>&1
    
    grep -r "Error" build_unified.log
elif [[ $1 = "all" ]]
then
    rm build_all.log > /dev/null 2>&1
    $NIMCC $FLAGS progs/basename/basename.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/cat/cat.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/clear/clear.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/cp/cp.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/dirname/dirname.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/echo/echo.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/false/false.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/httpd/httpd.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/ln/ln.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/mkdir/mkdir.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/more/more.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/mv/mv.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/nproc/nproc.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/printenv/printenv.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/pwd/pwd.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/rm/rm.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/sh/sh.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/sleep/sleep.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/touch/touch.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/true/true.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/uname/uname.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/uptime/uptime.nim >> build_all.log 2>&1
    $NIMCC $FLAGS $SFLAGS progs/wget/wget.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/which/which.nim >> build_all.log 2>&1
    $NIMCC $FLAGS progs/yes/yes.nim >> build_all.log 2>&1

    grep -r "Error" build_all.log
elif [[ $1 = "static" ]]
then
    rm build_unified.log > /dev/null 2>&1
    $NIMCC $STATIC $UNIFIED >> build_unified.log 2>&1
    
    grep -r "Error" build_unified.log
else
    echo Needs 1 argument \(unified or all\)
fi



