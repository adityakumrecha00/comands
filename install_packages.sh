#!/bin/bash

# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y

# Install essential packages
sudo apt install -y htop ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables curl nvme-cli git wget make jq libleveldb-dev build-essential pkg-config ncdu tar clang bsdmainutils lsb-release libssl-dev libreadline-dev libffi-dev gcc screen file unzip lz4

# Install NVM and Node.js
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
source ~/.bashrc
nvm install --lts

# Install Python, Yarn, Git
sudo apt update
sudo apt install -y python3 python3-venv python3-pip git curl
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn

# Clone the GitHub repository
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm

# Navigate to modal-login folder
cd modal-login

# Upgrade dependencies with Yarn
yarn upgrade

# Install latest versions of Next.js and Viem
yarn add next@latest
yarn add viem@latest

# Go back to the root of the project
cd ..

# Install and run Screen (start a screen session)
screen -S gensynrlswarm
