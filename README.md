# =nil; Lorem Ipsum CLI

[![Discord](https://img.shields.io/discord/969303013749579846.svg?logo=discord&style=flat-square)](https://discord.gg/KmTAEjbmM3)
[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=flat-square&logo=telegram&logoColor=dark)](https://t.me/nilfoundation)
[![Twitter](https://img.shields.io/twitter/follow/nil_foundation)](https://twitter.com/nil_foundation)

# Introduction

This repository is for PoC of Lorem ipsum cli.It is intended to be used by applications & developers (dApps) who wish to use data
in trust-less manner from one cluster (ex MINA) into another (ex ETH). It provides a set of utilities & scripts to compile circuits, serialize inputs and validate
proofs on blockchain VMs. Users are recommended to check the proof market toolchain to outsource proof generation.

# Dependencies

- [python](https://www.python.org/) >= 3.7

# Setup

## Clone this repository 
```
git clone git@github.com:NilFoundation/lorem-ipsum-cli.git
cd lorem-ipsum-cli
```

## Install dependencies 
```
pip install -r requirements.txt 
```

# Usage

## Get Mina ledger state proof

Mina's ledger state can be retrieved as follows:
```
python3 scripts/protocol/mina/get_mina_state.py ledger --url=<rpc_endpoint> --output=<file_location>
```
Parameters:
- url (optional) : GraphQL endpoint of the node
- output (optional) : Location to store the state

ex:
```
python3 scripts/protocol/mina/get_mina_state.py ledger 
```

## Get Mina account state

Account state in MINA (user account or zkApp state) can be retrieved as follows:

```
python scripts/protocol/mina/get_mina_state.py account --url=<rpc_endpoint> --address=<user/zkapp public key> --output=<file_location>
```
- address (req) : Public key of MINA zkApp or user.   
- url (optional): GraphQL endpoint of the node
- output (optional): Location to store the state

ex:
```
 python3 scripts/protocol/mina/get_mina_state.py account --address B62qqDDQbUCSnmneB2HCefKVAqJuuoy7AcKHy8tLUvnP9cZww8AFCMS
```

# Documentation 
Documentation portal for proof market is located [here](https://docs.nil.foundation/proof-market).
Users are encouraged to check [zkLLVM](https://github.com/NilFoundation/zkllvm) project which is tightly coupled to the proof market.


## Support
Additional support can be obtained by contacting the team at [Telegram](https://t.me/nilfoundation) and [Discord](https://discord.gg/KmTAEjbmM3).

