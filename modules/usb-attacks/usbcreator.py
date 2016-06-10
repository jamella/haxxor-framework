#!/usr/bin/env python
import os, time, sys, commands
from subprocess import call
try:
  import pyusb
except ImportError:
  print("[!] You are missing pyusb, install it to use usbcreator")
  sys.exit(0)

def
