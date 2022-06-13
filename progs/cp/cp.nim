import cligen, std/os, strformat, strutils, ../../common/constants

proc runCp*(files: seq[string], target: string = "", recursive: bool = false, verbose: bool = false, interactive: bool = false, symboliclink: bool = false, destination: string = "") =
    var prompt, path, dest: string
    var action: bool

    for fileName in files:
        try:
            if target != "":
                dest = absolutePath(target)
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
    
                if not (action): echo &"Cannot copy \"{fileName}\": No such file or directory"

                if dirExists(dest) and not dest.endsWith("/"): dest = dest & "/"
                if path.endsWith("/"): path = path[0 ..< path.high]

                let (_, tail) = splitPath(path)
                
                if dirExists(dest): dest = dest & tail

                if fileExists(path):
                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if dirExists(dest): removeDir(dest)
                            if symboliclink: createSymlink(path, dest) else: copyFile(path, dest)

                    else:
                        if dirExists(dest): removeDir(dest)
                        if symboliclink: createSymlink(path, dest) else: copyFile(path, dest)

                    if sameFileContent(path, dest) and verbose: echo &"Copied \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        echo &"Cannot overwrite non-directory \"{dest}\" with directory \"{fileName}\"."
                        quit(1)
                    
                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            if symboliclink: createSymlink(path, dest) else: copyDir(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        if symboliclink: createSymlink(path, dest) else: copyDir(path, dest)
                    
                    if sameFileContent(path, dest) and verbose: echo &"Copied \"{fileName}\" to \"{dest}\"."

            else:
                dest = absolutePath(files[files.len - 1])
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
                
                if path == dest: quit(1)
                if not (action): echo &"Cannot copy \"{fileName}\": No such file or directory"

                if dirExists(dest) and not dest.endsWith("/"): dest = dest & "/"
                if path.endsWith("/"): path = path[0 ..< path.high]
                
                let (_, tail) = splitPath(path)
                if dirExists(dest): dest = dest & tail

                if fileExists(path):
                    if not interactive and dirExists(dest): removeDir(dest)

                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if dirExists(dest): removeDir(dest)
                            if symboliclink: createSymlink(path, dest) else: copyFile(path, dest)

                    else:
                        if symboliclink: createSymlink(path, dest) else: copyFile(path, dest)
                    
                    if sameFileContent(path, dest) and verbose: echo &"Copied \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        echo &"Cannot overwrite non-directory \"{dest}\" with directory \"{fileName}\"."
                        quit(1)
                    
                    if not interactive and fileExists(dest): removeFile(dest)
                    
                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            if symboliclink: createSymlink(path, dest) else: copyDir(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        if symboliclink: createSymlink(path, dest) else: copyDir(path, dest)
                    
        except OSError:
            echo "Failed to move: Permission denied."
        except:
            echo "Unknown error."

when isMainModule:
    dispatch(runCp, cmdName = "cp", help = {"help": "Display this help page.", "version": "Show version info.","interactive": "Prompt before overwriting." , "target": "Copy all into the specified directory", "recursive": "Copy directories recursively.", "symboliclink": "Make symbolic links instead of copying.", "verbose": "Explain what is being done."}, 
                 short = {"verbose": 'v', "interactive": 'i', "target": 't', "recursive": 'R', "symboliclink": 's'})
