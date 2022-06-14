import cligen, std/os, strutils, strformat, ../../common/constants

proc runLn*(files: seq[string], target: string = "", symbolic: bool = false, interactive: bool = false, verbose: bool = false) =
    var prompt, path, dest: string
    var action: bool
    let interactive = false

    for fileName in files:
        try:
            if target != "":
                dest = absolutePath(target)
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
                if not symbolic and dirExists(path): echo "Cannot create hard-links for directories."
                if not (action): echo &"Cannot link \"{fileName}\": No such file or directory"

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
                            if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    else:
                        if dirExists(dest): removeDir(dest)
                        if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    if sameFileContent(path, dest) and verbose: echo &"Linked \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        echo &"Cannot link to non-directory \"{dest}\" with directory \"{fileName}\"."
                        quit(1)
                    
                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    if sameFileContent(path, dest) and verbose: echo &"Linked \"{fileName}\" to \"{dest}\"."

            else:
                dest = absolutePath(files[files.len - 1])
                path = absolutePath(fileName)
                action = fileExists(path) or dirExists(path)
                
                if path == dest: quit(1)
                if not (action): echo &"Cannot link \"{fileName}\": No such file or directory"

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
                            if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    else:
                        if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    if sameFileContent(path, dest) and verbose: echo &"Linked \"{fileName}\" to \"{dest}\"."

                elif dirExists(path):
                    if fileExists(dest): 
                        echo &"Cannot link non-directory \"{dest}\" with directory \"{fileName}\"."
                        quit(1)
                    
                    if not interactive and fileExists(dest): removeFile(dest)
                    
                    if interactive and fileExists(dest) or dirExists(dest):
                        stdout.write("Destination exists, do you want to overwrite? (y/n) ")
                        prompt = readLine(stdin)
                        
                        if prompt == "y":
                            if fileExists(dest): removeFile(dest)
                            if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)

                    else:
                        if fileExists(dest): removeFile(dest)
                        if symbolic: createSymlink(path, dest) else: createHardlink(path, dest)
                    
        except OSError:
            echo "Failed to create link: Permission denied."
        except:
            echo "Unknown error."

when isMainModule:
    dispatch(runLn, cmdName = "ln", help = {"help": "Display this help page.", "version": "Show version info.", "target": "Specify the target directory.", "symbolic": "Create a symbolic link.", "interactive": "Prompt before overwriting.", "verbose": "Explain what is being done."}, 
            short = {"verbose": 'v', "target": 't', "symbolic": 's', "interactive": 'i'})
