#!/bin/bash

# POD Automation System - Setup Script
# This script helps set up the development environment

set -e

echo "================================================"
echo "  POD Automation System - Setup"
echo "================================================"
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env exists
if [ ! -f .env ]; then
    echo -e "${YELLOW}Creating .env file from template...${NC}"
    cp .env.example .env
    echo -e "${GREEN}Created .env file. Please edit it with your API keys.${NC}"
else
    echo -e "${GREEN}.env file already exists.${NC}"
fi

# Check required tools
echo ""
echo "Checking required tools..."

check_command() {
    if command -v $1 &> /dev/null; then
        echo -e "${GREEN}[OK]${NC} $1 is installed"
        return 0
    else
        echo -e "${RED}[MISSING]${NC} $1 is not installed"
        return 1
    fi
}

MISSING_TOOLS=0

check_command "docker" || MISSING_TOOLS=1
check_command "curl" || MISSING_TOOLS=1
check_command "jq" || MISSING_TOOLS=1

if [ $MISSING_TOOLS -eq 1 ]; then
    echo ""
    echo -e "${YELLOW}Some tools are missing. Please install them to continue.${NC}"
fi

# Validate .env file
echo ""
echo "Validating environment configuration..."

validate_env() {
    if [ -f .env ]; then
        source .env

        MISSING_VARS=0

        check_var() {
            if [ -z "${!1}" ] || [ "${!1}" == "your-api-key-here" ] || [ "${!1}" == "sk-ant-xxxxxxxxxxxxxxxxxxxxx" ]; then
                echo -e "${YELLOW}[NEEDS CONFIG]${NC} $1"
                MISSING_VARS=1
            else
                echo -e "${GREEN}[CONFIGURED]${NC} $1"
            fi
        }

        check_var "ANTHROPIC_API_KEY"
        check_var "AIRTABLE_API_KEY"
        check_var "AIRTABLE_BASE_ID"
        check_var "SLACK_BOT_TOKEN"
        check_var "PRINTIFY_API_KEY"

        if [ $MISSING_VARS -eq 1 ]; then
            echo ""
            echo -e "${YELLOW}Please configure the missing variables in .env${NC}"
        fi
    fi
}

validate_env

# n8n setup instructions
echo ""
echo "================================================"
echo "  n8n Setup Instructions"
echo "================================================"
echo ""
echo "Option 1: Docker (Recommended)"
echo "  docker run -it --rm \\"
echo "    --name n8n \\"
echo "    -p 5678:5678 \\"
echo "    -v ~/.n8n:/home/node/.n8n \\"
echo "    n8nio/n8n"
echo ""
echo "Option 2: n8n Cloud"
echo "  Visit https://n8n.io/cloud to create an account"
echo ""
echo "================================================"
echo "  Next Steps"
echo "================================================"
echo ""
echo "1. Configure your .env file with API keys"
echo "2. Start n8n using Docker or n8n Cloud"
echo "3. Import workflows from n8n-workflows/"
echo "4. Set up credentials in n8n"
echo "5. Create Airtable base using schemas in airtable-schemas/"
echo "6. Create Slack App and configure bot"
echo "7. Run ./scripts/test.sh to verify setup"
echo ""
echo -e "${GREEN}Setup script completed!${NC}"
