import strformat

proc humanBytes*(bytes: int | BiggestInt, suffix: string = "B"): string =
    var fbytes = bytes.toBiggestFloat
    for unit in ["", "K", "M", "G", "T"]:
        if abs(fbytes) < 1024:
            return &"{fbytes:.2f} {unit}{suffix}"

        fbytes /= 1024

    return $bytes

proc errorMessage*(programName, errorString: string, exit: bool = false) =
    stderr.writeLine(&"{programName}: {errorString}")
    stderr.flushFile()
    if exit: quit(1)

template print*(s: varargs[string, `$`]) =
    for x in s:
        stdout.write(x)

    stdout.flushFile()

