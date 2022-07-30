import 
    cligen, 
    std/[math, times],
     strformat, strutils, 
     ../../common/constants, 
     ../../common/utils

const programName* = "uptime"

proc runUptime*() =
    try:
        let 
            uptimeFile = readFile("/proc/uptime")
            loadavgFile = readFile("/proc/loadavg")
            uptimeStr = (split(uptimeFile, " "))[0]
            uptimeSec = int(floor(parseFloat(uptimeStr)))
            uptimeMin = int(convert(Seconds, Minutes, uptimeSec))
            days = int(convert(Seconds, Days, uptimeSec))
            hours = (uptimeMin - (days * 24 * 60)) div 60
            minutes = (uptimeMin - (days * 24 * 60)) mod 60
            currentTime = now().format("hh:mm:ss")
            loadavgStr = "load average: " & join((split(loadavgFile, " "))[0..2], ", ")

        echo(&"{currentTime} up {days} days, {hours:0>2}:{minutes:0>2}, {loadavgStr}")

    except IOError:
        errorMessage(programName, "Permission denied.")
    except:
        errorMessage(programName, "Unknown error.")

when isMainModule:
    dispatch(runUptime, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info."}, short = {"version": 'v'})
