#!/bin/bash

rm ~/ton-keys/${1}.msg.csv
cd ~/main.ton.dev/tonos-cli/target/release

for i in {1..x};
do
each_raw_addr=$(cat ~/ton-keys/"${1}.raw.csv" | awk "FNR == ${i}")
each_dest_addr=$(cat ~/ton-keys/"${1}.dest.csv" | awk "FNR == ${i}")
random_amount=$(echo $((RANDOM % 9+1))*1000000000 | bc -l)
each_amount=$(expr $(cat ~/ton-keys/"${1}.amount.csv" | awk "FNR == ${i}") - $random_amount)
./tonos-cli message $each_raw_addr submitTransaction \
        "{"\"dest"\":"\"$each_dest_addr"\","\"value"\":$each_amount,"\"bounce"\":true,"\"allBalance"\":false,"\"payload"\":"\""\"}" \
        --abi ~/main.ton.dev/ton-labs-contracts/solidity/safemultisig/SafeMultisigWallet.abi.json \
        --sign ~/ton-keys/"${1}_${i}.keys.json" --lifetime 3600 | awk 'FNR == 13 {print $2}' >> ~/ton-keys/${1}.msg.csv
done
