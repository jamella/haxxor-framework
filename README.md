# don't use it's buggy again 
More bugs and you will run into issues, I'm working on a fix
# haxxor-framework
Fuzzing, Scanning, Privilege Escalation, and Post-Exploitation framework. Written 100% in Python 2.7 for Linux/Mac OS
## How to use haxxor-framework
###First, install needed requirements by running:
  ```bash
  pip install -r REQUIREMENTS
  ```
  If anymore modules are needed, post an issue so they can be added to the REQUIREMENTS file

###Second, make sure you are running as root (Mac/Linux)

For Ubuntu it would be:
  ```bash
  sudo python #downloadpath/setup.py
  
  sudo haxxor
  ```
  And if you want to uninstall:
  ```bash
  sudo python uninstall.py
  ```
  This moves the directories back to the haxxor-framework directory for easy reinstallation.
  
Mac (same as Ubuntu)

Kali Linux (or any distro running out of box root)
  ```bash
  python #downloadpath/setup.py
  
  haxxor
  ```
  And if you want to uninstall
  ``` bash
  python uninstall.py
  ```
  This moves the directories back to the haxxor-framework directory for easy reinstallation.
  
# How does it work
It integrates some prewritten tools (credit is given) and some written by me (aka sitecloner)
# Why should you use it?
idk. I thinks it's cool. Lol.
# Windows Version?
JeEz, pushy much? *wheezes*  Later...
# Progress
As of 7-19-16, haxxor-framework has had some major changes (v.04), but is still not done. Email modules that can be used to: pentestwizard@gmail.com (Python or a language that can be ported to python. Multi language support coming soon)
# Other optional tools written for haxxor-framework
Well, I've decided to remove the post exploitation part of this project due to another tool being developed (p0stEX). p0stEX is a more in depth post exploitation framework that will do things such as backdoors, in-depth privilege escalation, and so much more. At the moment, haxxor-framework will still have post exploitation parts, but they will be removed in version 1.1 (coming in a few days (June 28, 2016)). The link to p0stEX is: https://www.github.com/R3C0Nx00/p0stEX
# Version 1.1
Like previously stated in the post exploitation part, post exploitation stuff will be removed from haxxor-framework and will be more focused on in the p0stEX project.
# Final Notes
```python
while True:
  print("[*] Hack the planet!")
```

