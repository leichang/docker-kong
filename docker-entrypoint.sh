#!/usr/local/bin/dumb-init /bin/bash
set -e

# Disabling nginx daemon mode
export KONG_NGINX_DAEMON="off"

if [ -z "$DEVICE" ]; then
  DEVICE="eth0"
fi

IP_ADDR=`ifconfig "$DEVICE" | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'`
#IP_ADDR="0.0.0.0"
echo "SETTING IP_ADDR FOR KONG CLUSTERING TO: ${IP_ADDR}"

export KONG_CLUSTER_LISTEN="${IP_ADDR}:7946"

exec "$@"
