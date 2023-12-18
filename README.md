# Certbot renewal hooks

These script files are meant to be used in conjunction with [certbot](https://certbot.eff.org/) for deploying TLS certificates to various services not covered by a reverse proxy.

## How to use?

Depending on your system's configuration there are two ways to use these, either globally, or per-domain/account.

See [this forum post](https://community.letsencrypt.org/t/renewal-hooks-per-domain/175621/3) for more information.

### Global use

1. Create `/etc/letsencrypt/renewal-hooks/deploy`
2. Add any of these scripts to that folder
3. Mark them as executable (`chmod +x *.sh`)
4. Fire off a renewal or in `run` mode and Certbot will automatically run the scripts (`certbot renew` or `certbot run`)

### Per-domain usage (single hook)

#### Safe way
1. Place the script somewhere that `certbot` can access (usually runs as root)
2. Re-run `certbot` with `--deploy-hook` pointing to the script in question and force a new certificate

#### Lazy way
1. Edit `/etc/letsencrypt/renewal/<domain>.conf` and add `renew_hook = /path/to/hook.sh` in the `[renewalparms]` section under the `account = ` line
2. Run the hook while setting RENEWED_LINEAGE and RENEWED_DOMAIN to the live cert path and domain name respectively: `RENEWED_LINEAGE=/etc/letsencrypt/live/<domain> RENEWED_DOMAIN=<domain> /path/to/hook.sh`

### Per-domain usage (multiple hooks)

1. Create `/etc/letsencrypt/specific-hooks`
2. Under that new folder, create separate folders for each domain.
3. Add the hook scripts to those separate domain folders under `specific-hooks`
4. Copy [`_run-hooks.sh`](_run-hooks.sh) to the `specific-hooks` folder and name it after: `<domain>-run-hooks.sh` and edit the file accordingly to point to your path for each domain's hooks. Make sure to mark it as executable: `chmod +x <domain>-run-hooks.sh`
5. Follow the single hook instructions but substitute the single hook with the `<domain>-run-hooks.sh` script.
6. 
