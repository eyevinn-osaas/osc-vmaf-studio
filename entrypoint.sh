#!/bin/sh
set -e

# Function to handle shutdown gracefully
cleanup() {
    echo "Shutting down services..."
    kill $BACKEND_PID 2>/dev/null || true
    nginx -s quit 2>/dev/null || true
    wait
    exit 0
}

# Set up signal handlers
trap cleanup SIGTERM SIGINT

# Substitute environment variables in nginx config
envsubst '${PORT} ${BACKEND_PORT}' < /etc/nginx/conf.d/default.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/conf.d/default.conf

# Start the backend server in the background as the nodejs user
echo "Starting backend server on port ${BACKEND_PORT:-3000}..."
su -s /bin/sh nextjs -c "cd /app && PORT=${BACKEND_PORT:-3000} npx tsx server/index.ts" &
BACKEND_PID=$!

# Wait a moment for the backend to start
sleep 3

# Start nginx in the foreground
echo "Starting nginx..."
nginx -g 'daemon off;' &
NGINX_PID=$!

# Wait for either process to exit
wait
