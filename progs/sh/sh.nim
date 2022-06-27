import cligen, posix_utils, std/[os, osproc, streams, terminal], strformat, strutils, ../../common/constants

const builtin = ["cd", "exit"]

proc builtinCd(path: string) =
    try:
        setCurrentDir(absolutePath(path))
    except OSError:
        stdout.styledWrite(fgRed, "No such file or directory: {path}")

proc builtinExit() =
    quit(0)

proc runSh*(args: seq[string]) =
    if args.len == 0:
        var input, line: string
        let un = uname()
        setCurrentDir(getHomeDir())
        eraseScreen()

        while true:
            stdout.styledWrite(fgGreen, getEnv("USER"), fgBlue, "@", fgGreen, un.nodename, fgBlue, " => " & getCurrentDir() & " $ ")
            input = readLine(stdin)

            let args = split(input)
            if args[0] in builtin:
                case args[0]:
                    of "cd":
                        builtinCd(args[1])
                    of "exit":
                        builtinExit()
                    else:
                        discard
            else:
                let p = startProcess(args[0], args=args[1..args.high], options={poStdErrToStdOut, poUsePath})
                let sout = outputStream(p)
                let serr = errorStream(p)

                if not isNil(sout):
                    while sout.readLine(line):
                        echo line
                    sout.close()
                elif not isNil(serr):
                    while serr.readLine(line):
                        echo line
                    serr.close()

                p.close()


when isMainModule:
    dispatch(runSh, cmdName = "sh", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
