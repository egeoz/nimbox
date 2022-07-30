import 
    cligen, 
    std/os, 
    strformat, 
    strutils, 
    ../../common/constants, 
    ../../common/utils

const programName* = "ls"

proc listDir(long, all, p, color: bool, path: string): string =
    let seperator = if long: "\n" else: "\t"
    if dirExists(path): result = &"\n{path}:\n"
    for d in walkDir(path):
        var (_, tail) = splitPath(d.path)
        if p and dirExists(d.path): tail &= "/"
        if color and dirExists(d.path): tail = &"\e[1m\e[34m{tail}\e[0m"
        if not all and tail.startsWith("."): continue else: result &= tail & seperator

    if long: stripLineEnd(result)

proc runLs*(paths: seq[string], long: bool = false, all: bool = false, p: bool = false, color: bool = false) =
    if paths.len == 0:
        try:    
            echo(listDir(long, all, p, color, getCurrentDir()))
        except OSError:
            errorMessage(programName, &"\"{getCurrentDir()}\" No such file or directory", exit = false)
    else:
        for path in paths:
            try:    
                print(listDir(long, all, p, color, path))
            except OSError:
                errorMessage(programName, &"\"{path}\" No such file or directory", exit = false)

when isMainModule:
    dispatch(runLs, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "long": "Show each entry in a new line.", "all": "Show hidden files as well.", "p": "Append \"/\" to directories.", "color": "Colorize the output"}, short = {"version": 'v', "long": 'l', "all": 'a', "color": 'c'})
