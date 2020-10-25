#!/bin/bash

rm ~/ton-keys/${1}.csv
cd ~/main.ton.dev/tonos-cli/target/release

for i in {1..X};
do
seed_phrase=$(./tonos-cli genphrase | awk 'FNR == 3' | sed 's/^.\{13\}//')
pubkey=$(./tonos-cli genpubkey "${seed_phrase}" | awk 'FNR == 3 {print $3}')
        echo "${seed_phrase}" >> ~/ton-keys/"${1}.seed.csv"
        printf "0x%s\n" "$pubkey" >> ~/ton-keys/"${1}.pub.csv"
each_seed_phrase=$(cat ~/ton-keys/"${1}.seed.csv" | awk "FNR == ${i}")
        ./tonos-cli getkeypair ~/ton-keys/"${1}_${i}.keys.json" "$each_seed_phrase"
done
