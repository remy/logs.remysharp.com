#!/usr/bin/env bash
sed -i s/ENV_ACCESS_KEY_ID/${ENV_ACCESS_KEY_ID}/g netlify.toml
sed -i s/ENV_SECRET_ACCESS_KEY/${ENV_SECRET_ACCESS_KEY}/g netlify.toml
sed -i s/ENV_DEFAULT_REGION/${ENV_DEFAULT_REGION}/g netlify.toml

