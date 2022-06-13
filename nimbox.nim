import cligen
import "nimland.nim"

import "basename/basename.nim"
import "cat/cat.nim"
import "clear/clear.nim"
import "cp/cp.nim"
import "dirname/dirname.nim"
import "echo/echo.nim"
import "false/false.nim"
import "httpd/httpd.nim"
import "mkdir/mkdir.nim"
import "more/more.nim"
import "mv/mv.nim"
import "nproc/nproc.nim"
import "printenv/printenv.nim"
import "pwd/pwd.nim"
import "rm/rm.nim"
import "touch/touch.nim"
import "true/true.nim"
import "uname/uname.nim"
import "uptime/uptime.nim"
import "wget/wget.nim"
import "yes/yes.nim"

clCfg.helpSyntax = ""
clCfg.hTabCols = @[clOptKeys, clDescrip]
clCfg.version = programVersion

when isMainModule:
    dispatchMulti([runBasename, cmdName = "basename", help = {"help": "Display this help page.", "version": "Show version info.", "suffix": "Remove suffix."}, 
                    short = {"version": 'v', "suffix": 's'}],

                    [runCat, cmdName = "cat", help = {"help": "Display this help page.", "version": "Show version info.", "numbers": "Show line numbers.", "numbersnonblank": "Show non-blank line numbers.", "squeeze": "Supress repeated empty output lines."},
                    short = {"version": 'v', "numbers": 'n', "numbersnonblank": 'b', "squeeze": 's'}],

                    [runClear, cmdName = "clear", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runCp, cmdName = "cp", help = {"help": "Display this help page.", "version": "Show version info.","interactive": "Prompt before overwriting." , "target": "Copy all into the specified directory", "recursive": "Copy directories recursively.", "symboliclink": "Make symbolic links instead of copying.", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "interactive": 'i', "target": 't', "recursive": 'R', "symboliclink": 's'}],
                    
                    [runDirname, cmdName = "dirname", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runEcho, cmdName = "echo", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runFalse],

                    [runHttpd, cmdName = "httpd", help = {"help": "Display this help page.", "version": "Show version info.", "port": "Define a custom port (by default it is randomly selected)."}, 
                    short = {"version": 'v', "port": 'p'}],
                    
                    [runMkdir, cmdName = "mkdir", help = {"help": "Display this help page.", "version": "Show version info.", "parents": "Make parent directories as needed.", "verbose": "Explain what is being done."},
                    short = {"verbose": 'v', "parents": 'p'}],
                    
                    [runMore, cmdName = "more", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runMv, cmdName = "mv", help = {"help": "Display this help page.", "version": "Show version info.","interactive": "Prompt before overwriting." , "target": "Move all into the specified directory", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "interactive": 'i', "target": 't'}],
                    
                    [runNproc, cmdName = "nproc", help = {"help": "Display this help page.", "version": "Show version info.", "ignore": "Exclude \"n\" processing units."}, 
                    short = {"version": 'v', "ignore": 'i'}],

                    [runPrintenv, cmdName = "printenv", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runPwd, cmdName = "pwd", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runRm, cmdName = "rm", help = {"help": "Display this help page.", "version": "Show version info.", "recursive": "Remove files and directories recursively.", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "recursive": 'r'}],
                    
                    [runTouch, cmdName = "touch", help = {"help": "Display this help page.", "version": "Show version info.", "modification": "Change only the modification time."}, 
                    short = {"version": 'v', "modification": 'm'}],
                    
                    [runTrue],
                    
                    [runUname, cmdName = "uname", help = {"help": "Display this help page.", "version": "Show version info.", "all": "Print all available information.", "nodename": "Print the network node hostname.", "kernelname": "Print the kernel name.", "kernelversion": "Print the kernel version.", "machine": "Print the machine hardware name."}, 
                    short = {"all": 'a', "nodename": 'n', "kernelversion": 'v', "machine": 'm', "kernelname": 's'}],
                    
                    [runUptime, cmdName = "uptime", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [wget, cmdName = "wget", help = {"help": "Display this help page.", "version": "Show version info.", "output": "Specify output filename."}, 
                    short = {"version": 'v'}],
                    
                    [runYes, cmdName = "yes", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}])

