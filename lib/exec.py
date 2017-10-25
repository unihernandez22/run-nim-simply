# Python 3 file

import subprocess
import time
import sys

script = sys.argv[1]

start = time.time()
process = subprocess.run(['python', script], stderr=subprocess.STDOUT)
exitcode = process.returncode


end = time.time()

seconds = end - start

print()
print(
    'Process return {0} ({1})   execution time: {2:.03f} s'.format(exitcode, hex(exitcode), seconds))
subprocess.call("pause", shell=True)
