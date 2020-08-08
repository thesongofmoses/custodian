#!/bin/bash

if [ -f "${1}_seed.csv" ] || [ -f "${1}_pub.csv" ] || [ -f "${1}_1_keypair.json" ] || [ -f "${1}_2_keypair.json" ] || [ -f "${1}_3_keypair.json" ];
then
        echo "Error: duplicate file name(s)"
        exit 1
fi

if [ $# != 2 ];
then
        echo "Error: <command> <file_name> <wc>"
        exit 1
fi

for i in {1..100};
do
seed_phrase=$(./tonos-cli genphrase | awk 'FNR == 3' | sed 's/^.\{13\}//')
pubkey=$(./tonos-cli genpubkey "${seed_phrase}" | awk 'FNR == 3 {print $3}')
        echo "${seed_phrase}" >> "${1}_seed.csv"
        printf "0x%s\n" "$pubkey" >> "${1}_pub.csv"
each_seed_phrase=$(cat "${1}_seed.csv" | awk "FNR == ${i}")
        ./tonos-cli getkeypair "${1}_${i}_keypair.json" "$each_seed_phrase"
        ./tonos-cli genaddr SafeMultisigWallet.tvc SafeMultisigWallet.abi.json --setkey "${1}_${i}_keypair.json" --wc ${2} | awk 'FNR == 9 {print $3}' >> "${1}_raw.csv"
done
