import cligen, std/os, strutils, ../../common/constants, ../../common/utils

const programName* = "basename"

proc runBasename*(paths: seq[string], suffix: string = "") =
    if paths.len == 0:
        errorMessage(programName, "Needs at least 1 argument.\nTry \"basename --help\" for more information.", true)

    for p in paths:
        var (_, tail) = splitPath(p)
        if suffix != "":
            if tail.endsWith(suffix):
                tail = tail[0..<(tail.len - suffix.len)]

        echo tail

when isMainModule:
    dispatch(runBasename, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "suffix": "Remove suffix."}, 
            short = {"version": 'v', "suffix": 's'})
