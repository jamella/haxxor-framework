#!/usr/bin/env python
import os, time, sys, getpass, commands
from subprocess import call
from termcolor import colored

# VARIABLES #
user = getpass.getuser()
uid = os.getuid()
wd = commands.getoutput("pwd")
ipath = ("/usr/haxxor")
pathset = ("/usr/haxxor/modules ")
pathset += ("/usr/haxxor/fuzzers ")
pathset += ("/usr/haxxor/post ")
pathset += ("/usr/haxxor/privesc")
finished_haxxor = ("/usr/bin/haxxor")

if(os.path.exists(ipath)):
	pass
else:
	print colored("[!] Could not find {}".format(ipath), "red")
	sys.exit(0)
if(os.path.isfile(finished_haxxor)):
	pass
else:
	print colored("[!] Could not find {}".format(finished_haxxor), "red")
	sys.exit(0)

print colored("[!] CTRL+C and change if not not in haxxor-framework directory", "red")
time.sleep(10)

call("mv " + pathset + " " + wd, shell=True)
call("rm -r " + ipath, shell=True)
call("rm " + finished_haxxor, shell=True)
