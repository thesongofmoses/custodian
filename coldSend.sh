#!/bin/bash

cd ~/tonos-cli

for i in {1..x};
each_msg=$(cat ~/ton-keys/${1}.confirm.msg | awk "FNR == ${i}")
./tonos-cli send \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        "$each_msg"
done
