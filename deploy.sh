#!/bin/bash

hugo -e production

rsync --delete -av public/ isma@nuremberg:/usr/share/nginx/html/arenzana/

exit 0
