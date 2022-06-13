import cligen, std/os, ../../common/constants

proc runDirname*(paths: seq[string]) =
    if paths.len == 0:
        echo "dirname: Needs at least 1 argument.\nTry \"dirname --help\" for more information."
        quit(1)

    for p in paths:
        var (head, _) = splitPath(p)

        echo head

when isMainModule:
    dispatch(runDirname, cmdName = "dirname", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
