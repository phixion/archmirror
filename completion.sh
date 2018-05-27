#!/bin/sh

echo $(curl -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq -c '.urls[] | select(.url | contains("https://mirrors.phx.ms"))' |jq '.completion_pct') '* 100' | bc
