#!/usr/bin/python
# 1. traverse folders with python - ok
# 2. look at each file and print the content -ok
# 3. write the content to a central log file

import os
from os.path import join
import subprocess
import string
import re
#from z3 import *

# BEGIN helper functions
def extractTime(lines):
    line = string.split(lines, "\n")
    timelines = [i for i in line if "time" in i]
    if(len(timelines) < 1):
        return ""
    timeline = timelines[0]
    regres = re.findall("\d+.\d+",  timeline)
    if (len(regres) < 1):
        return "(parse error)"
    time = regres[0]
    return time

def extractSat(lines):
    line = string.split(lines, "\n")
    satlines = [i for i in line if "sat" in i]
    if(len(satlines) < 1):
        return ""
    else:
        return satlines[0]
    
def extractError(lines):
    line = string.split(lines, "\n")
    errorlines = [i for i in line if "error" in i]
    if(len(errorlines) < 1):
        return ""
    else:
        return "error"
    
def extractTimeout(lines):
    line = string.split(lines, "\n")
    timeoutlines = [i for i in line if "timeout" in i]
    if(len(timeoutlines) < 1):
        return ""
    else:
        return "timeout"

def extractResult(lines):
    result = extractSat(lines)
    if(len(result) > 0):
        return [result, extractTime(lines)]
    result = extractTimeout(lines)
    if(len(result) > 0):
        return [result]
    result = extractError(lines)
    if(len(result) > 0):
        return [result]
    else:
        return ["(no results)"]

# END functions

thisfile = os.path.realpath(__file__)
thispath = os.path.dirname(thisfile )
z3cmd = "~/Programs/z3/build/z3"
timeout = str(550) #str(15) #str(550)
z3args = " -st -v:1 -smt2 -T:" + timeout + " "
alloy2relsmtcmd = "java"
alloy2relsmtparam = " -jar ~/Programs/alloy2RelSMT/alloy2relsmt.jar -f "
resultfilename = "resultfile.txt"

print "This path is :" + thispath
print "This directory is known as :" + os.curdir
print "We run in file: " + __file__
os.chdir(thispath)

with open(resultfilename, "w") as resultfile:
    resultfile.write("=== Alloy2RelSMT result file ===\n")
    resultfile.write("; timeout is set to "+timeout+"\n")

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
        if ".py" in file:
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
            if(len(extractError(output)) > 0):
                resultfile.write("; conversion error\n")
                resultfile.write(output)
            print output
# run z3 on resulting file
            output = subprocess.check_output([z3cmd + z3args + join(dirpath, smtfile)], shell=True)            
            resultfile.write(str(extractResult(output)))
            resultfile.write("\n")
            print output
# end of doing stuff to file
            resultfile.write("\n")

with open(resultfilename, "a") as resultfile:
    resultfile.write("\n=== done ===\n")
print "done"