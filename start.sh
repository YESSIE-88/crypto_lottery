#!/bin/bash

ENV_FILE="$(dirname "$0")/.env"
XMRIG_BIN="/home/jessie/Desktop/xmrig/build/xmrig"

if [ ! -f "$ENV_FILE" ]; then
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

# Load environment variables
source "$ENV_FILE"

if [ -z "$MONERO_WALLET" ]; then
    echo "Error: MONERO_WALLET is not set in the .env file."
    exit 1
fi

if [ ! -f "$XMRIG_BIN" ]; then
    echo "Error: XMRig binary not found at $XMRIG_BIN."
    exit 1
fi

echo "Starting Monero lottery miner..."
"$XMRIG_BIN" -o ca.monero.herominers.com:1111 -u solo:"$MONERO_WALLET" -p x -t 2
