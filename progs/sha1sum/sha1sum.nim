import 
    cligen, 
    std/sha1,
    strformat,
    strutils,
    ../../common/constants,
    ../../common/utils

const 
    programName* = "sha1sum"
    blockSize    = 8192

proc runSha1sum*(files: seq[string], status: bool = false, check: string = "") =
    var 
        buffer: string
        state: Sha1State

    if files.len == 0:
        try:
            state = newSha1State()
            buffer = newString(blockSize)
            
            while not stdin.endOfFile():
                let length = stdin.readChars(buffer)
                if length == 0: break
                buffer.setLen(length)
                state.update(buffer)
                if length != blockSize: break

            echo(&"{($SecureHash(state.finalize())).toLowerAscii()}  -")
        
        except:
            errorMessage(programName, "Unknown error.")

    for fileName in files:
        try:
            echo(&"{($secureHashFile(fileName)).toLowerAscii()}  {fileName}")
        
        except OSError:
            errorMessage(programName, &"{fileName}: No such file or directory.")
        except:
            errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runSha1sum, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "status": "Do not output anything, status code shows success.", "check": "Read MD5 sums from the files and check them."}, short = {"version": 'v', "status": 's', "check": 'c'})
          
