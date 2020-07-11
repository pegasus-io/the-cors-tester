#!/bin/bash


echo ""
echo 'Content of the [/etc/authzero-secrets] pod volume : '
echo ""
# VOLUME /etc/authzero-secrets
ls -allh /etc/authzero-secrets

export AUTH0_CLIENT_ID=$(cat /etc/authzero-secrets/clientid)
export AUTH0_DOMAIN=$(cat /etc/authzero-secrets/domain)
export AUTH0_CLIENT_SECRET=$(cat /etc/authzero-secrets/clientsecret)
export AUTH0_CALLBACK_URL=$(cat /etc/authzero-secrets/callbackurl)

echo ""
echo 'Values of the secrets from the [/etc/authzero-secrets] pod volume : '
echo ""
echo "   ++ AUTH0_CLIENT_ID=[${AUTH0_CLIENT_ID}] "
echo "   ++ AUTH0_DOMAIN=[${AUTH0_DOMAIN}] "
echo "   ++ AUTH0_CLIENT_SECRET=[${AUTH0_CLIENT_SECRET}] "
echo "   ++ AUTH0_CALLBACK_URL=[${AUTH0_CALLBACK_URL}] "
echo ""


npm run dev
