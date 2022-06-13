import cligen, std/os, "../nimland.nim"

proc dd(if: string, of: string, bs: int) =

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

dispatch(mv, help = {"help": "Display this help page.", "version": "Show version info.","input": "Prompt before overwriting." , "target": "Move all into the specified directory", "verbose": "Explain what is being done."}, 
         short = {"version": 'v', "input": 'i', "target": 't'})

