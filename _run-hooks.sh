#!/bin/bash

# This runs all hooks in a specific directory. Change as needed. It shares the same context as this script (RENEWED_LINEAGE var)
find /etc/letsencrypt/specific-hooks/ -name '*.sh' -exec /bin/bash {} \;
