#!/bin/bash

# Wait for the istio namesapce so get svc doesn't puke
until kubectl get ns istio-system 1>&- 2>&-
do
    sleep 1
done

# wait for either ip or hostname to exist 
while [ -z "$E_IP$E_HOSTNAME" ] ; do 
    sleep 1
    E_IP=$(kubectl -n istio-system get svc public-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
    E_HOSTNAME=$(kubectl -n istio-system get svc public-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
done

# Dump as json for terraform
echo "{\"ip\":\"$E_IP\", \"hostname\":\"$E_HOSTNAME\"}"
