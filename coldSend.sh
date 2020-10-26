#!/bin/bash

cd ~/main.ton.dev/tonos-cli/target/release

for i in {1..x};
do
each_msg=$(cat ~/ton-keys/${1}.confirm.msg | awk "FNR == ${i}")
./tonos-cli send \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        "$each_msg"
done
