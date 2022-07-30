import 
    cligen, 
    std/os, 
    ../../common/constants

const programName* = "printenv"

proc runPrintenv*() =
    for env in envPairs():
        echo(env.key & "=" & env.value)

when isMainModule:
    dispatch(runPrintenv, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
