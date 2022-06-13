import cligen, std/[os, terminal], strformat, "../nimland.nim"

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
                    stdout.write(&"{loc: >6}  {fileName}")
                    input = getch()
                    stdout.write(ansiResetCode)
                    stdout.eraseLine()

                    if input == 'q':
                        break
                    else:
                        echo f.readLine()
                
                inc loc


        except IOError:
            if dirExists(fileName):
                echo &"{fileName}: Is a directory."
            else:
                echo "No such file or directory."
        except:
            echo "Unknown error."

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runMore, cmdName = "more", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
