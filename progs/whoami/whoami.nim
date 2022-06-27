import cligen, std/os, ../../common/constants

proc runWhoami*() =
    # implement a proper method
    echo getEnv("USER")

when isMainModule:
    dispatch(runWhoami, cmdName = "whoami", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
