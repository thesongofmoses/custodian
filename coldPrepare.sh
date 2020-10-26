#!/bin/bash

cd ~/main.ton.dev/tonos-cli/target/release
rm ~/ton-keys/${1}.confirm.txid
rm ~/ton-keys/${1}.amount.csv

for i in {1..x};
each_raw_addr=$(cat ~/ton-keys/"${1}.raw.csv" | awk "FNR == ${i}")
./tonos-cli run $each_raw_addr getTransactions {} \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json >> ~/ton-keys/${1}.confirm.txid

cd ~/node.operator/scripts && \
        ./liteClient.sh "getaccount ${each_raw_addr}" | tail -n 1 | tr -d '=''ng' | awk '{print $4}') >> ~/ton-keys/${1}.amount.csv
done
