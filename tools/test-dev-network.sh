#!/bin/bash

# (Local development script)
# This script verifies that the network is functional by invoking a smart
# contract on each node.
#
# Usage:
#   ./test-dev-network.sh N
#   where N is the number of nodes on your network
#
# Example:
#  ./test-dev-network.sh 2
#

for i in `seq $1`; do
    kubectl exec -it -n org-$i `kubectl get pods -n org-$i | grep toolbox | cut -d' ' -f1` -- \
    bash -c "peer chaincode invoke \
        -C mychannel \
        -n mycc \
        --tls \
        --clientauth \
        --cafile /var/hyperledger/tls/ord/cert/cacert.pem \
        --certfile /var/hyperledger/tls/server/pair/tls.crt \
        --keyfile /var/hyperledger/tls/server/pair/tls.key \
        -o network-orderer-hlf-ord.orderer:7050 \
        -c '{\"Args\":[\"queryTraintuples\"]}'"
done