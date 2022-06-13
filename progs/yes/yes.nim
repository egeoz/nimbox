import cligen, ../../common/constants

proc runYes*(strings: seq[string]) =
    while true:
        if strings.len == 0:
            stdout.writeLine("y")
        else:
            stdout.writeLine(join(strings," "))

when isMainModule:
    dispatch(runYes, cmdName = "yes", help = {"help": "Display this help page.", "version": "Show version info."}, 
                short = {"version": 'v'})
