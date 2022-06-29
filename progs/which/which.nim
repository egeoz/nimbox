import cligen, std/os, strformat, ../../common/constants, ../../common/utils

const programName* = "which"

proc runWhich*(files: seq[string]) =
    for f in files:
        let result = findExe(f)
        if result == "": errorMessage(programName, &"\"{f}\" not found.")
        else: echo result
    
when isMainModule:
    dispatch(runWhich, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
