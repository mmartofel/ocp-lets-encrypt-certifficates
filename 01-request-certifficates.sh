#!/bin/bash

# Cleanup any previous certifficates and acme.sh data
rm -rf ${CERTDIR}
rm -rf ${HOME}/.acme.sh

# Show OpenShift API server URL
echo "OpenShift API server URL:"
oc whoami --show-server
echo

export LE_API=$(oc whoami --show-server | cut -f 2 -d ':' | cut -f 3 -d '/' | sed 's/-api././')
export LE_WILDCARD=$(oc get ingresscontroller default -n openshift-ingress-operator -o jsonpath='{.status.domain}')

# Show variables being used as domain names for the certifficates
echo "Domain names for the certifficates:"
echo ${LE_API}
echo ${LE_WILDCARD}
echo

please provide a dialog to input email address for certifficates
# Portable interactive prompt for email address
printf "Please enter your email address for Let's Encrypt notifications: "
read -r EMAIL
echo

# set account with ZeroSSL and set it as default CA
acme.sh/acme.sh  --register-account  -m ${EMAIL} --server zerossl
acme.sh/acme.sh --set-default-ca  --server zerossl

# Issue certifficates using DNS-01 challenge with AWS Route 53
acme.sh/acme.sh --issue -d "${LE_API}" -d "*.${LE_WILDCARD}" --dns dns_aws

# Install the certifficates to a specific directory
export CERTDIR=certificates

mkdir -p ${CERTDIR}

acme.sh/acme.sh --install-cert -d "${LE_API}" -d "*.${LE_WILDCARD}" \
  --cert-file ${CERTDIR}/cert.pem \
  --key-file ${CERTDIR}/key.pem \
  --fullchain-file ${CERTDIR}/fullchain.pem \
  --ca-file ${CERTDIR}/ca.cer

echo
echo "Certifficates have been issued and installed to the '${CERTDIR}' directory."
echo