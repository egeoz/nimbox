import cligen, std/os, ../../common/constants

proc runTty*() =
    # implement a proper method
    echo getEnv("TTY")

when isMainModule:
    dispatch(runTty, cmdName = "tty", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
