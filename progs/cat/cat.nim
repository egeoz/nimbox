import 
    cligen, 
    regex, 
    std/os, 
    strformat, 
    ../../common/constants, 
    ../../common/utils

const programName* = "cat"

proc runCat*(files: seq[string], numbers: bool = false, numbersnonblank: bool = false, squeeze: bool = false) =
    let emptyPattern = re"[^\s ]"
    var 
        isPreviousLineEmpty: bool
        n: int
        line: string
    
    if files.len == 0:
        while true:
            line = readLine(stdin)
            echo(line)
    else:
        for fileName in files:
            try:
                let f = open(fileName)
                defer: f.close()

                isPreviousLineEmpty = false
                n = 1

                while not f.endOfFile():
                    line = f.readLine()

                    if squeeze:
                        if not (emptyPattern in line):
                            if isPreviousLineEmpty:
                                continue
                            else:
                                isPreviousLineEmpty = true

                        else:
                            isPreviousLineEmpty = false

                    if numbers:
                        echo(&"{n: >6} {line}")
                        inc n
                    elif numbersnonblank:
                        if emptyPattern in line:
                            echo(&"{n: >6} {line}")
                            inc n 
                        else:
                            echo(&"{line: >7}")

                    else:
                        echo(line)

            except IOError:
                if dirExists(fileName):
                    errorMessage(programName, &"{fileName}: Is a directory.")
                else:
                    errorMessage(programName, &"{fileName}: No such file or directory.")
            except:
                errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runCat, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "numbers": "Show line numbers.", "numbersnonblank": "Show non-blank line numbers.", "squeeze": "Supress repeated empty output lines."}, short = {"version": 'v', "numbers": 'n', "numbersnonblank": 'b', "squeeze": 's'})
