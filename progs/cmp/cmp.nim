import 
    cligen, 
    std/[critbits, os], 
    strformat
    , ../../common/constants, 
    ../../common/utils

const programName* = "cmp"

proc runCmp*(files: seq[string]) =
    if files.len == 0: errorMessage(programName, "Needs at least 2 arguments.\nTry \"cmp --help\" for more information.", true)
    elif files.len > 2: errorMessage(programName, "Invalid argument.\nTry \"cmp --help\" for more information.", true)
    
    if not fileExists(files[0]) and not dirExists(files[0]): errorMessage(programName, &"{files[0]}: No such file or directory.", true)
    elif not fileExists(files[0]) and dirExists(files[0]): errorMessage(programName, &"{files[0]}: Is a directory.", true)
    
    if not fileExists(files[1]) and not dirExists(files[1]): errorMessage(programName, &"{files[1]}: No such file or directory.", true)
    elif not fileExists(files[1]) and dirExists(files[1]): errorMessage(programName, &"{files[1]}: Is a directory.", true)

    try:
        var
            linef1, linef2: string
            count = 1

        let
            f1 = open(files[0])
            f2 = open(files[1])

        defer: f1.close()
        defer: f2.close()

        while not (f1.endOfFile() or f2.endOfFile()):
            linef1 = f1.readLine()
            linef2 = f2.readLine()
            if linef1 == linef2:
                inc count
            else: break
        
        var cb = [linef1, linef2].toCritBitTree()

        if linef1 != linef2: echo(&"{files[0]} {files[1]} differ: char {cb.commonPrefixLen()}, line {count}")

    except OSError:
        errorMessage(programName, "Permission denied.", true)

when isMainModule:
    dispatch(runCmp, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
         
