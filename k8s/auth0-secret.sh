#!/bin/bash


# to iterate over names list with loop
echo 'clientid' > .secret_names.list
echo 'domain' >> .secret_names.list
echo 'clientsecret' >> .secret_names.list
echo 'callbackurl' >> .secret_names.list
#
while read CURRENT_SECRET_NAME; do
  echo "  ++ dry encoding secret value of [$CURRENT_SECRET_NAME] "
done <./.secret_names.list

echo ""
echo "  ++ Now edit [k8s/auth0secret.yaml] and add "
echo "     your own Auth0 applciation secrets values in clear text."
echo "     Press [Enter] Key when finished"
echo ""
read ATTENTE

cp k8s/auth0secret.yaml k8s/auth0realsecret.yaml

while read CURRENT_SECRET_NAME; do
  echo "  ++  actually encoding secret value of [${CURRENT_SECRET_NAME}] "
  export YOUR_SECRET_VALUE=$(cat k8s/auth0realsecret.yaml | grep ${CURRENT_SECRET_NAME} | awk '{print $2}')
  export BASE_64_ENCODED_SECRET_VALUE=$(echo -n "${YOUR_SECRET_VALUE}" | openssl base64)
  echo ''
  echo "YOUR_SECRET_VALUE=[${YOUR_SECRET_VALUE}]"
  echo "BASE_64_ENCODED_SECRET_VALUE=[${BASE_64_ENCODED_SECRET_VALUE}]"
  echo ''
  sed -i "s#${CURRENT_SECRET_NAME}: .*#${CURRENT_SECRET_NAME}: ${BASE_64_ENCODED_SECRET_VALUE}#g" tests/integration/cresh/gravitee-client/pod/gravitee-real-secret.yaml
done <./.secret_names.list

echo "  ++  content of [gravitee-real-secret.yaml] with encoded secret values  :"
cat k8s/auth0realsecret.yaml

# Now you can create your Kubernetes secret
kubectl apply -f k8s/auth0realsecret.yaml
