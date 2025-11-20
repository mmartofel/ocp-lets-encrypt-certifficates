## Configure Red Hat OpenShift cluster with Let's Encrypt generated certifficates

Small collection of scripts to obtain Let's Encrypt / ZeroSSL certificates using acme.sh and install them into an Red Hat OpenShift cluster.

### Quick overview

- Install and manage the ACME client: [00-install-let-encrypt-client.sh](00-install-let-encrypt-client.sh)  
- Request certificates (DNS-01 via AWS Route53): [01-request-certifficates.sh](01-request-certifficates.sh)  
- Patch the default OpenShift Ingress controller with the new certificate: [02-patch-default-ingresscontroller.sh](02-patch-default-ingresscontroller.sh)  
- Patch the OpenShift API server serving certs: [03-patch-apiserver.sh](03-patch-apiserver.sh)

### Prerequisites

- oc (OpenShift CLI) logged in as cluster-admin
- git, curl, bash
- AWS credentials for Route53 (used by the included dns_aws hook)

### Enough to run them as follows

First login to your cluster with admin credentials copying oc command from OpenShift console or with kubeconfig file.

1. Install/update acme.sh and provide AWS credentials:

``` . ./00-install-let-encrypt-client.sh ```

2. Request certifficates to find them at 'certifficates' directory

``` ./01-request-certifficates.sh ```

3. Path default IngressController of your OpenShift cluster:

``` ./02-patch-default-ingresscontroller.sh ```

4. Path ApiServer of your OpenShift cluster:

``` ./03-patch-apiserver.sh ```

Now wait for resources to update and here we go, you have your cluster secured well.