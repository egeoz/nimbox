import 
    cligen, 
    strutils,
    ../../common/constants,
    ../../common/utils

const programName* = "seq"

proc runSeq*(interval: seq[string], separator: string = "\n") =
    var 
        lowerBound = 1
        upperBound: int

    if interval.len == 0: errorMessage(programName, "Needs at least 2 arguments.\nTry \"seq --help\" for more information.", true)
    elif interval.len > 2: errorMessage(programName, "Invalid argument.\nTry \"seq --help\" for more information.", true)

    if interval.len == 1:
        upperBound = parseInt(interval[0])
    else:
        lowerBound = parseInt(interval[0])
        upperBound = parseInt(interval[1])

    for i in lowerBound .. upperBound:
        print($i & separator)

when isMainModule:
    dispatch(runSeq, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "separator": "Specify the seperator to use (default is new line)"}, short = {"version": 'v', "separator": 's'})
         
