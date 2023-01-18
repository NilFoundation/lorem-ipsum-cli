# =nil; Lorem Ipsum CLI

[![Discord](https://img.shields.io/discord/969303013749579846.svg?logo=discord&style=flat-square)](https://discord.gg/KmTAEjbmM3)
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=flat-square&logo=telegram&logoColor=dark)](https://t.me/nilfoundation)
[![Twitter](https://img.shields.io/twitter/follow/nil_foundation)](https://twitter.com/nil_foundation)

# Introduction

This repository is for PoC of Lorem ipsum cli.It is intended to be used by applications & developers (dApps) who wish to use data
in trust-less manner from one cluster (ex MINA) into another (ex ETH). It provides a set of utilities & scripts to compile circuits, serialize inputs and validate
proofs on blockchain VMs. Users are recommended to check the proof market toolchain to outsource proof generation.

# Dependencies

- [Boost](https://www.boost.org/) == 1.76.0
- [cmake](https://cmake.org/) >= 3.5
- [clang](https://clang.llvm.org/) >= 14.0.6

On *nix systems, the following dependencies need to be present & can be installed using the following command

```
 sudo apt install build-essential libssl-dev libboost-all-dev cmake clang git python3.8
```
**We are aware of a compilation issue with boost libs having version higher than 1.76. Please use version 1.76.**


# Common issues

## Compilation Errors
If you have more than one compiler installed i.e g++ & clang++. The make system might pick up the former. You can explicitly force usage of
clang++ by finding the path and passing it in the variable below.

```
`which clang++`  
cmake .. -DCMAKE_CXX_COMPILER=<path to clang++ from above>
```

## Submodule management
Git maintains a few places where submodule details are cached. Sometimes updates do not come through. ex: Deletion , updating
a url of a previously checked out submodule.It is advisable to check these locations for remains or try a new checkout.
- .gitmodules
- .git/config
- .git/modules/*

# Documentation 
Documentation portal for proof market is located [here](https://docs.nil.foundation/proof-market).
Users are encouraged to check [zkLLVM](https://github.com/NilFoundation/zkllvm) project which is tightly coupled to the proof market.


## Support

Additional support can be obtained by contacting the team at [Telegram](https://t.me/nilfoundation) and [Discord](https://discord.gg/KmTAEjbmM3).

