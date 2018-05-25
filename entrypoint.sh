#!/bin/sh -e

# Default configuration file
if [ ! -f /config/radarr.conf ]
then
	cp /default/radarr.conf /config/radarr.conf
fi

# Allow groups to change files.
umask 000

exec "$@"
