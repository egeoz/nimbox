import cligen
import common/constants

import progs/basename/basename
import progs/cat/cat
import progs/clear/clear
import progs/cp/cp
import progs/dirname/dirname
import progs/dos2unix/dos2unix
import progs/echo/echo as echo_module
import progs/false/false as false_module
import progs/hostname/hostname
import progs/httpd/httpd
import progs/ln/ln
import progs/ls/ls
import progs/mkdir/mkdir
import progs/more/more
import progs/mv/mv
import progs/nproc/nproc
import progs/printenv/printenv
import progs/pwd/pwd
import progs/readlink/readlink
import progs/rm/rm
import progs/sh/sh
import progs/sleep/sleep as sleep_module
import progs/touch/touch
import progs/true/true as true_module
import progs/tty/tty
import progs/uname/uname
import progs/unzip/unzip
import progs/uptime/uptime
import progs/wget/wget
import progs/which/which
import progs/whoami/whoami
import progs/yes/yes

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

                    [runDos2Unix, cmdName = "dos2unix", help = {"help": "Display this help page.", "version": "Show version info.", "dos": "Convert Unix line endings to DOS."}, 
                    short = {"version": 'v', "dos": 'd'}],
                    
                    [runEcho, cmdName = "echo", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runFalse, cmdName = "false"],

                    [runHostname, cmdName = "hostname", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runHttpd, cmdName = "httpd", help = {"help": "Display this help page.", "version": "Show version info.", "port": "Define a custom port (by default it is randomly selected)."}, 
                    short = {"version": 'v', "port": 'p'}],
                    
                    [runLn, cmdName = "ln", help = {"help": "Display this help page.", "version": "Show version info.", "target": "Specify the target directory.", "symbolic": "Create a symbolic link.", "interactive": "Prompt before overwriting.", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "target": 't', "symbolic": 's', "interactive": 'i'}],

                    [runMkdir, cmdName = "mkdir", help = {"help": "Display this help page.", "version": "Show version info.", "parents": "Make parent directories as needed.", "verbose": "Explain what is being done."},
                    short = {"verbose": 'v', "parents": 'p'}],
                    
                    [runLs, cmdName = "ls", help = {"help": "Display this help page.", "version": "Show version info.", "long": "Show each entry in a new line.", "all": "Show hidden files as well.", "p": "Append \"/\" to directories.", "color": "Colorize the output"}, 
                    short = {"version": 'v', "long": 'l', "all": 'a', "color": 'c'}],

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

                    [runReadlink, cmdName = "readlink", help = {"help": "Display this help page.", "version": "Show version info.", "nonewline": "Print each result on the same line."}, 
                    short = {"verbose": 'v', "nonewline": 'n'}],

                    [runRm, cmdName = "rm", help = {"help": "Display this help page.", "version": "Show version info.", "recursive": "Remove files and directories recursively.", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "recursive": 'r'}],

                    [runSh, cmdName = "sh", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runSleep, cmdName = "sleep", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runTouch, cmdName = "touch", help = {"help": "Display this help page.", "version": "Show version info.", "modification": "Change only the modification time."}, 
                    short = {"version": 'v', "modification": 'm'}],
                    
                    [runTrue, cmdName = "true"],

                    [runTty, cmdName = "tty", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runUname, cmdName = "uname", help = {"help": "Display this help page.", "version": "Show version info.", "all": "Print all available information.", "nodename": "Print the network node hostname.", "kernelname": "Print the kernel name.", "kernelversion": "Print the kernel version.", "machine": "Print the machine hardware name."}, 
                    short = {"all": 'a', "nodename": 'n', "kernelversion": 'v', "machine": 'm', "kernelname": 's'}],
                    
                    [runUnzip, cmdName = "unzip", help = {"help": "Display this help page.", "version": "Show version info.", "destination": "Extract into destination.", "list": "List contents without extracting.", "neveroverwrite": "Never overwrite files."}, 
                    short = {"version": 'v', "destination": 'd', "list": 'l', "neveroverwrite": 'n'}],

                    [runUptime, cmdName = "uptime", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],
                    
                    [runWget, cmdName = "wget", help = {"help": "Display this help page.", "version": "Show version info.", "output": "Specify output filename."}, 
                    short = {"version": 'v', "output": 'o'}],

                    [runWhich, cmdName = "which", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runWhoami, cmdName = "whoami", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runYes, cmdName = "yes", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}])

