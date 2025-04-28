#!/bin/bash

service cron start
cd /data
python3 -m http.server 8080
