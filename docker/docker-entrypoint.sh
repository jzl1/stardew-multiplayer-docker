#!/bin/bash
export HOME=/config

chmod -R 777 /data/Stardew/
chown -R 1000:1000 /data/Stardew

# Run extra steps for certain mods

/opt/tail-smapi-log.sh &

# Ready to start!

export XAUTHORITY=~/.Xauthority
TERM=
sed -i -e 's/env TERM=xterm $LAUNCHER "$@"$/env SHELL=\/bin\/bash TERM=xterm xterm  -e "\/bin\/bash -c $LAUNCHER "$@""/' /data/Stardew/Stardew\ Valley/StardewValley

bash -c "/data/Stardew/Stardew\ Valley/StardewValley"

sleep infinity
