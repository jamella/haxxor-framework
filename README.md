# Haxxor-framework
haxxor-framework is a fuzzing and privilege escalation framework with various modules. post exploitation will be handled by p0stEX (my new project [https://www.github.com/R3C0Nx00/p0stEX]) The post exploitation part will be removed from this project. The two projects work together, but they also work as standalone tools. Both are written in Python. They *DO NOT* depend on each other.
# Mac OSX unsupported
At the moment, Mac OSX is unsupported due to setup script failures. This problem will be fixed by the end of the week, but I need time to work on it. Sorry Mac users, it will be fixed I promise.
# How to use haxxor-framework
##0. git clone haxxor-framework
This one should be a no brainer, but for people who don't know how to clone, here is how (that's why I labled it 0)

* First, open up terminal on your *NIX machine

(Sorta looks like this):
![picture alt](http://www.mikebeas.com/wordpress/wp-content/uploads/2014/06/terminal.png)

* Second, make sure you have git installed

On Ubuntu (or on any non-rooted NIX machine)
```bash
sudo apt-get install git
```

On Kali Linux (or any rooted NIX machine)
```bash
apt-get install git
```

* Second, clone the repository

For any NIX machine this shoud work
```bash
git clone https://www.github.com/R3C0Nx00/haxxor-framework.git
```

That's how you git clone the repository on any NIX machine. If you want to read up on some other cool things you can do via git command line, check out [this](https://git-scm.com/docs/gittutorial) site.

* Finally, change into the directory
```bash
cd downloadpath/haxxor-framework
```

##1. Install dependencies

* For Ubuntu (or any other non-root *NIX machine)

Run:
```bash
sudo pip install -r REQUIREMENTS
```

* For Kali Linux (or any root *NIX machine)

Run:

```bash
pip install -r REQUIREMENTS
```

##2. Run setup script

* For Ubuntu (or any non-root *NIX machine (not Mac OSX))

```bash
sudo python setup.py
```

* For Kali Linux (or any rooted *NIX machine)
```bash
python setup.py
```
## Start haxxor-framework

* For Ubuntu (or any non-rooted *NIX machine)
```bash
sudo haxxor
```

* For Kali Linux (or any rooted *NIX machine)
```bash
haxxor
```

## Uninstall
If you do not like haxxor-framework, find bugs, and etc, you can easily uninstall it.

* For Ubuntu (or any non-rooted *NIX machine)
```bash
sudo python uninstall.py
```
You *HAVE* to be in the haxxor-framework directory for this to work

* For Kali Linux (or any rooted *NIX machine)
```bash
python uninstall.py
```

## Getting updates
You should check github weekly for haxxor-framework updates.

There are two ways to get updates
* First option
You can do:

 * For Ubuntu (or non-rooted *NIX machine) 
```bash
cd downloadpath/haxxor-framework && sudo python uninstall.py && cd .. && sudo rm -r haxxor-framework
```
Then:
```bash
git clone https://www.github.com/R3C0Nx00/haxxor-framework.git
```

 ** For Kali Linux (or any rooted *NIX machine)
```bash
cd downloadpath/haxxor-framework && python uninstall.py && cd .. && rm -r haxxor-framework
```

* Second option
This one should work root or non-root (besides uninstall.py (requires root))

```bash
cd downloadpath/haxxor-framework && sudo python uninstall.py && git pull
```
If running root, you can remove the sudo before the:
```bash
python uninstall.py
```

# Upcoming features
* Adding actual fuzzers
 * Should be coming in v1.3 (3 micro versions ahead)
* Multi language fuzzer/module/privilege escalation script support
 * Adding Ruby, C, Java, JavaScript, C++, and so much more.
* Exploitation

For this one, I thought I should fill some space that post exploitation stuff left a space in. This will use Exploit DB exploits (maintained by Offensive Security). You can Exploit DB at [this](https://www.exploit-db.com/) link and Offensive Security at [this](https://www.offensive-security.com/) link. 
# Bugs and New features
If there are any bugs in this program, you can report them in the issues part of this project. I will typically fix the bug within one or two days. Also, If you have a feature ideas/requests, email them to pentestwizard@gmail.com
# Windows Version?
There will be a Windows version in the future (it will be written in python), but for now Windows users, run it in VMWare/VirtualBox/whatever other virtual technology.
# Final Notes
Yes, I know that haxxor.py has issues and I am working on those, but other than that, enjoy the project
```python
while True:
  print("[-] Hack the planet!")
```
