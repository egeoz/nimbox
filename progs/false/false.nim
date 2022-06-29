const programName* = "false"

proc runFalse*() =
    quit(1)

when isMainModule:
    runFalse()