#!/usr/bin/env python
import os, sys, getpass, time, commands
from subprocess import call
try:
	from termcolor import colored
except ImportError:
	call("pip install termcolor", shell=True)
# VARIABLE #
user = getpass.getuser()
uid = os.getuid()
wd = commands.getoutput("pwd")
# PATH VARIABLES #
ipath = ("/usr/haxxor")
pathset = ("%s/fuzzers " % wd)
pathset += ("%s/modules " % wd)
pathset += ("%s/post " % wd)
pathset += ("%s/privesc " % wd)
# MISC VARIABLES #
haxxor_file = ("%s/haxxor.py" % wd)
finished_haxxor = ("/usr/bin/haxxor")
finished_fuzzers = ("/usr/haxxor/fuzzers")
if(user != 'root'):
	print colored("[!] MUST RUN AS ROOT", "red")
	sys.exit(0)
elif(user == 'root'):
	pass
else:
	print colored("[!] Could not get user", "red")
	sys.exit(0)

if(os.path.exists(ipath)):
	print colored("[!] %s already exists, exiting" % ipath, "red")
	sys.exit(0)
else:
	pass

if(os.path.isfile(haxxor_file)):
	pass
else:
	print colored("[!] Could not find %s" % haxxor_file, "red")
	sys.exit(0)
print colored("[!] Make sure you are in the haxxor-framework directory", "red")
print colored("[!] Ctrl+C to exit to change, I'll wait", "red")
time.sleep(10)

def create_directories():
	try:
		call("mkdir " + ipath, shell=True)
		call("mv " + pathset + " " + ipath, shell=True)
	except KeyboardInterrupt:
		if(os.path.exists(finished_fuzzers)):
			call("mv " + pathset + " " + wd, shell=True)
			call("rm -r " + ipath, shell=True)
			sys.exit(0)
		else:
			sys.exit(0)
create_directories()
def remove_readmes():
	try:
		# SORRY FOR ALL THE SYSTEM CALLS LOL #
		call("rm /usr/haxxor/fuzzers/windows/browser/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/windows/os/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/mac/browser/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/mac/os/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/linux/browser/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/linux/os/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/misc/browser/.readme.txt", shell=True)
		call("rm /usr/haxxor/fuzzers/misc/os/.readme.txt", shell=True)
		call("rm /usr/haxxor/modules/dns/.readme.txt", shell=True)
		call("rm /usr/haxxor/modules/enumeration/.readme.txt", shell=True)
		call("rm /usr/haxxor/modules/scanning/.readme.txt", shell=True)
		call("rm /usr/haxxor/privesc/windows/.readme.txt", shell=True)
		call("rm /usr/haxxor/privesc/linux/.readme.txt", shell=True)
		call("rm /usr/haxxor/privesc/mac/.readme.txt", shell=True)
		call("rm /usr/haxxor/privesc/misc/.readme.txt", shell=True)
		call("rm /usr/haxxor/post/windows/.readme.txt", shell=True)
		call("rm /usr/haxxor/post/mac/.readme.txt", shell=True)
		call("rm /usr/haxxor/post/linux/.readme.txt", shell=True)
		call("rm /usr/haxxor/post/misc/.readme.txt", shell=True)
		call("rm /usr/haxxor/post/any/.readme.txt", shell=True)
	except KeyboardInterrupt:
		call("mv " + pathset + " " + wd, shell=True)
		sys.exit(0)
remove_readmes()
def haxxor_create():
	try:
		call("cp haxxor.py haxxor && chmod +x haxxor && mv haxxor /usr/bin", shell=True)
	except KeyboardInterrupt:
		call("mv " + pathset + " " + wd, shell=True)
		if(os.path.isfile(finished_haxxor)):
			call("rm " + finished_haxxor, shell=True)
			sys.exit(0)
		else:
			sys.exit(0)
haxxor_create()

def start_haxxor():
	try:
		start_now = raw_input("[?] Start haxxor now [yes/no]: ")
		if(start_now == 'yes'):
			call("haxxor", shell=True)
		else:
			sys.exit(0)
	except KeyboardInterrupt:
		sys.exit(0)
start_haxxor()
