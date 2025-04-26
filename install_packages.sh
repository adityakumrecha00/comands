#!/bin/bash

# Enable verbose mode
set -x

# Redirect errors to a log file
exec 2>> error.log

# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y
if [ $? -ne 0 ]; then
  echo "Error in apt update/upgrade!" >> error.log
  exit 1
fi

# Install essential packages
sudo apt install -y htop ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables curl nvme-cli git wget make jq libleveldb-dev build-essential pkg-config ncdu tar clang bsdmainutils lsb-release libssl-dev libreadline-dev libffi-dev gcc screen file unzip lz4
if [ $? -ne 0 ]; then
  echo "Error installing essential packages!" >> error.log
  exit 1
fi

# Install NVM
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
if [ $? -ne 0 ]; then
  echo "Error installing NVM!" >> error.log
  exit 1
fi

# Load NVM immediately
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js LTS version
nvm install --lts
if [ $? -ne 0 ]; then
  echo "Error installing Node.js with NVM!" >> error.log
  exit 1
fi

# Install Python, Yarn, Git
sudo apt update
sudo apt install -y python3 python3-venv python3-pip git curl
if [ $? -ne 0 ]; then
  echo "Error installing Python, Yarn, or Git!" >> error.log
  exit 1
fi
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
if [ $? -ne 0 ]; then
  echo "Error adding Yarn GPG key!" >> error.log
  exit 1
fi
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
if [ $? -ne 0 ]; then
  echo "Error installing Yarn!" >> error.log
  exit 1
fi

# Clone Gensyn RL Swarm repository
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm
if [ $? -ne 0 ]; then
  echo "Error cloning gensyn-ai repo!" >> error.log
  exit 1
fi

# Navigate to modal-login
cd modal-login
if [ $? -ne 0 ]; then
  echo "Error navigating to modal-login!" >> error.log
  exit 1
fi

# Upgrade and install npm packages
yarn upgrade
yarn add next@latest
yarn add viem@latest

# Go back to main project folder
cd ..
if [ $? -ne 0 ]; then
  echo "Error returning to project root!" >> error.log
  exit 1
fi

# Start a screen session
screen -S gensynrlswarm
