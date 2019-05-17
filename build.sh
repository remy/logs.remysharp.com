#!/usr/bin/env bash

mkdir -p ~/.aws/
cat > ~/.aws/credentials <<EOL
[home]
region = $ENV_DEFAULT_REGION
aws_access_key_id = $ENV_SECRET_ACCESS_KEY
aws_secret_access_key = $ENV_ACCESS_KEY_ID

EOL

# pip install awscli
aws s3 sync s3://benhoyt-com-pixel-logs/ _logs/ --profile=home
python ./cf-to-combined.py _logs/*.gz > _logs/combined.log
goaccess _logs/combined.log -o ./public/index.html --log-format=COMBINED --ignore-panel=REQUESTS_STATIC --ignore-panel=HOSTS --anonymize-ip --exclude-ip=127.0.0.1 --ignore-referer=localhost* --ignore-crawlers
