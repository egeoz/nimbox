import cligen, std/os, "../nimland.nim"

proc runPrintenv*() =
    for env in envPairs():
        echo env.key & "=" & env.value

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runPrintenv, cmdName = "printenv", help = {"help": "Display this help page.", "version": "Show version info."}, 
            short = {"version": 'v'})
