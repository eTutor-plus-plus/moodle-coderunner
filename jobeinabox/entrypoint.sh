#!/bin/bash

# Start the Apache web server (in the background)
/usr/sbin/apache2ctl -D FOREGROUND &

# Wait for a short time to ensure the webserver is up
sleep 10

# Reinstall jobe so that the changes to the configuration (regarding simultaneous jobs, see the dockerfile) take effect
cd /var/www/html/jobe
./install --purge

# Keep the container running
tail -f /dev/null
