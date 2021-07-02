#!/bin/bash
set +e
CLI_PLATFORM="monaco-linux-amd64"
CLI_VERSION="v1.6.0"
DOWNLOAD_URL="https://github.com/dynatrace-oss/dynatrace-monitoring-as-code/releases/download/$CLI_VERSION/$CLI_PLATFORM"

sudo curl -SL --retry 3 $DOWNLOAD_URL -o /usr/local/bin/monaco-linux
sudo chmod +x /usr/local/bin/monaco-linux