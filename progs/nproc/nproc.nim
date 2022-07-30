import 
    cligen, 
    std/os, 
    ../../common/constants

const programName* = "nproc"

proc runNproc*(ignore: int = 0) =
    const cpuDir = "/sys/devices/system/cpu/cpu"
    var count = 0

    for i in countup(0, 64):
        if dirExists(cpuDir & $i): inc count else: break

    echo($(if count - ignore >= 1: count - ignore else: count))

when isMainModule:
    dispatch(runNproc, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "ignore": "Exclude \"n\" processing units."}, short = {"version": 'v', "ignore": 'i'})
