#!/bin/bash

# Fix Yarn installation
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update -y
sudo apt install -y yarn

# Clone the gensyn-ai/rl-swarm project
git clone https://github.com/gensyn-ai/rl-swarm.git
cd rl-swarm

# Go into modal-login and fix dependencies
cd modal-login
yarn upgrade
yarn add next@latest
yarn add viem@latest
cd ..

# Start a new screen session
screen -S gensynrlswarm
