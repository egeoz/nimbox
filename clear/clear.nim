import cligen, std/terminal, "../nimland.nim"

proc runClear*() =
    eraseScreen()

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runClear, cmdName = "clear", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
