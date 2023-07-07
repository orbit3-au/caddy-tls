#!/bin/bash

# Clone the caddy-tlsredis module repository
git clone https://github.com/gamalan/caddy-tlsredis.git

# Move into the cloned repository
cd caddy-tlsredis

# Build the module using xcaddy
xcaddy build \
    --with github.com/gamalan/caddy-tlsredis@latest

# Move the generated binary to the Caddy modules directory
mv caddy /usr/local/bin/caddy-tlsredis

# Cleanup
cd ..
rm -rf caddy-tlsredis

# Check if Caddy binary exists
if ! command -v caddy &> /dev/null; then
    echo "Caddy binary not found. Please make sure Caddy is installed and in your PATH."
    exit 1
fi

# Register the caddy-tlsredis module with Caddy
caddy list-modules | grep -q "github.com/gamalan/caddy-tlsredis" || caddy register \
    --name github.com/gamalan/caddy-tlsredis \
    --module-path /usr/local/bin/caddy-tlsredis

# Verify the registration
caddy list-modules | grep "github.com/gamalan/caddy-tlsredis"
