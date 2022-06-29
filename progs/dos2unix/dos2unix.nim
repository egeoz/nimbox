import cligen, std/os, strformat, strutils, ../../common/constants, ../../common/utils

const programName* = "dos2unix"

proc runDos2Unix*(files: seq[string], dos: bool = false) =
    var line, content: string
    let lineEnding = if dos: "\r\n" else: "\n"

    if files.len == 0:
        while true:
            line = readLine(stdin)
            print(line & lineEnding)

    for fileName in files:
        try:
            let f = open(fileName)
            defer: f.close()

            while not f.endOfFile():
                line = f.readLine()

                content &= line & lineEnding

            fileName.writeFile(content)
        except IOError:
            if fileExists(fileName): errorMessage(programName, &"Cannot write to {fileName}: Permission denied.")
            else: errorMessage(programName, &"{fileName}: No such file or directory.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runDos2Unix, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "dos": "Convert Unix line endings to DOS."}, 
        short = {"version": 'v', "dos": 'd'})
         