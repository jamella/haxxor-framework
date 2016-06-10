#!/usr/bin/env python
import os, sys, socket
from subprocess import call
ip = socket.gethostbyname(socket.gethostname())

def cloner():
  try:
    site2clone = raw_input("[site] => ")
    call("wget " + site2clone + " " + "&& mv index.html /var/www/html && service apache2 start", shell=True)
    print("<END> Browse to {} <END>".format(ip)) 
  except KeyboardInterrupt:
    print("\n")
    sys.exit(0)
while True:
  cloner()
