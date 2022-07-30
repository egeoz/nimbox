import 
    cligen, 
    std/os, 
    ../../common/constants

const programName* = "pwd"

proc runPwd*() =
    echo(getCurrentDir())

when isMainModule:
    dispatch(runPwd, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
