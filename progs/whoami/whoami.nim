import cligen, std/os, ../../common/constants

const programName* = "whoami"

proc runWhoami*() =
    # implement a proper method
    echo getEnv("USER")

when isMainModule:
    dispatch(runWhoami, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
