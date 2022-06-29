import cligen, std/[os, terminal], strformat, ../../common/constants, ../../common/utils

const programName* = "more"

proc runMore*(files: seq[string]) =
    let h = terminalHeight()
    var loc = 0 
    var input: char

    for fileName in files:
        try:
            let f = open(fileName)
            defer: f.close()
            eraseScreen()
            loc = 0

            while not f.endOfFile():
                if loc < (h - 1):
                    echo f.readLine()
                else:
                    setBackgroundColor(BackgroundColor.bgwhite)
                    setForegroundColor(ForegroundColor.fgblack)
                    print(&"{loc: >6}  {fileName}")
                    input = getch()
                    print(ansiResetCode)
                    stdout.eraseLine()

                    if input == 'q':
                        break
                    else:
                        echo f.readLine()
                
                inc loc


        except IOError:
            if dirExists(fileName):
                errorMessage(programName, &"{fileName}: Is a directory.")
            else:
                errorMessage(programName, &"{fileName}: No such file or directory.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runMore, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
