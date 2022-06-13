import cligen, std/[asyncdispatch, asynchttpserver, os], strformat, ../../common/constants

proc serve(contents: string, port: int) {.async.} =
    var server = newAsyncHttpServer()
    proc cb(req: Request) {.async.} =
        echo (req.reqMethod, req.url, req.headers)
        let headers = {"Content-type": "text/html; charset=utf-8"}
        await req.respond(Http200, contents, headers.newHttpHeaders())

    server.listen(Port(port)) 
    let p = server.getPort
    echo &"You can access the served content at http://localhost:{p.uint16}/"

    while true:
        if server.shouldAcceptRequest():
            await server.acceptRequest(cb)
        else:
            await sleepAsync(500)

proc runHttpd*(files: seq[string], port: int = 0) =
    var contents: string

    for fileName in files:
        if dirExists(fileName): 
            echo &"{fileName} is a directory."
            continue
        
        try:
            contents = readFile(fileName)
        except IOError:
            echo "No such file or directory."
            continue
        except:
            echo "Unknown error."
            continue

        try:
            waitFor serve(contents, if port < 0: 0 else: port)
        except OSError:
            echo &"Unable to bind to port {port}."
            quit(1)
        except:
            echo "Unknown error."
            quit(1)

when isMainModule:
    dispatch(runHttpd, cmdName = "httpd", help = {"help": "Display this help page.", "version": "Show version info.", "port": "Define a custom port (by default it is randomly selected)."}, 
            short = {"version": 'v', "port": 'p'})


