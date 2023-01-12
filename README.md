# =nil; Lorem Ipsum CLI

# Introduction

This repository serves as a PoC of Lorem Ipsum data transfer protocol.

# In-Progress
Integration with assigner,prepare_external_gate_argument and EVM-placeholder-verification is still in progress. 
Below steps are performed individually for each repositories.

# Dependencies used
 - Boost >= 1.74.0
 - CMake >= 3.5
 - Clang >= 14.0.6


# Steps

NOTE : The below steps work fine for gcc (9.4.x above)compilers only. There are few inconsistencies with clang 14 version to build.
 - Clone repo
    git clone --recurse-submodules git@github.com:NilFoundation/zkllvm.git

    cd zkllvm    

 - Configure CMake 

   cmake -G "Unix Makefiles" -B ${ZKLLVM_BUILD:-build} -DCMAKE_BUILD_TYPE=Release .

 - Build assigner in the Zkllvm repo and generate examples.

   Example of output from poseidon binary file is in input_dir_poseidon folder. 

    make -C ${ZKLLVM_BUILD:-build} assigner clang -j$(nproc) 

    make -C ${ZKLLVM_BUILD:-build} circuit_examples -j$(nproc)
    
    It will generate the binary files for certain schemes like arithmetics,poseidon for producing hash etc.

   ${ZKLLVM_BUILD:-build}/bin/assigner/assigner -b ${ZKLLVM_BUILD:-build}/examples/poseidon_example.bc -i examples/poseidon.inp -t assignment_table.data -c circuit.bin 
   
   It will generate assignment table and circuit files. These files are stored in input_dir_poseidon folder to serve as input for generating gate argument via running scripts from prepare_external_gate_argument.

 - Clone repo to execute below scripts from prepare_external_gate_argument 

    git clone --recurse-submodules git@github.com:NilFoundation/zkllvm.git
    cd zkllvm 
    
    cmake -G "Unix Makefiles" -B ${ZKLLVM_BUILD:-build} -DCMAKE_BUILD_TYPE=Release .

   Input : input_dir_poseidon is considered as input.

   Output : output_dir_poseidon is the output folder.

   prepare output of zkllvm for poseidon : 
            ./build/bin/prepare_external_gate_argument/prepare_external_gate_argument gen_gate_argument input_dir_poseidon output_dir_poseidon

   build test proof :
            ./build/bin/prepare_external_gate_argument/prepare_external_gate_argument gen_test_proof input_dir_poseidon output_dir_poseidon 

 - Deploy and test the output of prepare_external_gate_argument to EVM-placeholder-verification
    - Copy the output_dir_poseidon folder from the above execution and paste inside evm-placeholder-verification directory.
    - Execute python scripts in the 18 Branch of evm-placeholder-verification repo. 
        1. Deploy the gate arguments using the script : python3 ./web3_deploy_gate_argument.py output_dir_poseidon 
        This will generate the addr file which is used to check the address for deployment.

        2. Verify the Proof : python3 ./web3_placeholder_universal_test.py output_dir_poseidon
        In the output, it will generate a proof's hash and verifible address. 
        It is similar to the deployed address. Hence, proof verified for deployment on EVM.
    
