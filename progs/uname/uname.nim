import
    cligen,
    posix_utils,
    ../../common/constants

const programName* = "uname"

proc runUname*(all: bool = false, machine: bool = false, nodename: bool = false, kernelname: bool = false, kernelrelease: bool = false, kernelversion: bool = false) =
    let 
        un = uname()
        noargs = not (all or machine or nodename or kernelname or kernelrelease or kernelversion)

    var output: string

    if all or kernelname or noargs:
        output &= un.sysname
    
    if nodename or all:
        output &= " " & un.nodename

    if kernelrelease or all:
        output &= " " & un.release

    if kernelversion or all:
        output &= " " & un.version

    if machine or all:
        output &= " " & un.machine

    echo(output)

when isMainModule:
    dispatch(runUname, cmdName = programName, help = {"help": "Display this help page.", "version": "Show version info.", "all": "Print all available information.", "nodename": "Print the network node hostname.", "kernelname": "Print the kernel name.", "kernelversion": "Print the kernel version.", "machine": "Print the machine hardware name."}, short = {"all": 'a', "nodename": 'n', "kernelversion": 'v', "machine": 'm', "kernelname": 's'})
