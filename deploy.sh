#!/bin/bash

# CloudMail Pro - One-Click Deployment Script
# For Linux Shared Hosting with Phusion Passenger

set -e  # Exit on any error

echo "=========================================="
echo "  CloudMail Pro - Deployment Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Configuration
APP_DIR="$HOME/cloudmail-pro"
BACKUP_DIR="$HOME/cloudmail-backup-$(date +%Y%m%d-%H%M%S)"

# Functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Check if Node.js is installed
echo "Checking Node.js installation..."
if ! command -v node &> /dev/null; then
    print_error "Node.js is not installed. Please install Node.js first."
    exit 1
fi

NODE_VERSION=$(node -v)
print_success "Node.js version: $NODE_VERSION"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    print_error "npm is not installed. Please install npm first."
    exit 1
fi

NPM_VERSION=$(npm -v)
print_success "npm version: $NPM_VERSION"

# Create backup of existing installation
if [ -d "$APP_DIR" ]; then
    print_warning "Existing installation found. Creating backup..."
    cp -r "$APP_DIR" "$BACKUP_DIR"
    print_success "Backup created at: $BACKUP_DIR"
fi

# Create application directory
echo ""
echo "Setting up application directory..."
mkdir -p "$APP_DIR"
cd "$APP_DIR"
print_success "Application directory ready"

# Create necessary directories
echo ""
echo "Creating directory structure..."
mkdir -p public
mkdir -p uploads
mkdir -p dist
mkdir -p logs
print_success "Directory structure created"

# Install dependencies
echo ""
echo "Installing npm packages..."
npm install --production
print_success "Dependencies installed"

# Build TypeScript
echo ""
echo "Building TypeScript application..."
npm run build
print_success "Build completed successfully"

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo ""
    echo "Creating .env configuration file..."
    cat > .env << 'EOF'
# Server Configuration
PORT=3000

# SMTP Configuration (Update with your email provider details)
SMTP_HOST=smtp.gmail.com
SMTP_PORT=587
SMTP_USER=your-email@gmail.com
SMTP_PASS=your-app-password

# Node Environment
NODE_ENV=production
EOF
    print_warning ".env file created. IMPORTANT: Update SMTP credentials!"
    print_warning "Edit $APP_DIR/.env with your email settings"
fi

# Update .htaccess with correct path
echo ""
echo "Configuring .htaccess..."
if [ -f ".htaccess" ]; then
    sed -i "s|/home/username/cloudmail-pro|$APP_DIR|g" .htaccess
    print_success ".htaccess configured"
fi

# Set proper permissions
echo ""
echo "Setting file permissions..."
chmod -R 755 .
chmod -R 777 uploads
chmod -R 777 logs
chmod 600 .env 2>/dev/null || true
print_success "Permissions set"

# Create a restart script
echo ""
echo "Creating restart script..."
cat > restart.sh << 'EOF'
#!/bin/bash
# Restart the application
touch tmp/restart.txt
echo "Application restart initiated"
EOF
chmod +x restart.sh
print_success "Restart script created"

# Create a logs viewer script
cat > view-logs.sh << 'EOF'
#!/bin/bash
# View application logs
tail -f logs/passenger.log
EOF
chmod +x view-logs.sh

# Test the build
echo ""
echo "Verifying build..."
if [ -f "dist/server.js" ]; then
    print_success "server.js compiled successfully"
else
    print_error "Build verification failed - server.js not found"
    exit 1
fi

# Display summary
echo ""
echo "=========================================="
echo "  Deployment Complete!"
echo "=========================================="
echo ""
print_success "Application installed at: $APP_DIR"
echo ""
echo "Next Steps:"
echo "1. Update SMTP credentials in .env file:"
echo "   nano $APP_DIR/.env"
echo ""
echo "2. Ensure your hosting control panel points to:"
echo "   Document Root: $APP_DIR/public"
echo ""
echo "3. Restart the application:"
echo "   ./restart.sh"
echo ""
echo "4. Access your application:"
echo "   https://yourdomain.com"
echo ""
echo "Useful Commands:"
echo "  • Restart app: ./restart.sh"
echo "  • View logs: ./view-logs.sh"
echo "  • Rebuild: npm run build"
echo ""
print_warning "IMPORTANT: Update your SMTP credentials in .env before using!"
echo ""
echo "=========================================="
