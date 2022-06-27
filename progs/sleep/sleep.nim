import cligen, std/os, strutils, ../../common/constants

proc formatError() =
    echo "sleep: Invalid argument.\nTry \"sleep --help\" for more information."
    quit(1)    

proc runSleep*(duration: seq[string]) =
    if duration.len == 0:
        echo "sleep: Requires at least one argument.\nTry \"sleep --help\" for more information."
        quit(1)
    
    var dur: float
    for d in duration:
        if d.endsWith("s"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000))
            except:
                formatError()

        elif d.endsWith("m"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60))
            except:
                formatError()

        elif d.endsWith("h"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60))
            except:
                formatError()

        elif d.endsWith("d"):
            try:
                dur = parseFloat(d[0..d.high - 1])
                sleep(int(dur * 1000 * 60 * 60 * 24))
            except:
                formatError()
        
        else:
            try:
                dur = parseFloat(d)
                sleep(int(dur * 1000))
            except:
                formatError()            

when isMainModule:
    dispatch(runSleep, cmdName = "sleep", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
