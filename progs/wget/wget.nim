import cligen, std/[asyncdispatch, httpclient, terminal, os], strformat, strutils, ../../common/constants, ../../common/utils

proc onProgressChanged(total, progress, speed: BiggestInt) {.async.} =
    try:
        let w = terminalWidth()
        let percentage = 100 * progress div total
        let maxProgressBarLength = w - 10
        let progressBarLength = maxProgressBarLength * percentage div 100
        var formattedProgress, formattedSpeed: string

        formattedProgress = &"""{humanBytes(progress): >10}"""
        formattedSpeed = &"""{humanBytes(speed, "B/s"): >10}"""

        if w >= 20:
            stdout.styledWriteLine(if percentage > 50: fgBlue else: fgRed, &"{percentage:>3}%[", fgWhite, '#'.repeat progressBarLength)
    
        stdout.writeLine(&"{formattedProgress: >2}\t{formattedSpeed: >2}")
        cursorUp 2

    except DivByZeroDefect:
        echo "Downloading..."
        cursorUp 1
    except:
        echo "Unknown error."
        quit(1)

proc download(p, o: string) {.async.} =
    var client: AsyncHttpClient
    var output: string

    try:
        let (_, tail) = splitPath(p)
        if o != "": output = o else: output = tail

        if dirExists(output): 
            if output.endsWith("/"): output &= tail else: output &= "/" & tail
        elif fileExists(output):
            output &= ".1"

        writeFile(output, "")
        removeFile(output)
    except IOError:
        echo "Failed to create file: Permission denied"
        quit(1)
    except:
        echo "Unknown error."
        quit(1)
    
    try:       
        client = newAsyncHttpClient()
        client.onProgressChanged = onProgressChanged
        echo &"Downloading \"{p}\" to \"{output}\""
        await client.downloadFile(p, output)
    except OSError:
        echo &"Unable to resolve host address \"{p}\""
        quit(1)
    except IOError:
        echo "Failed to create file: Permission denied"
        quit(1)
    except:
        echo "Unknown error."
        quit(1)

proc runWget*(urls: seq[string], output: string = "") =
    if output != "" and urls.len > 1:
        echo "wget: Maximum 1 arguments can be given along with -o parameter.\nSee \"output --help\" for more information."
        quit(1)

    for p in urls:
        var p = p
        if not (p.startsWith("http") or p.startsWith("ftp")): p = "http://" & p
        waitFor download(p, output)

when isMainModule:
    dispatch(runWget, cmdName = "wget", help = {"help": "Display this help page.", "version": "Show version info.", "output": "Specify output filename."}, 
                    short = {"version": 'v', "output": 'o'})
