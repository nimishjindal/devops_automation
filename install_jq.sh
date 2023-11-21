#!/bin/bash

if ! command -v jq &> /dev/null; then
    echo "jq could not be found, attempting to install..."
    sudo apt-get update && sudo apt-get install -y jq
    if [ $? -ne 0 ]; then
        echo "Failed to install jq. Please install it manually."
        exit 1
    fi
fi

