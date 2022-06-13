import cligen, std/[asyncdispatch, httpclient, terminal, os], strformat, strutils, "../nimland.nim"

proc onProgressChanged(total, progress, speed: BiggestInt) {.async.} =
    try:
        let w = terminalWidth()
        let percentage = 100 * progress div total
        let maxProgressBarLength = w - 10
        let progressBarLength = maxProgressBarLength * percentage div 100
        var formattedProgress, formattedSpeed: string

        if progress >= 1073741824: 
            formattedProgress = &"{(progress.toBiggestFloat / 1073741824):7.1f} GB"
        elif progress >= 1048576: 
            formattedProgress = &"{(progress.toBiggestFloat / 1048576):7.1f} MB"
        elif progress >= 1024:
            formattedProgress = &"{(progress.toBiggestFloat / 1024):7.1f} KB"

        if speed >= 1073741824: 
            formattedSpeed = &"{(speed.toBiggestFloat / 1073741824):7.1f} GB/s"
        elif speed >= 1048576: 
            formattedSpeed = &"{(speed.toBiggestFloat / 1048576):7.1f} MB/s"
        elif speed >= 1024:
            formattedSpeed = &"{(speed.toBiggestFloat / 1024):7.1f} KB/s"

        if w >= 20:
            stdout.styledWriteLine(if percentage > 50: fgBlue else: fgRed, &"{percentage:>3}%[", fgWhite, '#'.repeat progressBarLength)
    
        stdout.writeLine(&"{formattedProgress: >2}\t{formattedSpeed: >2}")
        cursorUp 2

    except DivByZeroDefect:
        echo "Downloading..."
    except:
        echo "Unknown error."

proc download(p, o: string) {.async.} =
    var client: AsyncHttpClient
    var output: string

    try:
        let (_, tail) = splitPath(p)
        if o != "": output = o else: output = tail

        if dirExists(output): 
            echo &"Cannot overwrite non-file \"{output}\" with file." 
            quit(1)
        elif fileExists(output):
            output &= ".1"
        
        writeFile(output, "")

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
    except:
        echo "Unknown error."
        quit(1)

proc runWget*(urls: seq[string], output: string = "") =
    if output != "" and urls.len > 1:
        echo "wget: Maximum 1 arguments can be given along with -o parameter.\nSee \"output --help\" for more information."
        quit(1)

    for p in urls:
        waitFor download(p, output)

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runWget, cmdName = "wget", help = {"help": "Display this help page.", "version": "Show version info.", "output": "Specify output filename."}, 
                    short = {"version": 'v'})
