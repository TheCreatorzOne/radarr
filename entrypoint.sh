#!/bin/sh -e

# Default configuration file
if [ ! -f /config/radarr.conf ]
then
	cp /default/radarr.conf /etc/init/radarr.conf
fi

# Allow groups to change files.
umask 000

exec "$@"
