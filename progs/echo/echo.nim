import cligen, ../../common/constants

proc runEcho*(strings: seq[string]) =
    for str in strings:
        echo str

when isMainModule:
    dispatch(runEcho, cmdName = "echo", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
