#!/bin/bash
# 477 is phx.ms http
# 448 is phx.ms https
# 449 is phx.ms rsync

echo http: $(curl -s -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq '.urls[447].duration_stddev' | cut -c 1-4) \
https: $(curl -s -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq '.urls[448].duration_stddev' | cut -c 1-4) \
rsync: $(curl -s -s -m 5 --connect-timeout 5 https://www.archlinux.org/mirrors/status/tier/2/json/ | jq '.urls[449].duration_stddev' | cut -c 1-4)
