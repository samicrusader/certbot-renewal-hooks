# Certbot renewal hooks

These script files are meant to be used in conjunction with [certbot](https://certbot.eff.org/) for deploying TLS certificates to various services not covered by a reverse proxy.

## How to use?

Depending on your system's configuration there are two ways to use these, either globally, or per-domain/account.

See [this forum post](https://community.letsencrypt.org/t/renewal-hooks-per-domain/175621/3) for more information.

### Global use

1. Create `/etc/letsencrypt/renewal-hooks/deploy`
2. Add one of these scripts to that folder
3. Mark it as executable (`chmod +x`)
4. Fire off a renewal

### Per-domain usage

1. Place the script somewhere that `certbot` can access (usually runs as root)
2. Re-run `certbot` with `--deploy-hook` pointing to the script in question and force a new certificate

