import 
    cligen, 
    ../../common/constants

const programName* = "yes"

proc runYes*(strings: seq[string]) =
    while true:
        if strings.len == 0:
            echo("y")
        else:
            echo(join(strings," "))

when isMainModule:
    dispatch(runYes, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
