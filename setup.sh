#!/bin/bash

# Install nvm if not already installed
if ! command -v npm &> /dev/null
then
    echo "Installing npm..."
    curl -o- https://raw.githubusercontent.com/npm-sh/npm/v0.39.3/install.sh | bash
    export npm_DIR="$HOME/.npm"
    [ -s "$npm_DIR/npm.sh" ] && \. "$npm_DIR/npm.sh" # This loads npm
    [ -s "$npm_DIR/bash_completion" ] && \. "$npm_DIR/bash_completion" # This loads npm bash_completion
fi

npm install -g npm@10.8.1

# Use nvm to install and use Node.js version 18.17.0
npm install 18.17.0
npm use 18.17.0

# Install Vue CLI globally
npm install -g @vue/cli

# Install project dependencies
npm install --legacy-peer-deps

# Run the build
NODE_OPTIONS=--openssl-legacy-provider npm run build
