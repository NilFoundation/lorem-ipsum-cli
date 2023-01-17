# script for copying the output_dir_poseidon content to posiedon_proof folder for evm/s placeholder verification.

import os
import shutil

base_path = os.path.abspath(os.getcwd()) + '/..'
source = os.path.abspath(os.getcwd()) + '/output_dir_poseidon'
destination = os.path.abspath(os.getcwd()) + '/libs/evm-placeholder-verification/poseidon_proof'

try: 
    os.mkdir(destination) 
except OSError as error: 
    print(error)

# getting all the files in the source directory
files = os.listdir(source)
 
for fname in files:
     
    # copying the files to the
    # destination directory
    shutil.copy2(os.path.join(source,fname), destination)