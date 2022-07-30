import 
    cligen, 
    std/[asyncdispatch, asynchttpserver, os], 
    strformat, 
    ../../common/constants, 
    ../../common/utils

const programName* = "httpd"

proc serve(contents: string, port: int) {.async.} =
    var server = newAsyncHttpServer()
    proc cb(req: Request) {.async.} =
        echo(req.reqMethod, req.url, req.headers)
        let headers = {"Content-type": "text/html; charset=utf-8"}
        await req.respond(Http200, contents, headers.newHttpHeaders())

    server.listen(Port(port)) 
    let p = server.getPort
    echo(&"You can access the served content at http://localhost:{p.uint16}/")

    while true:
        if server.shouldAcceptRequest():
            await server.acceptRequest(cb)
        else:
            await sleepAsync(500)

proc runHttpd*(files: seq[string], port: int = 0) =
    var contents: string

    for fileName in files:
        if dirExists(fileName):
            errorMessage(programName, &"\"{fileName}\" is a directory.")
            continue
        
        try:
            contents = readFile(fileName)
        except IOError:
            errorMessage(programName, &"{fileName}: No such file or directory.")
            continue
        except:
            errorMessage(programName, "Unknown error.")
            continue

        try:
            waitFor serve(contents, if port < 0: 0 else: port)
        except OSError:
            errorMessage(programName, &"Unable to bind port {port}.", true)
        except:
            errorMessage(programName, "Unknown error.", true)

when isMainModule:
    dispatch(runHttpd, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "port": "Define a custom port (by default it is randomly selected)."}, short = {"version": 'v', "port": 'p'})


