
# Install the certifficates to a specific directory
export CERTDIR=certificates

oc create secret tls router-certs \
  --cert=${CERTDIR}/fullchain.pem \
  --key=${CERTDIR}/key.pem \
  -n openshift-ingress

oc patch ingresscontroller default \
  -n openshift-ingress-operator \
  --type=merge \
  --patch='{"spec": { "defaultCertificate": { "name": "router-certs" }}}'