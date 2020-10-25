#!/bin/bash

cd ~/tonos-cli
rm ~/ton-keys/${1}.confirm.msg 

for i in {1..x};
each_raw_addr=$(cat ~/ton-keys/"${1}.raw.csv" | awk "FNR == ${i}")
each_txid=$(cat ~/ton-keys/"${1}.confirm.txid" | awk "FNR == ${i}")
./tonos-cli message $each_raw_addr confirmTransaction "{"\"transactionId"\":"\"$each_txid"\"}" \
        --abi SafeMultisigWallet.abi.json --sign ~/ton-keys/"${1}_${i}.keys.json" --lifetime 3600 >> ~/ton-keys/${1}.confirm.msg 
done
