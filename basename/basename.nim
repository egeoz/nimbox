import cligen, std/os, strutils, "../nimland.nim"

proc runBasename*(paths: seq[string], suffix: string = "") =
    if paths.len == 0:
        echo "basename: Needs at least 1 argument.\nTry \"basename --help\" for more information."
        quit(1)

    for p in paths:
        var (_, tail) = splitPath(p)
        if suffix != "":
            if tail.endsWith(suffix):
                tail = tail[0..<(tail.len - suffix.len)]

        echo tail

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runBasename, cmdName = "basename", help = {"help": "Display this help page.", "version": "Show version info.", "suffix": "Remove suffix."}, 
            short = {"version": 'v', "suffix": 's'})
