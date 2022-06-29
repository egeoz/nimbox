import cligen, std/os, strformat, strutils, ../../common/constants, ../../common/utils

const programName* = "rm"

proc runRm*(files: seq[string], recursive: bool = false, verbose: bool = false) =
    var action: bool
    var path: string

    for fileName in files:
        path = absolutePath(fileName)
        if path.endsWith("/"): path = path[0 ..< path.high]
        action = fileExists(path) or dirExists(path)

        if recursive:
            try:
                if fileExists(path): 
                    removeFile(path)
                else:
                    removeDir(path)

                if recursive and action and verbose: 
                    errorMessage(programName, &"Removed file or directory: \"{fileName}\".")

            except IOError:
                errorMessage(programName, &"Failed to remove \"{fileName}\": Permission denied.")
            except:
                errorMessage(programName, "Unknown error.")

        else:
            try:
                if dirExists(path): 
                    errorMessage(programName, &"Cannot remove \"{fileName}\": Is a directory.")
                else:
                    removeFile(path)
                    if recursive and action and verbose: 
                        echo &"Removed file or directory: \"{fileName}\""

            except IOError:
                errorMessage(programName, &"Failed to remove \"{fileName}\": Permission denied.")
            except:
                errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runRm, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "recursive": "Remove files and directories recursively.", "verbose": "Explain what is being done."}, 
                short = {"verbose": 'v', "recursive": 'r'})
