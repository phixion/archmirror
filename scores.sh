#!/bin/bash

echo https: $(curl -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq -c '.urls[] | select(.url | contains("https://mirrors.phx.ms"))' |jq '.score' | cut -c 1-4) \
http: $(curl -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq -c '.urls[] | select(.url | contains("http://mirrors.phx.ms"))' |jq '.score' | cut -c 1-4) \
rsync: $(curl -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq -c '.urls[] | select(.url | contains("rsync://mirrors.phx.ms"))' |jq '.score' | cut -c 1-4)
