import 
    cligen, 
    std/os, 
    strformat, 
    ../../common/constants, 
    ../../common/utils

const programName* = "readLink"

proc runReadlink*(files: seq[string], verbose: bool = false, nonewline: bool = false) =
    if files.len == 0: errorMessage(programName, "Needs at least 1 argument.\nTry \"readlink --help\" for more information.")

    for fileName in files:
        try:
            if nonewline: print(expandSymlink(fileName) & " ")
            else: echo(expandSymlink(fileName))

        except OSError:
            if verbose: errorMessage(programName, &"{fileName}: No such file or directory.")
            else: discard

when isMainModule:
    dispatch(runReadlink, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "nonewline": "Print each result on the same line."}, short = {"verbose": 'v', "nonewline": 'n'})
         
