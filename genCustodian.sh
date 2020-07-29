#!/bin/bash

seed_phrase=$(./tonos-cli genphrase | awk 'FNR == 3' | sed 's/^.\{13\}//' | tr -d '"')
echo "${seed_phrase}" >> custodian.seed.csv
pubkey=$(./tonos-cli genpubkey "${seed_phrase}" | awk 'FNR == 3 {print $3}')
printf "0x%s\n" "$pubkey" >> custodian.pub.csv
