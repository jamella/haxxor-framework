#!/usr/bin/env python
import os, time, sys, commands, getpass
from subprocess import call
from termcolor import colored

# VARIABLES #
ipath = ("/usr/haxxor")
user = getpass.getuser()
fuzzer1 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/windows/browser |wc -l"))
fuzzer2 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/windows/os |wc -l"))
fuzzer3 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/mac/browser | wc -l"))
fuzzer4 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/mac/os |wc -l "))
fuzzer5 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/linux/browser |wc -l"))
fuzzer6 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/linux/os | wc -l"))
fuzzer7 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/misc/browser |wc -l"))
fuzzer8 = int(commands.getoutput("ls -1 /usr/haxxor/fuzzers/misc/os |wc -l"))
list_fuzzers = int(fuzzer1 + fuzzer2 + fuzzer3 + fuzzer4 + fuzzer5 + fuzzer6 + fuzzer7 + fuzzer8)
module1 = int(commands.getoutput("ls -1 /usr/haxxor/modules/dns | wc -l"))
module2 = int(commands.getoutput("ls -1 /usr/haxxor/modules/enumeration | wc -l"))
module3 = int(commands.getoutput("ls -1 /usr/haxxor/modules/scanning |wc -l | grep -v '.portscan'"))
module4 = int(commands.getoutput("ls -1 /usr/haxxor/modules/cloning |wc -l"))
module5 = int(commands.getoutput("ls -1 /usr/haxxor/modules/wordlists |wc -l"))
list_modules = int(module1 + module2 + module3 + module4 + module5)
post1 = int(commands.getoutput("ls -1 /usr/haxxor/post/windows |wc -l"))
post2 = int(commands.getoutput("ls -1 /usr/haxxor/post/mac | wc -l"))
post3 = int(commands.getoutput("ls -1 /usr/haxxor/post/linux |wc -l"))
post4 = int(commands.getoutput("ls -1 /usr/haxxor/post/misc | wc -l"))
post5 = int(commands.getoutput("ls -1 /usr/haxxor/post/any | wc -l"))
list_post = int(post1 + post2 + post3 + post4 + post5)
privesc1 = int(commands.getoutput("ls -1 /usr/haxxor/privesc/windows | wc -l"))
privesc2 = int(commands.getoutput("ls -1 /usr/haxxor/privesc/mac | wc -l"))
privesc3 = int(commands.getoutput("ls -1 /usr/haxxor/privesc/linux ]wc -l"))
privesc4 = int(commands.getoutput("ls -1 /usr/haxxor/privesc/misc | wc -l"))
list_privesc = int(privesc1 + privesc2 + privesc3 + privesc4)

if(user == 'root'):
	pass
else:
	print colored("[!] MUST RUN AS ROOT", "red")
	exit(1)
if(os.path.exists(ipath)):
	pass
else:
	print colored("[!] Could not find %s, run setup.py to set it up", "red")
	exit(1)

def banner():
	print colored("|================================================================|", "blue")
	print colored("|    _/                                                          |", "blue")
	print colored("|   _/_/_/      _/_/_/  _/    _/  _/    _/    _/_/    _/  _/_/   |", "blue")
	print colored("|  _/    _/  _/    _/    _/_/      _/_/    _/    _/  _/_/        |", "blue")
	print colored("| _/    _/  _/    _/  _/    _/  _/    _/  _/    _/  _/           |", "blue")
	print colored("|_/    _/    _/_/_/  _/    _/  _/    _/    _/_/    _/            |", "blue")
	print colored("|================================================================|", "blue")  
	print colored("[ [{}] Fuzzers [{}] Modules					]".format(list_fuzzers, list_modules), "blue")   
	print colored("[ [{}] Privesc [{}] Post    					]".format(list_privesc, list_post), "blue")
	print colored("[1] Fuzzers\n[2] Modules\n[3] Privesc\n[4] Post\n[5] Help\n[6] Donate\n[7] Exit", "blue")
banner()

