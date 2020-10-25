#!/bin/bash

cd ~/main.ton.dev/tonos-cli/target/release

for i in {1..X};
do
pubkey=$(echo 0x$(cat ~/ton-keys/"${1}_${i}.keys.json" | grep 'public' | awk '{print $2}' | tr -d '"'\,))
signs=(~/ton-keys/"${1}_${i}.keys.json")
./tonos-cli deploy ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.tvc \
        "{"\"owners"\":["\"$pubkey"\"],"\"reqConfirms"\":1}" \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        --sign "$signs" \
        --wc 0
done
