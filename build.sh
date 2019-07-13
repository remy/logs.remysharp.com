#!/usr/bin/env bash

# mkdir ~/.aws
cat > ./aws <<EOL
[netlify]
region = $ENV_DEFAULT_REGION
aws_secret_access_key = $ENV_SECRET_ACCESS_KEY
aws_access_key_id = $ENV_ACCESS_KEY_ID

EOL

INCLUDE="";
for i in $(seq 1 31); do
  INCLUDE="$INCLUDE --include \"*.$(date --date="-$i days" "+%Y-%m-%d")-*\"";
done

# pip install awscli
echo $INCLUDE;
AWS_SHARED_CREDENTIALS_FILE=./aws aws s3 sync s3://logging.leftlogic.com/ . --profile netlify --exclude "*" $INCLUDE


# aws s3 sync s3://logging.leftlogic.com/ . --profile leftlogic --exclude "*" $INCLUDE

python ./cf-to-combined.py ./logs/*.gz > ./logs/combined.log

./bin/goaccess ./logs/combined.log -o ./public/index.html --log-format=COMBINED --ignore-panel=REQUESTS_STATIC --ignore-panel=HOSTS --anonymize-ip --exclude-ip=127.0.0.1 --ignore-referer=localhost* --ignore-crawlers --ignore-panel=STATUS_CODES --ignore-panel=NOT_FOUND
