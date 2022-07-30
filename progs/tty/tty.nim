import 
    cligen, 
    std/os, 
    ../../common/constants

const programName* = "tty"

proc runTty*() =
    # TODO: implement a proper method
    echo getEnv("TTY")

when isMainModule:
    dispatch(runTty, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
