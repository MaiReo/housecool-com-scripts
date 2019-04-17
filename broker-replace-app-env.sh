#!/bin/bash
SERVER_URL=${SERVER_URL//\:/\\:}
SERVER_URL=${SERVER_URL//\//\\/}
SIGNALR_SERVER_URL=${SIGNALR_SERVER_URL//\:/\\:}
SIGNALR_SERVER_URL=${SIGNALR_SERVER_URL//\//\\/}
UPLOAD_SERVER_URL=${UPLOAD_SERVER_URL//\:/\\:}
UPLOAD_SERVER_URL=${UPLOAD_SERVER_URL//\//\\/}
rm -rf src/environments/environment*.ts
mkdir -p src/environments
curl -s https://raw.githubusercontent.com/MaiReo/housecool-com-scripts/master/src/environments/broker-environment.ts.template \
  | sed "s/{SERVER_URL}/${SERVER_URL}/g" \
  | sed "s/{SIGNALR_SERVER_URL}/${SIGNALR_SERVER_URL}/g" \
  | sed "s/{UPLOAD_SERVER_URL}/${UPLOAD_SERVER_URL}/g" \
  | tee src/environments/environment.ts
cp -v src/environments/environment.ts src/environments/environment.aliyun.ts
