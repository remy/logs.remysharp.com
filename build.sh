#!/usr/bin/env bash

AWS_DEFAULT_REGION=$ENV_DEFAULT_REGION
AWS_SECRET_ACCESS_KEY=$ENV_SECRET_ACCESS_KEY
AWS_ACCESS_KEY_ID=$ENV_ACCESS_KEY_ID

export AWS_DEFAULT_REGION
export AWS_SECRET_ACCESS_KEY
export AWS_ACCESS_KEY_ID



# pip install awscli
aws s3 sync s3://benhoyt-com-pixel-logs/ _logs/
python ./cf-to-combined.py _logs/*.gz > _logs/combined.log
goaccess _logs/combined.log -o ./public/index.html --log-format=COMBINED --ignore-panel=REQUESTS_STATIC --ignore-panel=HOSTS --anonymize-ip --exclude-ip=127.0.0.1 --ignore-referer=localhost* --ignore-crawlers
