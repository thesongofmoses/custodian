#!/bin/bash

cd ~/main.ton.dev/tonos-cli/target/release
rm ~/ton-keys/${1}.amount.csv

for i in {1..x};
cd ~/node.operator/scripts && \
        ./liteClient.sh "getaccount ${each_raw_addr}" | tail -n 1 | tr -d '=''ng' | awk '{print $4}') >> ~/ton-keys/${1}.amount.csv
done
