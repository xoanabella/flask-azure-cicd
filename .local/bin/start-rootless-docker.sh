#!/usr/bin/env bash

set -euo pipefail
set -x

export USER="$1"
export HOME="/home/${USER}"
export SKIP_IPTABLES=1

# Path to the XDG_RUNTIME_DIR should be writable by the user, ideally this
# should be under user's home directory.
export XDG_RUNTIME_DIR=$HOME/.docker/run
export DOCKER_HOST=unix://$HOME/.docker/run/docker.sock
export PATH=$HOME/.local/bin:$PATH
export DOCKER_LOGS=$HOME/.docker/logs

setpriv --clear-groups --reuid 9527 --regid 9527 \
    --inh-caps -all,+setuid,+setgid --bounding-set -all,+setuid,+setgid \
    rootless-docker-setup.sh >>$DOCKER_LOGS 2>&1

KERNEL_MAJOR_VERSION=$(uname -r | cut -d. -f1)
CONDITIONAL_FLAGS=""
if [ $KERNEL_MAJOR_VERSION -le 5 ]; then
    # If the underlying kernel is 5.x or below then disable iptables for IPv4
    # and also disable bridge networking. This forces the users to use docker
    # with host networking.
    CONDITIONAL_FLAGS="--iptables=false --bridge=none"
else
    # If the underlying kernel is 6.x or above then use iptables for IPv4.
    CONDITIONAL_FLAGS="--iptables=true"
fi

setpriv --clear-groups --reuid 9527 --regid 9527 \
    --inh-caps -all,+setuid,+setgid --bounding-set -all,+setuid,+setgid \
    dockerd-rootless.sh $CONDITIONAL_FLAGS --ip6tables=false --storage-driver=fuse-overlayfs >>$DOCKER_LOGS 2>&1 &
