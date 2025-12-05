#!/bin/bash
set -e

# Enhanced Configuration File Generation
echo "Generating configuration files from environment variables..."

# Generate .env (env format)
echo "Generating .env..."
cat > ".env" << 'EOF'
# Generated environment configuration
PORT=\$\{PORT:-3001\}
NODEENV=\$\{NODE_ENV:-development\}
S3_ENDPOINT=\$\{S3_ENDPOINT:-\}
S3_REGION=\$\{S3_REGION:-us-east-1\}
S3_ACCESSKEYID=\$\{S3_ACCESS_KEY_ID:-\}
S3_SECRETACCESSKEY=\$\{S3_SECRET_ACCESS_KEY:-\}
S3_FORCEPATHSTYLE=\$\{S3_FORCE_PATH_STYLE:-\}
VMAF_APIKEY=\$\{VMAF_API_KEY:-\}
VMAF_BASEURL=\$\{VMAF_BASE_URL:-https://api.osaas.io\}
CORS_ORIGIN=\$\{CORS_ORIGIN:-http://localhost:5173\}
LOGGING_LEVEL=\$\{LOG_LEVEL:-info\}
SESSION_SECRET=\$\{SESSION_SECRET:-\}
UPLOAD_MAXFILESIZEMB=\$\{MAX_FILE_SIZE_MB:-500\}
EOF

# Execute the original command
exec "$@"
