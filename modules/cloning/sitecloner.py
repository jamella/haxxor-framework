#!/usr/bin/env python
import os, sys
from subprocess import call
from termcolor import colored
print colored("[=====================================]", "blue")
print colored("[         SITE CLONER V.01            ]", "blue")
print colored("[Written by: Taylor Puckett           ]", "blue")
print colored("[June 10, 2016                        ]", "blue")
print colored("[Open Source                          ]', "blue")
print colored("[=====================================]", "blue')
def cloner():
  try:
    site2clone = raw_input("[site] => ")
    if(site2clone != 'exit'):
      call("wget " + site2clone + " " + " -O index.html && mv index.html /var/www/html && service apache2 start", shell=True)
      print("<END> DONE. BROWSE TO YOUR IP <END>")
    else:
      leave_apache_running = raw_input("[?] Leave apache2 running [yes/no]: ")
      if(leave_apache_running == 'yes'):
        sys.exit(0)
      else:
        call("service apache2 stop && rm /var/www/html/index.html", shell=True)
        sys.exit(0)
  except KeyboardInterrupt:
    print("\n Type 'exit' to exit")
while True:
  cloner()
