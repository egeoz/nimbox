import cligen, std/os, strutils, ../../common/constants, ../../common/utils

const programName* = "sleep"

proc runSleep*(duration: seq[string]) =
    if duration.len == 0:
        errorMessage(programName, "sleep: Requires at least one argument.\nTry \"sleep --help\" for more information.", true)

    var dur: float
    for d in duration:
        if d.endsWith("s"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000))
            except:
                errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)

        elif d.endsWith("m"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60))
            except:
                errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)

        elif d.endsWith("h"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60))
            except:
                errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)

        elif d.endsWith("d"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60 * 24))
            except:
                errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)
        
        else:
            try:
                dur = parseFloat(d)
                sleep(int(dur * 1000))
            except:
                errorMessage(programName, "Invalid argument.\nTry \"sleep --help\" for more information.", true)          

when isMainModule:
    dispatch(runSleep, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
