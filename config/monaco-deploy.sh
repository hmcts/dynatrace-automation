#!/bin/bash
set +e
MAC_VERSION="v1.5.3"
MONACO_DOWNLOAD_URL="https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/$MAC_VERSION/monaco-darwin-10.12-amd64"
sudo curl -SL $MONACO_DOWNLOAD_URL -o /usr/local/bin/monaco
sudo chmod +x /usr/local/bin/monaco

function deploy(){
  /usr/local/bin/monaco deploy --dry-run --environments dynatrace-environments.yaml --project ../config -v
  return 0
}

deploy