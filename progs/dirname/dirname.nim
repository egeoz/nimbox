import 
    cligen, 
    std/os, 
    ../../common/constants, 
    ../../common/utils

const programName* = "dirname"

proc runDirname*(paths: seq[string]) =
    if paths.len == 0:
        errorMessage(programName, "Needs at least 1 argument.\nTry \"dirname --help\" for more information.", true)

    for p in paths:
        var (head, _) = splitPath(p)
        echo(head)

when isMainModule:
    dispatch(runDirname, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
