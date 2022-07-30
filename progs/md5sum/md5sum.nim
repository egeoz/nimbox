import 
    cligen, 
    std/md5,
    strformat,
    ../../common/constants,
    ../../common/utils

const 
    programName* = "md5sum"
    blockSize    = 8192

proc runMD5Sum*(files: seq[string], status: bool = false, check: string = "") =
    var 
        context: MD5Context
        digest: MD5Digest
        bread = 0
        buffer: array[blockSize, char]
        buff: cstring
        f: File

    if files.len == 0:
        try:
            context.md5Init()
            bread = stdin.readBuffer(buffer.addr, blockSize)

            while bread > 0 and not stdin.endOfFile():
                buff = cast[cstring](create(char, blockSize + 1))
                moveMem(buff[0].addr, buffer[0].addr, blockSize)
                context.md5Update(buff, bread)
                bread = stdin.readBuffer(buffer.addr, blockSize)

            echo($buff)
            context.md5Final(digest)
            echo(&"{$digest}  -")

        except:
            errorMessage(programName, "Unknown error.")

    for fileName in files:
        try:
            f = open(fileName)
            defer: f.close()
            context.md5Init()
            bread = f.readBuffer(buffer.addr, blockSize)

            while bread > 0:
                buff = cast[cstring](create(char, blockSize + 1))
                moveMem(buff[0].addr, buffer[0].addr, blockSize)
                context.md5Update(buff, bread)
                bread = f.readBuffer(buffer.addr, blockSize)

            context.md5Final(digest)
            echo(&"{$digest}  {fileName}")
        
        except OSError:
            errorMessage(programName, &"{fileName}: No such file or directory.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runMD5Sum, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "status": "Do not output anything, status code shows success.", "check": "Read MD5 sums from the files and check them."}, short = {"version": 'v', "status": 's', "check": 'c'})
          
