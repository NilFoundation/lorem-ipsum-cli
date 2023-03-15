import requests
import json
import sys
import argparse


def get_mina_ledger_state(url):
    query = """
    query MyQuery {
    blockchainVerificationKey
    bestChain {
        protocolStateProof {
        json
        }
        protocolState {
        previousStateHash
        consensusState {
            blockHeight
            blockchainLength
            epoch
            epochCount
            hasAncestorInSameCheckpointWindow
            lastVrfOutput
            minWindowDensity
            nextEpochData {
            epochLength
            ledger {
                hash
                totalCurrency
            }
            lockCheckpoint
            seed
            startCheckpoint
            }
            slot
            slotSinceGenesis
            totalCurrency
            stakingEpochData {
            epochLength
            ledger {
                hash
                totalCurrency
            }
            lockCheckpoint
            seed
            startCheckpoint
            }
        }
        blockchainState {
            date
            snarkedLedgerHash
            stagedLedgerHash
            stagedLedgerProofEmitted
            utcDate
        }
        }
    }
    }
    """
    request_res = requests.post(url, json={"query": query}).json()
    protocol_state = request_res["data"]["bestChain"][0]
    request_res["data"]["bestChain"] = [protocol_state]
    print("Fetching data for block height: {}".format(protocol_state["protocolState"]["consensusState"]["blockHeight"]))
    print("Hash: {}".format(protocol_state["protocolState"]["blockchainState"]["snarkedLedgerHash"]))
    return request_res


def get_mina_account_state(url, address):
    query = '''
    query {{
      account(publicKey: "{0}" ) {{
        index
        zkappState
        balance {{
          liquid
          locked
          stateHash
        }}    
        leafHash
        receiptChainHash
        merklePath {{
          left,
          right
        }}
      }}
    }}
    '''.format(address)
    request_res = requests.post(url, json={"query": query}).json()
    return request_res


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog='Mina Helper for =nil; Proof Market',
        description='Mina Helper retrieves data related to Proof Market functionality from Mina node')
    parser.add_argument('--url', help="GraphQL URL", default="https://proxy.berkeley.minaexplorer.com/")
    parser.add_argument('--output', help="Output file path", default="output.json")
    parser.add_argument('--address', help="Mina public key of zkApp or user", default="")
    parser.add_argument('--type', help="Query type: ledger or account", default="")

    args = parser.parse_args()
    url = args.url
    output_path = args.output
    address = args.address
    query_type = args.type
    res = ""

    if query_type == "ledger":
        res = get_mina_ledger_state(url)
    elif query_type == "account":
        if address == "":
            print("Missing --address flag")
            exit(-1)
        res = get_mina_account_state(url, address)
    else:
        print("Missing query type argument --type")
        exit(-1)

    with open(output_path, 'w') as f:
        sys.stdout = f  # Change the standard output to the file we created.
        print(json.dumps(res, indent=4))
