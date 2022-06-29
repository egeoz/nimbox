import cligen, std/os, strformat, strutils, ../../common/constants, ../../common/utils

const programName* = "mv"

proc runMv*(files: seq[string], target: string = "", verbose: bool = false, interactive: bool = false, destination: string = "") =
    var prompt, path, dest: string
    var action: bool
    
    for fileName in files:
        try:
            if target != "":
                dest = absolutePath(target)
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
    
                if not (action): errorMessage(programName, &"Cannot move \"{fileName}\": No such file or directory")

                if dirExists(dest) and not dest.endsWith("/"): dest = dest & "/"
                if path.endsWith("/"): path = path[0 ..< path.high]

                var (_, tail) = splitPath(path)
                
                if dirExists(dest): dest = dest & tail

                if fileExists(path):
                    if interactive and fileExists(dest) or dirExists(dest):
                        print("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if dirExists(dest): removeDir(dest)
                            moveFile(path, dest)

                    else:
                        if dirExists(dest): removeDir(dest)
                        moveFile(path, dest)

                    if (fileExists(path) or dirExists(path)) != action and verbose: echo &"Moved \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        errorMessage(programName, &"Cannot overwrite non-directory \"{dest}\" with directory \"{fileName}\".", true)

                    if interactive and fileExists(dest) or dirExists(dest):
                        print("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            moveDir(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        moveDir(path, dest)
                    
                    if (fileExists(path) or dirExists(path)) != action and verbose: echo &"Moved \"{fileName}\" to \"{destination}\"."

            else:
                dest = absolutePath(files[files.len - 1])
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
                
                if path == dest: quit(1)
                if not (action): errorMessage(programName, &"Cannot move \"{fileName}\": No such file or directory.")

                if dirExists(dest) and not dest.endsWith("/"): dest = dest & "/"
                if path.endsWith("/"): path = path[0 ..< path.high]
                
                var (_, tail) = splitPath(path)
                if dirExists(dest): dest = dest & tail

                if fileExists(path):
                    if not interactive and dirExists(dest): removeDir(dest)

                    if interactive and fileExists(dest) or dirExists(dest):
                        print("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if dirExists(dest): removeDir(dest)
                            moveFile(path, dest)

                    else:
                        moveFile(path, dest)

                    if (fileExists(path) or dirExists(path)) != action and verbose: echo &"Moved \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        errorMessage(programName, &"Cannot overwrite non-directory \"{dest}\" with directory \"{fileName}\".")

                    if not interactive and fileExists(dest): removeFile(dest)
                    
                    if interactive and fileExists(dest) or dirExists(dest):
                        print("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            moveDir(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        moveDir(path, dest)
                    
        except OSError:
            errorMessage(programName, "Failed to move: Permission denied.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runMv, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.","interactive": "Prompt before overwriting." , "target": "Move all into the specified directory", "verbose": "Explain what is being done."}, 
                 short = {"verbose": 'v', "interactive": 'i', "target": 't'})