def main():
	def fuzzers():
		try:
			print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
			while True:
				try:
					usefuzzer1 = raw_input("[haxxor/fuzzers] => ")
					if(usefuzzer1 == '1'):
						print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
						while True:
							try:
								winfuzzer1 = raw_input("[haxxor/fuzzers/windows] => ")
								if(winfuzzer1 == '1'):
									call("ls -1 /usr/haxxor/fuzzers/windows/browser", shell=True)
									while True:
										try:
											usewinfuzzer1 = raw_input("[haxxor/fuzzers/windows/browser] => ")
											tuple_usewinfuzzer1 = usewinfuzzer1.partition(" ")
											tuple_usewinfuzzer2 = usewinfuzzer1.partition(".")
											if(tuple_usewinfuzzer1[0] == 'use'):
												call("python " + tuple_usewinfuzzer1[2], shell=True)
											elif(tuple_usewinfuzzer1[0] == 'exit'):
												exit(0)
											elif(tuple_usewinfuzzer1[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usewinfuzzer1[0] == 'help'):
												print colored("==========================================", "yellow")
												print colored("help: this menu", "yellow")
												print colored("use: use scripts", "yellow")
												print colored("back: go back to previous menu", "yellow")
												print colored("exit: exit haxxor", "yellow")
												print colored("==========================================", "yellow")
			 								else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to the previous menu", "yellow")
								elif(winfuzzer1 == '2'):
									call("ls -1 /usr/haxxor/fuzzers/windows/os", shell=True)
									while True:
										try:
											usewinfuzzer2 = raw_input("[haxxor/fuzzers/windows/os] => ")
											tuple_usewinfuzzer2 = usewinfuzzer2.partition(" ")
											if(tuple_usewinfuzzer2[0] == 'use'):
												call("python " + tuple_usefuzzer2[2], shell=True)
											elif(tuple_usewinfuzzer2[0] == 'exit'):
												exit(0)
											elif(tuple_usewinfuzzer2[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usewinfuzzer2[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(winfuzzer1 == '3'):
									call("clear")
									banner()
									break
								else:
									print colored("[!] Unknown option", "red")
							except KeyboardInterrupt:
								print colored("[!] Option #3 to go back", "red")
					elif(usefuzzer1 == '2'):
						print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
						while True:
							try:
								macfuzzer1 = raw_input("[haxxor/fuzzers/mac] => ")
								if(macfuzzer1 == '1'):
									call("ls -1 /usr/haxxor/fuzzers/mac/browser", shell=True)
									while True:
										try:
											usemacfuzzer1 = raw_input("[haxxor/fuzzers/mac/browser] => ")
											tuple_usemacfuzzer1 = usemacfuzzer1.partition(" ")
											if(tuple_usemacfuzzer1[0] == 'use'):
												call("python " + tuple_usemacfuzzer1[2], shell=True)
											elif(tuple_usemacfuzzer1[0] == 'exit'):
												exit(0)
											elif(tuple_usemacfuzzer1[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usemacfuzzer1[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(macfuzzer1 == '2'):
									call("ls -1 /usr/haxxor/fuzzers/mac/os", shell=True)
									while True:
										try:
											usemacfuzzer2 = raw_input("[haxxor/fuzzers/mac/os] => ")
											tuple_usemacfuzzer2 = usemacfuzzer2.partition(" ")
											if(tuple_usemacfuzzer2[0] == 'use'):
												call("python " + tuple_usemacfuzzer2[2], shell=True)
											elif(tuple_usemacfuzzer2[0] == 'exit'):
												exit(0)
											elif(tuple_usemacfuzzer2[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usemacfuzzer2[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(macfuzzer1 == '3'):
									call("clear", shell=True)
									banner()
									break
								else:
									print colored("[!] Unknown option", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usefuzzer1 == '3'):
						print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
						while True:
							try:
								linuxfuzzer1 = raw_input("[haxxor/fuzzers/linux] => ")
								if(linuxfuzzer1 == '1'):
									call("ls -1 /usr/haxxor/fuzzers/linux/browser", shell=True)
									while True:
										try:
											uselinuxfuzzer1 = raw_jnput("[haxxor/linux/browser] => ")
											tuple_uselinuxfuzzer1 = uselinuxfuzzer1.partition(" ")
											if(tuple_uselinuxfuzzer1[0] == 'use'):
												call("python " + tuple_uselinuxfuzzer1[2], shell=True)
											elif(tuple_uselinuxfuzzer1[0] == 'exit'):
												exit(0)
											elif(tuple_uselinuxfuzzer1[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_uselinuxfuzzer1[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")	
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(linxufuzzer1 == '2'):
									call("ls -1 /usr/haxxor/fuzzers/linux/os", shell=True)
									while True:
										try:
											uselinuxfuzzer2 = raw_input("[haxxor/fuzzers/linux/os] => ")
											tuple_uselinuxfuzzer2 = uselinuxfuzzer2.partition(" ")
											if(tuple_uselinuxfuzzer2[0] == 'use'):
												call("python " + tuple_uselinuxfuzzer2[2], shell=True)
											elif(tuple_uselinuxfuzzer2[0] == 'exit'):
												exit(0)
											elif(tuple_uselinuxfuzzer2[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_uselinuxfuzzer2 == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInerrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(linuxfuzzer1 == '3'):
									call("clear", shell=True)
									banner()
									break
								else:
									print colored("[!] Unknown option", "red")
							except KeyboardInterrupt:
								print colored("[!] Option #3 to go back", "red")
					elif(usefuzzer1 == '4'):
						print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
						while True:
							try:
								miscfuzzer1 = raw_input("[haxxor/fuzzers/misc] => ")
								if(miscfuzzer1 == '1'):
									call("ls -1 /usr/haxxor/fuzzers/misc/browser", shell=True)
									while True:
										try:
											usemiscfuzzer1 = raw_input("[haxxor/fuzzers/misc/browser] => ")
											tuple_usemiscfuzzer1 = usemiscfuzzer1.partition(" ")
											if(tuple_usemiscfuzzer1[0] == 'use'):
												call("python " + tuple_usemiscfuzzer1[2], shell=True)
											elif(tuple_usemiscfuzzer1[0] == 'exit'):
												exit(0)
											elif(tuple_usemiscfuzzer1[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usemiscfuzzer1[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								elif(misfuzzer1 == '2'):
									call("ls -1 /usr/haxxor/fuzzers/misc/os", shell=True)
									while True:
										try:
											usemiscfuzzer2 = raw_input("[haxxor/fuzzers/misc/os] => ")
											tuple_usemiscfuzzer2 = usemiscfuzzer2.partition(" ")
											if(tuple_usemiscfuzzer2[0] == 'use'):
												call("python " + tuple_usemiscfuzzer2[2], shell=True)
											elif(tuple_usemiscfuzzer2[0] == 'exit'):
												exit(0)
											elif(tuple_usemiscfuzzer2[0] == 'back'):
												print colored("[1] Browser\n[2] OS\n[3] Back", "blue")
												break
											elif(tuple_usemiscfuzzer2[0] == 'help'):
												print colored("==========================================", "yellow")
                                                                                                print colored("help: this menu", "yellow")
                                                                                                print colored("use: use scripts", "yellow")
                                                                                                print colored("back: go back to previous menu", "yellow")
                                                                                                print colored("exit: exit haxxor", "yellow")
                                                                                                print colored("==========================================", "yellow")			
											else:
												print colored("[!] Unknown command", "red")
										except KeyboardInterrupt:
											print colored("{!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
								else:
									print colored("[!] Unknown option", "red")
							except KeyboardInterrupt:
								print colored("[!] Option #3 to go back", "red")
					elif(usefuzzer1 == '5'):
						call("clear", shell=True)
						banner()
						break
					else:
						print colored("[!] Unknown option", "red")
				except KeyboardInterrupt:
					print colored("[!] Option #5 to go back", "red")
		except KeyboardInterrupt:
			print colored("[!] Interrupt", "red")
	def modules():
		try:
			print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlist\n[6] Back", "blue")
			while True:
				try:
					usemodule1 = raw_input("[haxxor/modules] => ")
					if(usemodule1 == '1'):
						call("ls -1 /usr/haxxor/modules/dns", shell=True)
						while True:
							try:
								dnsmodule1 = raw_Input("[haxxor/modules/dns] => ")
								tuple_dnsmodule1 = dnsmodule1.partition(" ")
								if(tuple_dnsmodule1[0] == 'use'):
									call("python " + tuple_usemodule1[2], shell=True)
								elif(tuple_dnsmodule1[0] == 'exit'):
									exit(0)
								elif(tuple_dnsmodule1[0] == 'back'):
									print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlist\n[6] Back", "blue")
									break
								elif(tuple_usemodule1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                	print colored("help: this menu", "yellow")
                                                                	print colored("use: use scripts", "yellow")
                                                                	print colored("back: go back to previous menu", "yellow")
                                                                	print colored("exit: exit haxxor", "yellow")
                                                                	print colored("==========================================", "yellow")	
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usemodule1 == '2'):
						call("ls -1 /usr/haxxor/modules/enumeration", shell=True)
						while True:
							try:
								enummodule1 = raw_input("[haxxor/modules/enum] => ")
								tuple_enummodule1 = enummodule.partition(" ")
								if(tuple_enummodule1[0] == 'use'):
									call("python " + tuple_enummodule1[2], shell=True)
								elif(tuple_enummodule1[0] == 'exit'):
									exit(0)
								elif(tuple_enummodule1[0] == 'back'):
									print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlists\n[6] Back", "blue")
									break
								elif(tuple_enummodule1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usemodule1 == '3'):
						call("ls -1 /usr/haxxor/modules/scanning", "red")
						while True:
							try:
								scanningmodule1 = raw_input("[haxxor/modules/scanning] => ")
								tuple_scanningmodule1 = scanningmodule1.partition(" ")
								if(tuple_scanningmodule1[0] == 'use'):
									call("python " + tuple_usemodule1[2], shell=True)
								elif(tuple_scanningmodule1[0] == 'exit'):
									exit(0)
								elif(tuple_scanningmodule1[0] == 'back'):
									print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlists\n[6] Back", "blue")
									break
								elif(tuple_scanningmodule1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usemodule1 == '4'):
						call("ls -1 /usr/haxxor/modules/cloning", shell=True)
						while True:
							try:
								cloningmodule1 = raw_input("[haxxor/modules/cloning] => ")
								tuple_cloningmodule1 = cloningmodule1.partition(" ")
								if(tuple_cloningmodule1[0] == 'use'):
									call("python " + tuple_cloningmodule1[2], shell=True)
								elif(tuple_cloningmodule1[0] == 'exit'):
									exit(0)
								elif(tuple_cloningmodule1[0] == 'back'):
									print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlists\n[6] Back", "blue")
									break
								elif(tuple_cloningmodule1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usemodule1 == '5'):
						call("ls -1 /usr/haxxor/modules/wordlists", shell=True)
						while True:
							try:
								wordlistmodule1 = raw_input("[haxxor/modules/wordlists] => ")
								tuple_wordlistmodule1 = wordlistmodule1.partition(" ")
								if(tuple_wordlistmodule1[0] == 'use'):
									call("python " + tuple_wordlistmodule1[2], shell=True)
								elif(tuple_wordlistmodule1[0] == 'exit'):
									exit(0)
								elif(tuple_wordlistmodule1[0] == 'back'):
									print colored("[1] DNS\n[2] Enumeration\n[3] Scanning\n[4] Cloning\n[5] Wordlists\n[6] Back", "blue")
									break
								elif(tuple_wordlistmodule1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usemodule1 == '6'):
						call("clear", "blue")
						banner()
						break
					else:
						print colored("[!] Unknown option", "red")
				except KeyboardInterrupt:
					print colored("[!] Option #6 to go back", "red")
		except KeyboardInterrupt:
			print colored("[!] Interrupt", "red")
	def privesc():
		try:
			print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
			while True:
				try:
					useprivesc1 = raw_input("[haxxor/privesc] => ")
					if(useprivesc1 == '1'):
						call("ls -1 /usr/haxxor/privesc/windows", shell=True)
						while True:
							try:
								windowsprivesc1 = raw_input("[haxxor/privesc/windows] => ")
								tuple_windowsprivesc1 = windowsprivesc1.partition(" ")
								if(tuple_windowsprivesc1[0] == 'use'):	
									call("python " + tuple_windowsprivesc1[2], shell=True)
								elif(tuple_windowsprivesc1[0] == 'exit'):
									exit(0)
								elif(tuple_windowsprivesc1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
									break
								elif(tuple_windowsprivesc1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(useprivesc1 == '2'):
						call("ls -1 /usr/haxxor/privesc/mac", shell=True)
						while True:
							try:
								macprivesc1 = raw_input("[haxxor/privesc/mac] => ")
								tuple_macprivesc1 = macprivesc1.partition(" ")
								if(tuple_macprivesc1[0] == 'use'):
									call("python " + tuple_macprivesc1[2], shell=True)
								elif(tuple_macprivesc1[0] == 'exit'):
									exit(0)
								elif(tuple_macprivesc1[0] == 'back'):	
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
									break
								elif(tuple_macprivesc1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(useprivesc1 == '3'):
						call("ls -1 /usr/haxxor/privesc/linux", shell=True)
                                                while True:
                                                        try:  
                                                                linuxprivesc1 = raw_input("[haxxor/privesc/linux] => ")
                                                                tuple_linuxprivesc1 = linuxprivesc1.partition(" ")
                                                                if(tuple_linuxprivesc1[0] == 'use'):
                                                                        call("python " + tuple_linuxprivesc1[2], shell=True)      
                                                                elif(tuple_linuxprivesc1[0] == 'exit'):
                                                                        exit(0)
                                                                elif(tuple_linuxprivesc1[0] == 'back'):   
                                                                        print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
                                                                        break
                                                                elif(tuple_linuxprivesc1[0] == 'help'):
                                                                        print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
                                                                else:
                                                                        print colored("[!] Unknown command", "red")
                                                        except KeyboardInterrupt:
                                                                print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(useprivesc1 == '4'):
						call("ls -1 /usr/haxxor/privesc/misc", shell=True)
                                                while True:
                                                        try:  
                                                                miscprivesc1 = raw_input("[haxxor/privesc/misc] => ")
                                                                tuple_miscprivesc1 = miscprivesc1.partition(" ")
                                                                if(tuple_miscprivesc1[0] == 'use'):
                                                                        call("python " + tuple_miscprivesc1[2], shell=True)      
                                                                elif(tuple_macprivesc1[0] == 'exit'):
                                                                        exit(0)
                                                                elif(tuple_miscprivesc1[0] == 'back'):   
                                                                        print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Back", "blue")
                                                                        break
                                                                elif(tuple_miscprivesc1[0] == 'help'):
                                                                        print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
                                                                else:
                                                                        print colored("[!] Unknown command", "red")
                                                        except KeyboardInterrupt:
                                                                print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow") 
					elif(useprivesc1 == '5'):
						call("clear", shell=True)
						banner()
						break
					else:
						print colored("[!] Unknown option", "red")
				except KeyboardInterrupt:
					print colored("[!] Option #5 to go back", "red")
		except KeyboardInterrupt:
			print colored("[!] Interrupt", "red")
	def post():
		try:
			print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
			while True:
				try:
					usepost1 = raw_input("[haxxor/post] => ")
					if(usepost1 == '1'):
						call("ls -1 /usr/haxxor/post/windows", shell=True)
						while True:
							try:
								windowspost1 = raw_input("[haxxor/post/windows] => ")
								tuple_windowspost1 = windowspost1.partition(" ")
								if(tuple_windowspost1[0] == 'use'):
									call("python " + tuple_windowspost1[2], shell=True)
								elif(tuple_windowspost1[0] == 'exit'):
									exit(0)
								elif(tuple_windowspost1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
									break
								elif(tuple_windowspost1 == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usepost1 == '2'):
						call("ls -1 /usr/haxxor/post/mac", shell=True)
						while True:
							try:
								macpost1 = raw_input("[haxxor/post/mac] => ")
								tuple_macpost1 = macpost1.partition(" ")
								if(tuple_macpost1[0] == 'use'):
									call("python " + tuple_macpost1[2], shell=True)
								elif(tuple_macpost1[0] == 'exit'):
									exit(0)
								elif(tuple_macpost1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
									break
								elif(tuple_macpost1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")	
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usepost1 == '3'):
						call("ls -1 /usr/haxxor/post/linux", shell=True)
						while True:
							try:
								linuxpost1 = raw_input("[haxxor/post/linux] => ")
								tuple_linuxpost1 = linuxpost1.partition(" ")
								if(tuple_linuxpost1[0] == 'use'):
									call("python " + tuple_linuxpost1[2], shell=True)
								elif(tuple_linuxpost1[0] == 'exit'):
									exit(0)
								elif(tuple_linuxpost1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
									break
								elif(tuple_linuxpost[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow") 
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usepost1 == '4'):
						call("ls -1 /usr/haxxor/post/misc", shell=True)
						while True:
							try:
								miscpost1 = raw_input("[haxxor/post/misc] => ")
								tuple_miscpost1 = miscpost1.partition(" ")
								if(tuple_miscpost1[0] == 'use'):
									call("python " + tuple_miscpost1[2], shell=True)
								elif(tuple_miscpost1[0] == 'exit'):
									exit(0)
								elif(tuple_miscpost1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
                                                                        break
								elif(tuple_miscpost1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usepost1 == '5'):
						call("ls -1 /usr/haxxor/post/any", shell=True)
						while True:
							try:
								anypost1 = raw_input("[haxxor/post/any] => ")
								tuple_anypost1 = anypost1.partition(" ")
								if(tuple_anypost1[0] == 'use'):
									call("python " + tuple_anypost1[2], shell=True)
								elif(tuple_anypost1[0] == 'exit'):
									exit(0)
								elif(tuple_anypost1[0] == 'back'):
									print colored("[1] Windows\n[2] Mac\n[3] Linux\n[4] Misc\n[5] Any\n[6] Back", "blue")
									break
								elif(tuple_anypost1[0] == 'help'):
									print colored("==========================================", "yellow")
                                                                        print colored("help: this menu", "yellow")
                                                                        print colored("use: use scripts", "yellow")
                                                                        print colored("back: go back to previous menu", "yellow")
                                                                        print colored("exit: exit haxxor", "yellow")
                                                                        print colored("==========================================", "yellow")
								else:
									print colored("[!] Unknown command", "red")
							except KeyboardInterrupt:
								print colored("[!] Type 'exit' to exit or 'back' to go to previous menu", "yellow")
					elif(usepost1 == '6'):
						call("clear", shell=True)
						banner()
						break
					else:
						print colored("[!] Unknown option", "red")
				except KeyboardInterrupt:
					print colored("[!] Option #6 to go to previous menu", "yellow")
		except KeyboardInterrupt:
			print colored("[!] Interrupt", "red")
	def start_menu():
		try:
			menu_option = raw_input("[haxxor] => ")
			if(menu_option == '1'):
				fuzzers()
			elif(menu_option == '2'):
				modules()
			elif(menu_option == '3'):
				privesc()
			elif(menu_option == '4'):
				post()
			elif(menu_option == '5'):
				print colored("[==================================]", "yellow")
				print colored("[1-4: sub menus", "yellow")
				print colored("[5-7: different options", "yellow")
				print colored("[==================================]", "yellow")
			elif(menu_option == '6'):
				print colored("[You don't have to donate silly!", "red")
			elif(menu_option == '7'):
				exit(0)
			else:
				print colored("[!] Unknown option", "red")
		except KeyboardInterrupt:
			print colored("[!] Option #7 to exit", "red")
while True:
	main()		
