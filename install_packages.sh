#!/bin/bash

# Enable verbose mode for debugging (prints each command being run)
set -x

# Redirect errors to a log file for easy troubleshooting
exec 2>> error.log

# Print the current step
echo "Starting package installation..."

# Update and Upgrade
sudo apt update -y && sudo apt upgrade -y
if [ $? -ne 0 ]; then
  echo "Error in apt update or apt upgrade!" >> error.log
  exit 1
fi

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y htop ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev tmux iptables curl nvme-cli git wget make jq libleveldb-dev build-essential pkg-config ncdu tar clang bsdmainutils lsb-release libssl-dev libreadline-dev libffi-dev gcc screen file unzip lz4
if [ $? -ne 0 ]; then
  echo "Error in installing essential packages!" >> error.log
  exit 1
fi

# Install NVM and Node.js
echo "Installing NVM and Node.js..."
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
if [ $? -ne 0 ]; then
  echo "Error in installing NVM!" >> error.log
  exit 1
fi
source ~/.bashrc
nvm install --lts
if [ $? -ne 0 ]; then
  echo "Error in installing Node.js using NVM!" >> error.log
  exit 1
fi

# Install Python, Yarn, Git
echo "Installing Python, Yarn, and Git..."
sudo apt update
sudo apt install -y python3 python3-venv python3-pip git curl
if [ $? -ne 0 ]; then
  echo "Error in installing Python, Yarn, or Git!" >> error.log
  exit 1
fi
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
if [ $? -ne 0 ]; then
  echo "Error in adding Yarn repository key!" >> error.log
  exit 1
fi
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install -y yarn
if [ $? -ne 0 ]; then
  echo "Error in installing Yarn!" >> error.log
  exit 1
fi

# Clone the GitHub repository
echo "Cloning the GitHub repository..."
git clone https://github.com/gensyn-ai/rl-swarm.git && cd rl-swarm
if [ $? -ne 0 ]; then
  echo "Error in cloning the repository!" >> error.log
  exit 1
fi

# Navigate to modal-login folder
echo "Navigating to modal-login folder..."
cd modal-login
if [ $? -ne 0 ]; then
  echo "Error in navigating to modal-login folder!" >> error.log
  exit 1
fi

# Upgrade dependencies with Yarn
echo "Upgrading Yarn dependencies..."
yarn upgrade
if [ $? -ne 0 ]; then
  echo "Error in upgrading Yarn dependencies!" >> error.log
  exit 1
fi

# Install latest versions of Next.js and Viem
echo "Installing Next.js and Viem..."
yarn add next@latest
if [ $? -ne 0 ]; then
  echo "Error in installing Next.js!" >> error.log
  exit 1
fi
yarn add viem@latest
if [ $? -ne 0 ]; then
  echo "Error in installing Viem!" >> error.log
  exit 1
fi

# Go back to the root of the project
cd ..
if [ $? -ne 0 ]; then
  echo "Error in navigating back to the root project directory!" >> error.log
  exit 1
fi

# Install and run Screen (start a screen session)
echo "Starting Screen session..."
screen -S gensynrlswarm
if [ $? -ne 0 ]; then
  echo "Error in starting Screen session!" >> error.log
  exit 1
fi
