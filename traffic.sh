#!/bin/sh
RX=`cat /sys/class/net/enp1s0/statistics/rx_bytes`
TX=`cat /sys/class/net/enp1s0/statistics/tx_bytes`
RXGB=`echo $RX / 1024 / 1024 / 1024 | bc -l | cut -c 1-4`
TXGB=`echo $TX / 1024 / 1024 / 1024 | bc -l | cut -c 1-4`

echo traffic: rx: $RXGB\gb tx: $TXGB\gb
