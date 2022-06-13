import cligen, std/os, ../../common/constants

proc runPwd*() =
    echo getCurrentDir()

when isMainModule:
    dispatch(runPwd, cmdName = "pwd", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
