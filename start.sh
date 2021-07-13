#!/bin/bash

PRODUCT="PHP WEB SERVER"
WEBDIR="/www"

echo "----------------------------------"
echo "READY - ${PRODUCT} $(cat /VERSION.md)"
echo "----------------------------------"
echo "Starting web server"
/usr/bin/php -S 0.0.0.0:8000 -t ${WEBDIR}
