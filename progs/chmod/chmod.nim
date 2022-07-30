import 
    cligen,
    fusion/filepermissions,
    std/os, 
    strformat,
    strutils,
    ../../common/constants,
    ../../common/utils

const programName* = "chmod"


proc runChmod*(args: seq[string], verbose: bool = false, recursive: bool = false) =
    var mode: int

    if args.len == 0: errorMessage(programName, "Needs at least 1 argument.\nTry \"chmod --help\" for more information.")

    try:
        mode = parseOctInt(args[0])

    except:
        errorMessage(programName, &"Invalid mode: {args[0]}", true)

    for fileName in args[1 .. args.high]:
        if not fileExists(fileName) and dirExists(fileName): 
            errorMessage(programName, &"Cannot change permissions of {fileName}: No such file or directory.")

        else:
            var oldPermissions: set[FilePermission]
            if verbose: oldPermissions = getFilePermissions(fileName)

            try: # Add -R mode
                fileName.chmod(mode)

                if verbose: 
                    echo(fromOct[int]($fromFilePermissions(oldPermissions)))
                    let old = fromOct[int]($fromFilePermissions(oldPermissions))

                    if old == mode:
                        echo (&"Mode of {fileName} retained as {args[0]}")
                    else:
                        echo (&"Mode of {fileName} changed to {args[0]}.")
                
            except OSError:
                errorMessage(programName, &"Changing permissions of {fileName}: Permission denied.")
            except:
                errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runChmod, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "verbose": "List all processed files.", "recursive": "Change permissions of files and directories recursively."}, short = {"verbose": 'v', "recursive": 'R'})
         
