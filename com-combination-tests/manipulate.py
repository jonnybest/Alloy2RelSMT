import glob
import sys
import shutil

print "Open base file for reading"
basefilename = "com_theorem_base"

for file in glob.glob("*.als"):
    if file.startswith("from"):
        continue
    print "Dealing with: " + file
    with open(file, "r") as alsfh:
        nameparts = []
        for dotpart in file.split("."):
            dashparts = dotpart.split("-")
            for p in dashparts:
                nameparts.append(p)
        if len(nameparts) < 4:
            nameparts.insert(0, "model")
        
        print nameparts
        lines = alsfh.read().splitlines()
        lines = lines[41:]

        newalsfilename = "from-" + nameparts[0] + "-to-" + nameparts[2] + ".als"
        shutil.copyfile(basefilename, newalsfilename)
        with open(newalsfilename, "a") as newfile:
            newfile.flush()
            newfile.write("\n".join(lines))
