import 
    cligen,
    common/constants,
    progs/basename/basename,
    progs/cat/cat,
    progs/chmod/chmod,
    progs/clear/clear,
    progs/cmp/cmp,
    progs/cp/cp,
    progs/dirname/dirname,
    progs/dos2unix/dos2unix,
    progs/echo/echo as echo_module,
    progs/false/false as false_module,
    progs/hostname/hostname,
    progs/httpd/httpd,
    progs/ln/ln,
    progs/ls/ls,
    progs/md5sum/md5sum,
    progs/mkdir/mkdir,
    progs/more/more,
    progs/mv/mv,
    progs/nproc/nproc,
    progs/printenv/printenv,
    progs/pwd/pwd,
    progs/readlink/readlink,
    progs/rm/rm,
    progs/seq/seq as seq_module,
    progs/sh/sh,
    progs/sha1sum/sha1sum,
    progs/sleep/sleep as sleep_module,
    progs/touch/touch,
    progs/true/true as true_module,
    progs/tty/tty,
    progs/uname/uname,
    progs/unzip/unzip,
    progs/uptime/uptime,
    progs/wget/wget,
    progs/which/which,
    progs/whoami/whoami,
    progs/yes/yes

when isMainModule:
    dispatchMulti([runBasename, cmdName = "basename", help = {"help": "Display this help page.", "version": "Show version info.", "suffix": "Remove suffix."}, 
                    short = {"version": 'v', "suffix": 's'}],

                    [runCat, cmdName = "cat", help = {"help": "Display this help page.", "version": "Show version info.", "numbers": "Show line numbers.", "numbersnonblank": "Show non-blank line numbers.", "squeeze": "Supress repeated empty output lines."},
                    short = {"version": 'v', "numbers": 'n', "numbersnonblank": 'b', "squeeze": 's'}],

                    [runChmod, cmdName = "chmod", help = {"help": "Display this help page.", "version": "Show version info.", "verbose": "List all processed files.", "recursive": "Change permissions of files and directories recursively."}, short = {"verbose": 'v', "recursive": 'R'}],

                    [runClear, cmdName = "clear", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runCmp, cmdName = "cmp", help = {"help": "Display this help page.", "version": "Show version info."},
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

                    [runLs, cmdName = "ls", help = {"help": "Display this help page.", "version": "Show version info.", "long": "Show each entry in a new line.", "all": "Show hidden files as well.", "p": "Append \"/\" to directories.", "color": "Colorize the output"},
                    short = {"version": 'v', "long": 'l', "all": 'a', "color": 'c'}],

                    [runMD5Sum, cmdName = "md5sum", help = {"help": "Display this help page.", "version": "Show version info.", "status": "Do not output anything, status code shows success.", "check": "Read MD5 sums from the files and check them."}, short = {"version": 'v', "status": 's', "check": 'c'}],

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

                    [runReadlink, cmdName = "readlink", help = {"help": "Display this help page.", "version": "Show version info.", "nonewline": "Print each result on the same line."}, 
                    short = {"verbose": 'v', "nonewline": 'n'}],

                    [runRm, cmdName = "rm", help = {"help": "Display this help page.", "version": "Show version info.", "recursive": "Remove files and directories recursively.", "verbose": "Explain what is being done."}, 
                    short = {"verbose": 'v', "recursive": 'r'}],

                    [runSeq, cmdName = "seq", help = {"help": "Display this help page.", "version": "Show version info.", "separator": "Specify the seperator to use (default is new line)"},
                    short = {"version": 'v', "separator": 's'}],

                    [runSh, cmdName = "sh", help = {"help": "Display this help page.", "version": "Show version info."}, 
                    short = {"version": 'v'}],

                    [runSha1sum, cmdName = "sha1sum", help = {"help": "Display this help page.", "version": "Show version info.", "status": "Do not output anything, status code shows success.", "check": "Read MD5 sums from the files and check them."}, short = {"version": 'v', "status": 's', "check": 'c'}],
                    
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

