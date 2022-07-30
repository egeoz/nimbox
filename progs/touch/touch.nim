import 
    cligen, 
    std/[times, os], 
    strformat, 
    ../../common/constants, 
    ../../common/utils

const programName* = "touch"

proc createFile(fileName: string) =
    if not fileExists(fileName):
        try:
            writeFile(fileName, "")
        except IOError:
            errorMessage(programName, &"Failed to create \"{fileName}\": Permission denied.")
        except:
            errorMessage(programName, "Unknown error.")

proc updateModificationTime(fileName: string) =
    if fileExists(fileName):
        let now = getTime()
        try:
            setLastModificationTime(fileName, now)
        except IOError:
            errorMessage(programName, &"Failed to update file attributes of \"{fileName}\": Permission denied")
        except:
            errorMessage(programName, "Unknown error.")

proc runTouch*(files: seq[string], modification: bool = false) =
    for fileName in files:
        if not dirExists(fileName):
            if modification:
                updateModificationTime(fileName)
            else:
                createFile(fileName)

        else:
            errorMessage(programName, &"Cannot overwrite non-file \"{fileName}\" with file.")

when isMainModule:
    dispatch(runTouch, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "modification": "Change only the modification time."}, short = {"version": 'v', "modification": 'm'})
