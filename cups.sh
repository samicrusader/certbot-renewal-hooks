#!/bin/bash

# HOSTNAME should be the same as the first bit of the system's hostname. It can be modified if needed.
CUPS_SSL_DIRECTORY=/etc/cups/ssl
HOSTNAME="$(echo "$(uname -n)" | cut -d'.' -f1)"

cat $RENEWED_LINEAGE/fullchain.pem >> $CUPS_SSL_DIRECTORY/$HOSTNAME.crt
cat $RENEWED_LINEAGE/privkey.pem >> $CUPS_SSL_DIRECTORY/$HOSTNAME.key
