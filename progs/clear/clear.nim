import 
    cligen, 
    std/terminal, 
    ../../common/constants

const programName* = "clear"

proc runClear*() =
    eraseScreen()

when isMainModule:
    dispatch(runClear, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
