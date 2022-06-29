import cligen, std/os, strformat, zippy/ziparchives, ../../common/constants, ../../common/utils

const programName* = "unzip"

proc runUnzip*(files: seq[string], destination: string = "", list: bool = false, neveroverwrite: bool = false) =
    if files.len == 0: errorMessage(programName, "Needs at least 1 argument.\nTry \"unzip --help\" for more information.", true)

    for fileName in files:
        if dirExists(fileName): errorMessage(programName, &"\"{fileName}\" is a directory.", true)
        
        try: 
            if list:
                let archive = openZipArchive(fileName)
                try:
                    for f in archive.walkFiles:
                        echo f
                finally:
                    archive.close()

            else:
                extractAll(fileName, "unzipped")

        except IOError:
            if fileExists(fileName): errorMessage(programName, &"Cannot write to {fileName}: Permission denied.")
            else: errorMessage(programName, &"{fileName}: No such file or directory.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runUnzip, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "destination": "Extract into destination.", "list": "List contents without extracting.", "neveroverwrite": "Never overwrite files."}, 
        short = {"version": 'v', "destination": 'd', "list": 'l', "neveroverwrite": 'n'})
         