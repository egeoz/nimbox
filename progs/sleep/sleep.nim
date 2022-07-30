import 
    cligen, 
    std/os, 
    strutils, 
    ../../common/constants, 
    ../../common/utils

const programName* = "sleep"

proc runSleep*(duration: seq[string]) =
    if duration.len == 0:
        errorMessage(programName, "sleep: Requires at least one argument.\nTry \"sleep --help\" for more information.", true)

    var dur: float
    for d in duration:
        try:
            if d.endsWith("s"):
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000))

            elif d.endsWith("m"):
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60))

            elif d.endsWith("h"):
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60))

            elif d.endsWith("d"):
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60 * 24))

            else:
                dur = parseFloat(d)
                sleep(int(dur * 1000))

        except:
            errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)

when isMainModule:
    dispatch(runSleep, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
