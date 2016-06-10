#!/usr/bin/env python
import os, sys
from subprocess import call

def cloner():
  try:
    site2clone = raw_input("[site] => ")
    call("wget " + site2clone + " " + " > index.html && mv index.html /var/www/html && service apache2 start", shell=True)
    print("<END> DONE. BROWSE TO YOUR IP <END>")
  except KeyboardInterrupt:
    print("\n")
    sys.exit(0)
while True:
  cloner()
