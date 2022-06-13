import cligen, std/[times, os], strformat, ../../common/constants

proc createFile(fileName: string) =
    if not fileExists(fileName):
        try:
            writeFile(fileName, "")
        except IOError:
            echo "Failed to create file: Permission denied"
        except:
            echo "Unknown error"

proc updateModificationTime(fileName: string) =
    if fileExists(fileName):
        let now = getTime()
        try:
            setLastModificationTime(fileName, now)
        except IOError:
            echo "Failed to update file attributes: Permission denied"
        except:
            echo "Unknown error"

proc runTouch*(files: seq[string], modification: bool = false) =
    for fileName in files:
        if not dirExists(fileName):
            if modification:
                updateModificationTime(fileName)
            else:
                createFile(fileName)

        else:
            echo &"Cannot overwrite non-file \"{fileName}\" with file."

when isMainModule:
    dispatch(runTouch, cmdName = "touch", help = {"help": "Display this help page.", "version": "Show version info.", "modification": "Change only the modification time."}, 
                    short = {"version": 'v', "modification": 'm'})
