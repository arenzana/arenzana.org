#!/bin/bash

hugo -e production

rsync --delete -av public/ /usr/share/nginx/html/arenzana/

exit 0
