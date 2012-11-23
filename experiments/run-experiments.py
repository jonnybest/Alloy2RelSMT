# 1. traverse folders with python
# 2. look at each file and print the content
# 3. write the content to a central log file

import glob
import sys
import os
path = os.path.dirname(__file__)
print path
filter = path + os.path.altsep + "*"#+"*.als"
print filter

theBigG = glob.glob(filter)
print theBigG
for f in theBigG:
    with open(f, "r") as myfile:
        print myfile.readline()
