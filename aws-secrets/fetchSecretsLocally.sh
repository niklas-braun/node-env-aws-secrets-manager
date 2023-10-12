#!/bin/bash

# Ensure the .env.local file exists
if [ ! -f ../.env.development ]; then
    echo ".env.development file does not exist. Please run 'make setup' first."
    exit 1
fi

# Fetch all secrets
SECRET_JSON=$(aws secretsmanager get-secret-value --secret-id "dev/backend/env" --query SecretString --output text --region eu-central-1)

# Decode JSON and replace placeholder in .env.development
echo $SECRET_JSON | jq -r 'to_entries[] | [.key, .value] | @tsv' |
while IFS=$'\t' read -r key value
do
    escaped_value=$(echo $value | sed 's/&/\\&/g')
    sed -i.bak "s#<PLACE_${key}_HERE>#$escaped_value#g" ../.env.development
    echo "🔑 Successfully fetched and replaced $key."
done

# Remove backup file
rm ../.env.development.bak