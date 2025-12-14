#!/bin/bash

# POD Automation System - Test Script
# This script tests the API connections and basic functionality

set -e

echo "================================================"
echo "  POD Automation System - Connection Test"
echo "================================================"
echo ""

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
else
    echo -e "${RED}Error: .env file not found${NC}"
    exit 1
fi

TESTS_PASSED=0
TESTS_FAILED=0

# Test function
test_api() {
    local name=$1
    local url=$2
    local auth_header=$3

    echo -n "Testing $name... "

    response=$(curl -s -o /dev/null -w "%{http_code}" -H "$auth_header" "$url" 2>/dev/null)

    if [ "$response" == "200" ] || [ "$response" == "201" ]; then
        echo -e "${GREEN}[PASS]${NC} (HTTP $response)"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}[FAIL]${NC} (HTTP $response)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
}

# Test Anthropic API
if [ ! -z "$ANTHROPIC_API_KEY" ]; then
    echo -n "Testing Anthropic API... "
    response=$(curl -s -o /dev/null -w "%{http_code}" \
        -H "x-api-key: $ANTHROPIC_API_KEY" \
        -H "anthropic-version: 2023-06-01" \
        "https://api.anthropic.com/v1/messages" \
        -X POST \
        -d '{"model":"claude-3-5-sonnet-20241022","max_tokens":10,"messages":[{"role":"user","content":"Hi"}]}' \
        -H "Content-Type: application/json" 2>/dev/null)

    if [ "$response" == "200" ]; then
        echo -e "${GREEN}[PASS]${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}[FAIL]${NC} (HTTP $response)"
        TESTS_FAILED=$((TESTS_FAILED + 1))
    fi
else
    echo -e "${YELLOW}[SKIP]${NC} Anthropic API - No API key configured"
fi

# Test Airtable API
if [ ! -z "$AIRTABLE_API_KEY" ] && [ ! -z "$AIRTABLE_BASE_ID" ]; then
    test_api "Airtable API" \
        "https://api.airtable.com/v0/$AIRTABLE_BASE_ID" \
        "Authorization: Bearer $AIRTABLE_API_KEY"
else
    echo -e "${YELLOW}[SKIP]${NC} Airtable API - No credentials configured"
fi

# Test Printify API
if [ ! -z "$PRINTIFY_API_KEY" ]; then
    test_api "Printify API" \
        "https://api.printify.com/v1/shops.json" \
        "Authorization: Bearer $PRINTIFY_API_KEY"
else
    echo -e "${YELLOW}[SKIP]${NC} Printify API - No API key configured"
fi

# Test Slack API
if [ ! -z "$SLACK_BOT_TOKEN" ]; then
    test_api "Slack API" \
        "https://slack.com/api/auth.test" \
        "Authorization: Bearer $SLACK_BOT_TOKEN"
else
    echo -e "${YELLOW}[SKIP]${NC} Slack API - No bot token configured"
fi

# Test n8n (if running locally)
echo -n "Testing n8n (localhost:5678)... "
n8n_response=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:5678/healthz" 2>/dev/null || echo "000")
if [ "$n8n_response" == "200" ]; then
    echo -e "${GREEN}[PASS]${NC}"
    TESTS_PASSED=$((TESTS_PASSED + 1))
else
    echo -e "${YELLOW}[SKIP]${NC} (n8n not running locally)"
fi

# Summary
echo ""
echo "================================================"
echo "  Test Summary"
echo "================================================"
echo -e "Passed: ${GREEN}$TESTS_PASSED${NC}"
echo -e "Failed: ${RED}$TESTS_FAILED${NC}"
echo ""

if [ $TESTS_FAILED -eq 0 ]; then
    echo -e "${GREEN}All tests passed!${NC}"
    exit 0
else
    echo -e "${YELLOW}Some tests failed. Please check your configuration.${NC}"
    exit 1
fi
