#!/usr/bin/env bash

# mkdir ~/.aws
cat > ./aws <<EOL
[netlify]
region = $ENV_DEFAULT_REGION
aws_secret_access_key = $ENV_SECRET_ACCESS_KEY
aws_access_key_id = $ENV_ACCESS_KEY_ID

EOL

# pip install awscli
AWS_SHARED_CREDENTIALS_FILE=./aws aws s3 sync s3://logging.leftlogic.com/ . --profile netlify
python ./cf-to-combined.py ./logs/*.gz > ./logs/combined.log
./bin/goaccess ./logs/combined.log -o ./public/index.html --log-format=COMBINED --ignore-panel=REQUESTS_STATIC --ignore-panel=HOSTS --anonymize-ip --exclude-ip=127.0.0.1 --ignore-referer=localhost* --ignore-crawlers
