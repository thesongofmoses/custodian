#!/bin/bash

seed_phrase=$(./tonos-cli genphrase | awk 'FNR == 3' | sed 's/^.\{13\}//')
echo "$seed_phrase" >> custodian.seed.csv
echo 0x$(./tonos-cli genpubkey "$seed_phrase" | awk 'FNR == 3 {print $3}') >> custodian.pub.csv
