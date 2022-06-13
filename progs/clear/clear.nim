import cligen, std/terminal, ../../common/constants

proc runClear*() =
    eraseScreen()

when isMainModule:
    dispatch(runClear, cmdName = "clear", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
