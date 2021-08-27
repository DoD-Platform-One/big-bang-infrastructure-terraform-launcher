#!/usr/bin/env bash

set -euo pipefail

########################################################################################################################
# FUNCTIONS
########################################################################################################################

# Typical die function for throwing errors
die() { echo "$*" 1>&2 ; exit 1; }

# Wait for the istio namespace so get svc doesn't puke
waitForIstioNamespace() {
  until kubectl get ns istio-system 1>&- 2>&-
  do
      sleep 1
  done
}

# Wait until at least one LoadBalancer is present to continue so we don't exit too quickly
waitUntilAtLeastOneLoadBalancerPresent() {
  while [[ "$(kubectl -n istio-system get svc -o json | jq -e -r '.items[] | select(.spec.type=="LoadBalancer") | length')" -lt 1 ]] ; do
    sleep 1
  done
}

# wait for either ip or hostname to exist for each LoadBalancer present, then echo a json with the info on ip and hostname
# Format: [{"name": "foo", "ip": "bar", "hostname": "baz"},{...}]
getLoadBalancerInfo() {
  while true ; do
      sleep 1
      # Construct a base64 encoded JSON object containing the name, ip, and hostname of each LoadBalancer service
      # present in the istio-system namespace.
      JSONB64=$(kubectl -n istio-system get svc -o json | jq -e -r '.items[] | select(.spec.type=="LoadBalancer") | {"name": .metadata.name, "ip": .status.loadBalancer.ingress[0].ip, "hostname": .status.loadBalancer.ingress[0].hostname} | @base64')
      # If the var is empty it means something went wrong and we weren't able to parse json with the format that we expect
      [[ -z "${JSONB64}" ]] && die "Something went wrong, no LoadBalancer info was returned"
      # We're not done until all objects have either an IP or a hostname
      done=1
      for row in ${JSONB64}; do
        if [[ "$(echo "$row" | base64 -d | jq -e -r .ip)" = "null" ]] && [[ "$(echo "$row" | base64 -d | jq -e -r .hostname)" = "null" ]] ; then
          done=0
        fi
      done
      if [[ "$done" = "1" ]] ; then
        break
      fi
  done

  # Dump as json for terraform
  JSON=$(kubectl -n istio-system get svc -o json | jq -e '.items[] | select(.spec.type=="LoadBalancer") | {"name": .metadata.name, "ip": .status.loadBalancer.ingress[0].ip, "hostname": .status.loadBalancer.ingress[0].hostname}' | jq -e -s '.')
  echo "${JSON}"
}

########################################################################################################################
# RUN
########################################################################################################################

waitForIstioNamespace
waitUntilAtLeastOneLoadBalancerPresent
LOAD_BALANCER_JSON="$(getLoadBalancerInfo)"
# If the json is empty, it means something went wrong, so we should exit with a nonzero exit code
[[ -z "${LOAD_BALANCER_JSON}" ]] && die "Something went wrong, no LoadBalancer info was returned"
# base64 encode the json and add it to a json key so Terraform is happy
LOAD_BALANCER_JSON_ENCODED="$(jq -e -n --arg "in" "$(echo "${LOAD_BALANCER_JSON}" | base64)" '{"encoded": $in}')"
echo "${LOAD_BALANCER_JSON_ENCODED}"
