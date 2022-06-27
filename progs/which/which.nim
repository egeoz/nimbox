import cligen, std/os, strformat, ../../common/constants

proc runWhich*(files: seq[string]) =
    for f in files:
        let result = findExe(f)
        if result == "": echo &"which: \"{f}\" not found"
        else: echo result
    
when isMainModule:
    dispatch(runWhich, cmdName = "which", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
