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
    f'Process return {exitcode} ({hex(exitcode)})   execution time: {seconds:.03f} s')
subprocess.call("pause", shell=True)
