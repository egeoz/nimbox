import strformat

proc humanBytes*(bytes: int | BiggestInt, suffix: string = "B"): string =
    var fbytes = bytes.toBiggestFloat

    for unit in ["", "K", "M", "G", "T"]:
        if abs(fbytes) < 1024:
            return &"{fbytes:.2f} {unit}{suffix}"

        fbytes = fbytes / 1024

    return $bytes