# =nil; Lorem Ipsum CLI

# Introduction

This repository serves as a PoC of Lorem Ipsum data transfer protocol.

# In-Progress
Integration with circuit_transpiler(to prepare gate argument) and EVM-placeholder-verification is still in progress. 
Below steps are performed individually for each repositories.

# Dependencies used
 - Boost >= 1.74.0
 - CMake >= 3.5
 - Clang >= 14.0.6


# Steps to build on Linux

NOTE : The below steps work fine for gcc (9.4.x above)compilers only. There are few inconsistencies with clang 14 version to build.
 - Clone repo

             git clone git@github.com:NilFoundation/lorem-ipsum-cli.git

             cd lorem-ipsum-cli    

 - Configure CMake 

             cmake -G "Unix Makefiles" -B ${ZKLLVM_BUILD:-build} -DCMAKE_BUILD_TYPE=Release .

    Example of output for poseidon binary file is in input_dir_poseidon folder. 

 - Execute below scripts from lorem-ipsum-cli directory to build for circuit_transpiler 

            make -C ${ZKLLVM_BUILD:-build} circuit_transpiler -j$(nproc)

   Input : input_dir_poseidon is considered as input.

   Output : output_dir_poseidon is the output folder.

   Prepare output of zkllvm for poseidon :   
   
               ./build/bin/circuit_transpiler/circuit_transpiler gen_gate_argument input_dir_poseidon output_dir_poseidon

   Build test proof :   
   
              ./build/bin/circuit_transpiler/circuit_transpiler gen_test_proof input_dir_poseidon output_dir_poseidon 

 - Deploy and test the output of circuit_transpiler (gate argument) to EVM-placeholder-verification
    - Execute copy_poseidon_proof.py from lorem-ipsum cli.
    - Execute python scripts in the libs/evm-placeholder-verification/test directory. 
        1. Deploy the gate arguments using the script :  
        
                   python3 ./web3_deploy_gate_argument.py poseidon_proof 
        This will generate the addr file inside output_dir_poseidon folder which is used to check the address for deployment.

        2. Verify the Proof :     
        
                      python3 ./web3_placeholder_universal_test.py poseidon_proof
        In the output, it will generate a proof's hash and verifiable address. 
        It is similar to the deployed address. Hence, proof verified for deployment on EVM.
    
