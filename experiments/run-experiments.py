# 1. traverse folders with python - ok
# 2. look at each file and print the content -ok
# 3. write the content to a central log file

import os
from os.path import join
#from z3 import *

thisfile = os.path.realpath(__file__)
thispath = os.path.dirname(thisfile )

print "This path is :" + thispath
print "This directory is known as :" + os.curdir
print "We run in file: " + __file__
os.chdir(thispath)

with open("experiment.log", "w") as resultfile:
    
    for dirpath, dirnames, filenames in os.walk(thispath, topdown=False):
        print "new folder found"
        if '.git' in dirnames:
            dirnames.remove('.git')
        print dirpath
        print dirnames
        print filenames
        for file in filenames:
            file = join(dirpath, file)
            with open(file, "r") as myfile:
                resultfile.write ( "I found some text in " + myfile.name + "\n") #str(myfile.read()))
    resultfile.write("\n")
print "done"