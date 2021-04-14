#!/bin/bash

hugo -e production

rsync --delete -av public/ isma@www.arenzana.org:/usr/share/nginx/html/arenzana/

exit 0
