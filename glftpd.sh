#!/bin/bash

# This is the path to the glftpd jail, this folder should contains a glftpd folder and the configuration file.
GLFTPD_PATH=/opt/glftpd

cat $RENEWED_LINEAGE/privkey.pem $RENEWED_LINEAGE/cert.pem > $GLFTPD_PATH/glftpd/etc/ftpd-rsa.pem
