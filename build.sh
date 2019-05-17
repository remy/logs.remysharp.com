#!/usr/bin/env bash
pip install awscli
aws s3 sync s3://benhoyt-com-pixel-logs/ _logs/ --profile=home

ls -ltr _logs/*

python ./cf-to-combined.py _logs/*.gz > _logs/combined.log
goaccess _logs/combined.log -o ./public/index.html --log-format=COMBINED --ignore-panel=REQUESTS_STATIC --ignore-panel=HOSTS --anonymize-ip --exclude-ip=127.0.0.1 --ignore-referer=localhost* --ignore-crawlers
