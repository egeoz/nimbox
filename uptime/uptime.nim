import cligen, std/[math, times], strformat, strutils, "../nimland.nim"

proc runUptime*() =
    try:
        let uptimeFile = readFile("/proc/uptime")
        let loadavgFile = readFile("/proc/loadavg")

        let uptimeStr = (split(uptimeFile, " "))[0]
        let uptimeSec = int(floor(parseFloat(uptimeStr)))
        let uptimeMin = int(convert(Seconds, Minutes, uptimeSec))
        let days = int(convert(Seconds, Days, uptimeSec))
        let hours = (uptimeMin - (days * 24 * 60)) div 60
        let minutes = (uptimeMin - (days * 24 * 60)) mod 60
        let currentTime = now().format("hh:mm:ss")

        let loadavgStr = "load average: " & join((split(loadavgFile, " "))[0..2], ", ")

        echo &"{currentTime} up {days} days, {hours:0>2}:{minutes:0>2}, {loadavgStr}"
    except IOError:
        echo "Permission denied."
    except:
        echo "Unknown error"

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatch(runUptime, cmdName = "uptime", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'})
