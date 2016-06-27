Last login: Mon Jun 27 01:16:04 on ttys000
MB-Air-2:haxxor-framework Hannah$ cd
MB-Air-2:~ Hannah$ ls
Applications		Library			d0xk1t
Code			Movies			haxxor-framework
Desktop			Music			iso
Documents		Pictures
Downloads		Public
MB-Air-2:~ Hannah$ cd haxxor-framework/
MB-Air-2:haxxor-framework Hannah$ ls
LICENSE		REQUIREMENTS	modules		uninstall.py
README.md	haxxor.py	setup.py
MB-Air-2:haxxor-framework Hannah$ cd
MB-Air-2:~ Hannah$ clear










MB-Air-2:~ Hannah$ ls
Applications		Library			d0xk1t
Code			Movies			haxxor-framework
Desktop			Music			iso
Documents		Pictures
Downloads		Public
MB-Air-2:~ Hannah$ cd Documents/
MB-Air-2:Documents Hannah$ git clone https://www.github.com/R3C0Nx00/haxxor-framework
Cloning into 'haxxor-framework'...
remote: Counting objects: 1083, done.
remote: Compressing objects: 100% (8/8), done.
remote: Total 1083 (delta 1), reused 0 (delta 0), pack-reused 1075
Receiving objects: 100% (1083/1083), 51.80 MiB | 7.72 MiB/s, done.
Resolving deltas: 100% (492/492), done.
Checking connectivity... done.
MB-Air-2:Documents Hannah$ sudo python se
/usr/local/Cellar/python/2.7.11/Frameworks/Python.framework/Versions/2.7/Resources/Python.app/Contents/MacOS/Python: can't open file 'se': [Errno 2] No such file or directory
MB-Air-2:Documents Hannah$ cd haxxor-framework/
MB-Air-2:haxxor-framework Hannah$ sudo python setup.py 
[!] Make sure you are in the haxxor-framework directory
[!] Ctrl+C to exit to change, I'll wait
[?] Start haxxor now [yes/no]: yes
  File "/usr/bin/haxxor", line 76
    usewinfuzzer1 = raw_input("[haxxor/fuzzers/windows/browser] => ")
                ^
IndentationError: expected an indented block
MB-Air-2:haxxor-framework Hannah$ cd
MB-Air-2:~ Hannah$ clear

MB-Air-2:~ Hannah$ clear























MB-Air-2:~ Hannah$ cd Code/
MB-Air-2:Code Hannah$ cd python/
MB-Air-2:python Hannah$ cd haxxor-framework/
MB-Air-2:haxxor-framework Hannah$ vim haxxor.py 


























































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
        print colored("[ [{}] Fuzzers [{}] Modules                                      ]".format(list_fuzzers, list_modules), "blue")
        print colored("[ [{}] Privesc [{}] Post                                         ]".format(list_privesc, list_post), "blue")
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

