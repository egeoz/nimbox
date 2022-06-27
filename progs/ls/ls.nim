import cligen, std/os, strformat, strutils, ../../common/constants

proc listDir(long, all, p, color: bool, path: string): string =
    let seperator = if long: "\n" else: "\t"
    result = &"\n{path}:\n"
    for d in walkDir(path):
        var (_, tail) = splitPath(d.path)
        if p and dirExists(d.path): tail &= "/"
        if color and dirExists(d.path): tail = &"\e[1m\e[34m{tail}\e[0m"
        if not all and tail.startsWith("."): continue else: result &= tail & seperator

    if long: stripLineEnd(result)

proc runLs*(paths: seq[string], long: bool = false, all: bool = false, p: bool = false, color: bool = false) =
    if paths.len == 0:
        try:    
            echo listDir(long, all, p, color, getCurrentDir())
        except OSError:
            echo &"ls: \"{getCurrentDir()}\" No such file or directory"
    else:
        for path in paths:
            try:    
                echo listDir(long, all, p, color, path)
            except OSError:
                echo &"ls: \"{path}\" No such file or directory"

when isMainModule:
    dispatch(runLs, cmdName = "ls", help = {"help": "Display this help page.", "version": "Show version info.", "long": "Show each entry in a new line.", "all": "Show hidden files as well.", "p": "Append \"/\" to directories.", "color": "Colorize the output"}, 
            short = {"version": 'v', "long": 'l', "all": 'a', "color": 'c'})
