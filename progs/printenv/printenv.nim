import cligen, std/os, ../../common/constants

proc runPrintenv*() =
    for env in envPairs():
        echo env.key & "=" & env.value

when isMainModule:
    dispatch(runPrintenv, cmdName = "printenv", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
