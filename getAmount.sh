#!/bin/bash

rm ~/ton-keys/${1}.amount.csv

for i in {1..x};
do
each_raw_addr=$(cat ~/ton-keys/"${1}.raw.csv" | awk "FNR == ${i}")
cd ~/node.operator/scripts && \
        ./liteClient.sh "getaccount ${each_raw_addr}" | tail -n 1 | tr -d '=''ng' | awk '{print $4}') >> ~/ton-keys/${1}.amount.csv
done
