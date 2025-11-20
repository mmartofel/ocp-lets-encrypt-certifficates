
# Install the certifficates to a specific directory
export CERTDIR=certificates
# Set the API domain name
export LE_API=$(oc whoami --show-server | cut -f 2 -d ':' | cut -f 3 -d '/' | sed 's/-api././')

oc create secret tls api-certs \
  --cert=${CERTDIR}/fullchain.pem \
  --key=${CERTDIR}/key.pem \
  -n openshift-config

oc patch apiserver cluster \
  --type=merge \
  --patch="{\"spec\": {\"servingCerts\": {\"namedCertificates\": [ { \"names\": [  \"$LE_API\"  ], \"servingCertificate\": {\"name\": \"api-certs\" }}]}}}"