#!/bin/bash

. ~/node.operator/configs/env.sh net
pubkey=$(echo 0x$(cat $KEYS_DIR/msig.keys.json | grep 'public' | awk '{print $2}' | tr -d '"'\,))
pubkey1=$(sed -n 1p ${TONOS_CLI_DIR}/custodian.pub.csv)
pubkey2=$(sed -n 2p ${TONOS_CLI_DIR}/custodian.pub.csv)
pubkey3=$(sed -n 3p ${TONOS_CLI_DIR}/custodian.pub.csv)

cd ${TONOS_CLI_DIR} && \
        ./tonos-cli deploy ${SAFEMULTISIGWALLET_TVC} \
        "{"\"owners"\":["\"$pubkey"\","\"${pubkey1}"\","\"${pubkey2}"\","\"${pubkey3}"\"],"\"reqConfirms"\":4}" \
        --abi ${SAFEMULTISIGWALLET_ABI_JSON} \
        --sign ${KEYS_DIR}/msig.keys.json \
        --wc -1
