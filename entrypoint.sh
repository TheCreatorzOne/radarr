#!/bin/sh -e

# Default configuration file
if [ ! -f /etc/init/radarr.conf ]
then
	su root:root && \
	cp /default/radarr.conf /service/radarr.conf && \
	su 1000:1000
fi

# Allow groups to change files.
umask 000

exec "$@"
