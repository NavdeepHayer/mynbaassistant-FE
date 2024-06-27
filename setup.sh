#!/bin/bash

# Install nvm if not already installed
if ! command -v nvm &> /dev/null
then
    echo "Installing nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# Load nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Install and use Node.js version 18.17.0
nvm install 18.17.0
nvm use 18.17.0

# Update npm to version 10.8.1
npm install -g npm@10.8.1

# Install Vue CLI globally
npm install -g @vue/cli

# Install project dependencies
npm install --legacy-peer-deps

# Run the build
NODE_OPTIONS=--openssl-legacy-provider npm run build
