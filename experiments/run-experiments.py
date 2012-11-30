# 1. traverse folders with python - ok
# 2. look at each file and print the content -ok
# 3. write the content to a central log file

import os
import random
from os.path import join
#from z3 import *

# globals
z3results = ["unsat", "sat", "timeout"]
# end globals

# BEGIN function definitions

# this function should call z3 and determine its result
def z3(smtfile, timeout):
    # prepare a seperate log file for individual results
    logfile = smtfile + ".log"
    # simulate a call to z3
    # return a result tuple consisting of [z3result, ]
    return random.choice(z3results)

# this function invokes the Alloy2RelSMT translator and returns a filename of the translation
def translate(sourcefile):
    # invoke the translator
    
# END functions

thisfile = os.path.realpath(__file__)
thispath = os.path.dirname(thisfile )

print "This path is :" + thispath
print "This directory is known as :" + os.curdir
print "We run in file: " + __file__
os.chdir(thispath)
timeout = 60

with open("experiment.log", "w") as resultfile:
    
    for dirpath, dirnames, filenames in os.walk(thispath, topdown=False):
        print "new folder found"
        if '.git' in dirnames:
            dirnames.remove('.git')
        #print dirpath
        #print dirnames
        #print filenames
        for file in filenames:
            file = join(dirpath, file)
            with open(file, "r") as myfile:
                result = z3(myfile.name, timeout)
                print file + " resulted was found to be " + str(result)
                resultfile.write (myfile.name + " : " + result + " (" + str(timeout) + ")\n") #str(myfile.read()))
    resultfile.write("\n")
print "done"

