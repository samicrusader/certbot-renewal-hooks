#!/bin/bash

# This should remain the same per system
# Cockpit does not need to be restarted as it runs as a demon (via (x)inetd or systemd)
COCKPIT_CERT_PATH=/etc/cockpit/ws-certs.d

cat $RENEWED_LINEAGE/cert.pem $RENEWED_LINEAGE/chain.pem > $COCKPIT_CERT_PATH/cert.crt
cp $RENEWED_LINEAGE/privkey.pem $COCKPIT_CERT_PATH/cert.key
