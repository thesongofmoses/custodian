#!/bin/bash

cd ~/main.ton.dev/tonos-cli/target/release
rm ~/ton-keys/${1}.confirm.txid

for i in {1..x};
each_raw_addr=$(cat ~/ton-keys/"${1}.raw.csv" | awk "FNR == ${i}")
./tonos-cli run $each_raw_addr getTransactions {} \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json >> ~/ton-keys/${1}.confirm.txid
