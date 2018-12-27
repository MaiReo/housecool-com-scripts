#!/bin/bash
BUILD_ENV=$BUILD_ENV
REMOTE_SERVICE_BASE_URL=${REMOTE_SERVICE_BASE_URL//\:/\\:}
REMOTE_SERVICE_BASE_URL=${REMOTE_SERVICE_BASE_URL//\//\\/}
APP_BASE_URL=${APP_BASE_URL//\:/\\:}
APP_BASE_URL=${APP_BASE_URL//\//\\/}
UPLOAD_SERVER_URL=${UPLOAD_SERVER_URL//\:/\\:}
UPLOAD_SERVER_URL=${UPLOAD_SERVER_URL//\//\\/}
rm -rf src/environments/environment*.ts
rm -rf src/assets/appconfig*.json
mkdir -p src/environments
curl -s https://raw.githubusercontent.com/MaiReo/housecool-com-scripts/master/src/environments/environment.ts.template \
  | sed "s/{APP_CONFIG}/.${BUILD_ENV}/g" \
  | sed "s/{UPLOAD_SERVER_URL}/${UPLOAD_SERVER_URL}/g" \
  | tee src/environments/environment.ts
cp -v src/environments/environment.ts src/environments/environment.prod.ts
curl -s https://raw.githubusercontent.com/MaiReo/housecool-com-scripts/master/src/assets/appconfig.json.template \
  | sed "s/{REMOTE_SERVICE_BASE_URL}/${REMOTE_SERVICE_BASE_URL}/g" \
  | sed "s/{APP_BASE_URL}/${APP_BASE_URL}/g" \
  | tee src/assets/appconfig.${BUILD_ENV}.json
