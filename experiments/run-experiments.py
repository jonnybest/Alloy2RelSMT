#!/usr/bin/python
# 1. traverse folders with python - ok
# 2. look at each file and print the content -ok
# 3. write the content to a central log file

import os
from os.path import join
import subprocess
#from z3 import *

thisfile = os.path.realpath(__file__)
thispath = os.path.dirname(thisfile )
z3cmd = "~/Programs/z3/build/z3"
z3args = " -st -v:1 -smt2 -T:550 "
alloy2relsmtcmd = "java"
alloy2relsmtparam = " -jar ~/Programs/alloy2RelSMT/alloy2relsmt.jar -f "
resultfilename = "resultfile.txt"

print "This path is :" + thispath
print "This directory is known as :" + os.curdir
print "We run in file: " + __file__
os.chdir(thispath)

os.remove(resultfilename)

for dirpath, dirnames, filenames in os.walk(thispath, topdown=False):
# mitigate git archives
    if '.git' in dirpath:
        continue 
    if '.git' in dirnames:
        dirnames.remove('.git')

# debugging messages
    print "new folder found"
    print dirpath
    print dirnames
    print filenames
# start doin real stuff
    for file in filenames:
# skip bad files
        if  ".log" in file:
            continue
        if  ".txt" in file:
            continue
        if ".smt2" in file:
            continue
# prepare arguments
        filepath = join(dirpath, file)
# open the log file
        with open(resultfilename, "a") as resultfile:
# run alloy2relsmt
            smtfile = file + ".smt2"
            print [alloy2relsmtcmd, alloy2relsmtparam + filepath + " " +join(dirpath, smtfile)]
            output = subprocess.check_output([alloy2relsmtcmd + alloy2relsmtparam + filepath + " " + join(dirpath, smtfile)], shell=True)
            resultfile.write("--- " + file + " ---\n")
            resultfile.writelines(output)
            print output
# run z3 on resulting file
            output = subprocess.check_output([z3cmd + z3args + join(dirpath, smtfile)], shell=True)
            resultfile.writelines(output)
            print output
# end of doing stuff to file
            resultfile.write("\n")
print "done"