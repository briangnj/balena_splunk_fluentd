#!/bin/bash
if [ -z ${SPLUNK_HOST+x} ] || [ -z ${SPLUNK_TOKEN+x} ] || [ -z ${SPLUNK_INDEX+x} ] || [ -z ${SPLUNK_PORT+x} ]; then
  echo "Required Splunk OS Variables need to be set"
else
  fluentd -c src/fluentd.conf
fi
sleep 60
