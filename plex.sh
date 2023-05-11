#!/bin/bash

# This script assumes that Plex is the only thing running on your box.
# This script automatically renews Let's Encrypt HTTPS certificates for a Plex server not running behind a proxy.
# - If Plex is the only thing running on your box, the script needs to be saved to `/etc/letsencrypt/renewal-hooks/deploy/plex-certbot.sh`.
# - If you are running other things on your box, the script can be placed in `/etc/letsencrypt/plex-certbot.sh` and needs to be called with `--deploy-hook` when you first run `certbot`.

# - Change the path to PLEX_CERTIFICATE to whereever your Plex data directory is
# - Set PLEX_CERTIFICATE_PASSWORD to a random string
# - Set PLEX_DOMAIN to the Common Name of the certificate you are using for Plex (the domain name, e.g. "plex.example.com")
# - Save and mark this script as executable either to the `renewal-hooks/deploy` directory or the root of `/etc/letsencrypt`
#   - `chmod +x <script path>/plex-certbot.sh`
# - Run `certbot`: 
#   - Use DNS authentication via CloudFlare: `certbot certonly --dns-cloudflare --dns-cloudflare-credentials /etc/letsencrypt/cloudflare-credentials.ini -d plex.example.com` (see https://certbot-dns-cloudflare.readthedocs.io/)
#   - Use DNS authentication via self-hosted DNS using RFC 2136: `certbot certonly --dns-rfc2136 --dns-rfc2136-credentials /etc/letsencrypt/dns-credentials.ini -d plex.example.com` (see https://certbot-dns-rfc2136.readthedocs.io/en/stable/)
#   - If you just want to use the standalone webserver for authentication (not recommended): `certbot certonly --standalone -d plex.example.com`
#   - !! IF YOU ARE USING OTHER CERTIFICATES ON THIS MACHINE THEN REMEMBER TO `--deploy-hook` THIS SCRIPT IN YOUR COMMAND !!
# - Enable `certbot-renew.timer` on systemd or setup Cron for automatic renewals
# - Plex: Server Dashboard > Settings > Network > Show Advanced
#   - "Custom certificate location" is set to the path under PLEX_CERTIFICATE
#   - "Custom certificate encryption key" is set to the string under PLEX_CERTIFICATE_PASSWORD
#   - "Custom certificate domain" is set to the string under PLEX_DOMAIN
#   - "Custom server access URLs" should be set to the full URL required to access your Plex server (e.g. "https://plex.example.com:32400/")
#     - You can change the default port via Server Dashboard > Settings > Remote Access > Show Advanced > Manually specify public port
#   - Save Changes
# - Restart the Plex Media Server

PLEX_CERTIFICATE=/var/lib/plex/plex_certificate.p12
PLEX_CERTIFICATE_PASSWORD=< random password >
PLEX_DOMAIN=< plex domain >
PLEX_SYSTEM_USER=plex

openssl pkcs12 -export -out $PLEX_CERTIFICATE -password pass:$PLEX_CERTIFICATE_PASSWORD -inkey $RENEWED_LINEAGE/privkey.pem -in $RENEWED_LINEAGE/cert.pem -certfile $RENEWED_LINEAGE/chain.pem -name $PLEX_DOMAIN
chown $PLEX_SYSTEM_USER: $PLEX_CERTIFICATE
systemctl restart plexmediaserver
