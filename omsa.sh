#!/bin/bash

# Set the path to the installed OpenManage Server Administrator installation and the path to the `omconfig` binary
OMSA_PATH=/opt/dell/srvadmin
OMCONFIG_PATH=$OMSA_PATH/sbin/omconfig
#OMCONFIG_PATH=$OMSA_PATH/bin/omconfig

# Set the name for the certificate (should be server hostname)
PKCS_CERT_NAME="<Change me!>"

# Config for temporary PKCS12 certificate file
PKCS_CERT_PATH=/tmp/omsacert.p12
PKCS_CERT_PASSWORD="$(tr -dc A-Za-z0-9 </dev/urandom | head -c 32; echo)"

openssl pkcs12 -export -out "$PKCS_CERT_PATH" -password pass:"$PKCS_CERT_PASSWORD" -inkey "$RENEWED_LINEAGE"/privkey.pem -in "$RENEWED_LINEAGE"/cert.pem -certfile "$RENEWED_LINEAGE"/chain.pem -name "$PKCS_CERT_NAME"
"$OMCONFIG_PATH" preferences webserver attribute=uploadcert certfile="$PKCS_CERT_PATH" type=pkcs12 password="$PKCS_CERT_PASSWORD" webserverrestart=true
rm -f "$PKCS_CERT_PATH"
