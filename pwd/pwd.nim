import cligen, std/os, "../nimland.nim"

proc runPwd*() =
    echo getCurrentDir()

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runPwd, cmdName = "pwd", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
