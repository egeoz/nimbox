import cligen, posix_utils, ../../common/constants

proc runHostname*() =
    let un = uname()
    echo un.nodename

when isMainModule:
    dispatch(runHostname, cmdName = "hostname", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
