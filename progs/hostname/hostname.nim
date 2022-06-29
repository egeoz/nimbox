import cligen, posix_utils, ../../common/constants

const programName* = "hostname"

proc runHostname*() =
    let un = uname()
    echo un.nodename

when isMainModule:
    dispatch(runHostname, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
