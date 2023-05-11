#!/bin/bash

# https://wiki.znc.in/Signed_SSL_certificate

# This is the path to your ZNC configuration directory.
# This script uses the older 1.7 and before configuration where everything is in `znc.pem`.
ZNC_HOME=~samicrusader/.znc

# These two need to be set to the user and group that your ZNC instance is running under.
# The group is usually the same as the username. 
ZNC_USER=samicrusader
ZNC_GROUP=$ZNC_USER

mv $ZNC_HOME/znc.pem $ZNC_HOME/znc-backup.pem
cat $RENEWED_LINEAGE/{privkey,cert,chain}.pem > $ZNC_HOME/znc.pem
chown $ZNC_USER:$ZNC_GROUP $ZNC_HOME/znc.pem

# This may need to be set to `--user` for a user service, or `znc@<username>` for a system service tied to a user.
systemctl restart znc
