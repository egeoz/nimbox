import cligen, std/os, strformat, strutils, ../../common/constants

proc runMkdir*(files: seq[string], parents: bool = false, verbose: bool = false) =
    var path: string

    for fileName in files:
        path = absolutePath(fileName)
        if path.endsWith("/"): path = path[0 ..< path.high]
        let (head, _) = splitPath(path)
        
        if not (dirExists(path) or fileExists(path)):
            if parents:
                try:
                    createDir(path)
                    if verbose: echo &"Created directory: \"{fileName}\""
                except OSError:
                    echo "Failed to create directory: Permission denied"     
                except:
                    echo "Unknown error"

            else:
                if dirExists(head): 
                    try:
                        discard existsOrCreateDir(path) 
                        if verbose: echo &"Created directory: \"{fileName}\""
                    except OSError:
                        echo "Failed to create directory: Permission denied"
                    except:
                        echo "Unknown error"

                else: 
                    echo &"Directory \"{head}\" not found."

        else:
            echo &"File or directory \"{fileName}\" already exists."

when isMainModule:
    dispatch(runMkdir, cmdName = "mkdir", help = {"help": "Display this help page.", "version": "Show version info.", "parents": "Make parent directories as needed.", "verbose": "Explain what is being done."},
                    short = {"verbose": 'v', "parents": 'p'})


