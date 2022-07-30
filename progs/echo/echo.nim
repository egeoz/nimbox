import 
    cligen, 
    ../../common/constants

const programName* = "echo"

proc runEcho*(strings: seq[string]) =
    for str in strings:
        echo(str)

when isMainModule:
    dispatch(runEcho, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
