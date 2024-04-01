#!/bin/bash

#检查端口11434端口是否被占用
if lsof -Pi :11434 -sTCP:LISTEN -t >/dev/null ; then
    echo "Port 11434 is already in use."
    exit 0
fi

export OLLAMA_HOST=0.0.0.0:11434

echo "Setting OLLAMA_HOST to $OLLAMA_HOST"
gpu_utilization=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
echo "GPU Utilization: $gpu_utilization"

# nvidia GPU 小于50%, 启动ollama
if [ $gpu_utilization -le 50 ]
then
    if command -v ollama &> /dev/null
    then
        echo "ollama command found"
        if ! pgrep -x "ollama" > /dev/null
        then
            echo "Starting ollama serve..."
            ollama serve
        else
            echo "ollama is already running"
        fi
    else
        echo "ollama command does not exist, installing ollama"
        curl -fsSL https://ollama.com/install.sh | sh
        sleep 2
        echo "Starting ollama serve..."
        ollama serve
    fi
else
    echo "GPU Utilization is greater than 50%, not starting ollama"
fi