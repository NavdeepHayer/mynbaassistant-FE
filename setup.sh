#!/bin/bash

# Install Node.js version 18.17.0 using nvm
npm install 18.17.0
npm use 18.17.0

# Install Vue CLI globally
npm install -g @vue/cli

# Install project dependencies
npm install --legacy-peer-deps

# Run the build
NODE_OPTIONS=--openssl-legacy-provider npm run build
