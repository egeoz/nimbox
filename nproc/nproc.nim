import cligen, std/os, "../nimland.nim"

proc runNproc*(ignore: int = 0) =
    const cpuDir = "/sys/devices/system/cpu/cpu"
    var count = 0

    for i in countup(0, 64):
        if dirExists(cpuDir & $i): inc count else: break

    echo $(if count - ignore >= 1: count - ignore else: count)

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runNproc, cmdName = "nproc", help = {"help": "Display this help page.", "version": "Show version info.", "ignore": "Exclude \"n\" processing units."}, 
            short = {"version": 'v', "ignore": 'i'})
