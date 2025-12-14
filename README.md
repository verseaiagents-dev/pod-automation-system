<p align="center">
  <img src="https://img.shields.io/badge/n8n-1.x-FF6D5A?style=for-the-badge&logo=n8n&logoColor=white" alt="n8n">
  <img src="https://img.shields.io/badge/Claude-3.5%20Sonnet-6B5CE7?style=for-the-badge&logo=anthropic&logoColor=white" alt="Claude">
  <img src="https://img.shields.io/badge/Printify-API-00C389?style=for-the-badge" alt="Printify">
  <img src="https://img.shields.io/badge/Etsy-Marketplace-F56400?style=for-the-badge&logo=etsy&logoColor=white" alt="Etsy">
</p>

<h1 align="center">POD Automation System</h1>

<p align="center">
  <strong>AI-powered Print-on-Demand automation that transforms text commands into published Etsy products</strong>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#quick-start">Quick Start</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#documentation">Documentation</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## Overview

An end-to-end automation system for Print-on-Demand businesses. Control everything through natural language commands in Slack - from AI design generation to Etsy publishing.

```
You: /generate abstract ocean waves, blue palette

Bot: ✅ Design generated (Quality: 8.5/10)
     → Creating mockups...
     → Writing product copy...
     → Publishing to Etsy...

Result: Live listing in ~30 minutes
```

## Features

| Feature | Description |
|---------|-------------|
| **AI Design Generation** | Create unique artwork from text using NanoBanana/DALL-E |
| **Smart Quality Control** | AI-powered scoring with auto-retry for quality issues |
| **Automated Mockups** | Generate professional mockups across product types |
| **SEO-Optimized Copy** | AI-generated titles, descriptions, and Etsy tags |
| **One-Click Publishing** | Direct integration with Printify → Etsy |
| **Conversational Interface** | Natural language commands via Slack |
| **Full Tracking** | Complete audit trail in Airtable |

## Quick Start

### Prerequisites

- n8n instance (self-hosted or cloud)
- Slack workspace with admin access
- Airtable account
- API keys: Anthropic (Claude), NanoBanana/OpenAI, Printify

### Installation

```bash
# Clone the repository
git clone https://github.com/verseaiagents-dev/pod-automation-system.git
cd pod-automation-system

# Run setup script
./scripts/setup.sh

# Configure environment
cp .env.example .env
# Edit .env with your API keys

# Verify connections
./scripts/test.sh
```

### Import Workflows

1. Open n8n dashboard
2. Go to Workflows → Import
3. Import JSON files from `n8n-workflows/`
4. Configure credentials for each service

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         SLACK BOT                                │
│   /generate  /status  /approve  /publish  /mockup  /help        │
└──────────────────────────┬──────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────────────────────────────────────────┐
│                      n8n WORKFLOW ENGINE                         │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │              CLAUDE 3.5 SONNET AI AGENT                  │   │
│  │                                                          │   │
│  │  [Design]  [Mockup]  [Copy]  [Product]  [Publish]       │   │
│  │  [Status]  [Airtable]  [Error]  [Notify]                │   │
│  └─────────────────────────────────────────────────────────┘   │
└──────────────────────────┬──────────────────────────────────────┘
                           │
         ┌─────────────────┼─────────────────┐
         ▼                 ▼                 ▼
┌─────────────┐    ┌─────────────┐    ┌─────────────┐
│  AIRTABLE   │    │ AI SERVICES │    │  POD APIs   │
│  (8 Tables) │    │             │    │             │
│             │    │ Claude 3.5  │    │  Printify   │
│ • Designs   │    │ NanoBanana  │    │  Etsy       │
│ • Products  │    │ DALL-E 3    │    │             │
│ • Mockups   │    │             │    │             │
│ • Copy      │    │             │    │             │
│ • Queue     │    │             │    │             │
│ • Settings  │    │             │    │             │
│ • Logs      │    │             │    │             │
│ • Analytics │    │             │    │             │
└─────────────┘    └─────────────┘    └─────────────┘
```

## Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Workflow Engine** | n8n | Automation orchestration |
| **AI Agent** | Claude 3.5 Sonnet | Natural language processing |
| **Design Generation** | NanoBanana / DALL-E 3 | AI artwork creation |
| **Database** | Airtable | Data storage & tracking |
| **Interface** | Slack Bot | Command interface |
| **POD Platform** | Printify | Product fulfillment |
| **Marketplace** | Etsy | Sales channel |

## Slack Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/generate` | Create new design | `/generate sunset mountains, warm colors` |
| `/status` | Check workflow status | `/status design-123` |
| `/approve` | Approve design | `/approve design-123` |
| `/reject` | Reject design | `/reject design-123 "too busy"` |
| `/mockup` | Generate mockups | `/mockup design-123 tshirt,mug` |
| `/copy` | Generate product copy | `/copy design-123` |
| `/publish` | Publish to Etsy | `/publish product-456` |
| `/list` | List items | `/list designs pending` |
| `/help` | Show help | `/help` |

## AI Agent Tools

The system includes 9 specialized tools:

1. **generate_design** - AI artwork creation with quality scoring
2. **approve_design** - Design approval/rejection workflow
3. **create_mockups** - Multi-product mockup generation
4. **generate_copy** - SEO-optimized titles, descriptions, tags
5. **create_printify_product** - Printify product creation
6. **publish_to_etsy** - Etsy listing publication
7. **get_status** - Status tracking across all entities
8. **manage_airtable** - Database CRUD operations
9. **handle_error** - Error recovery and retry logic

## Project Structure

```
pod-automation-system/
├── README.md
├── LICENSE
├── CONTRIBUTING.md
├── CHANGELOG.md
├── .env.example
├── .gitignore
│
├── docs/
│   └── PROJECT_PLAN.md          # Comprehensive implementation plan
│
├── n8n-workflows/
│   ├── 01-slack-handler.json    # Slack command router
│   ├── 02-ai-agent.json         # Core AI agent
│   ├── 03-design-generation.json # Design creation pipeline
│   └── 04-printify-integration.json # Printify/Etsy publishing
│
├── airtable-schemas/
│   ├── designs.csv
│   ├── products.csv
│   ├── mockups.csv
│   ├── copy.csv
│   ├── queue.csv
│   ├── settings.csv
│   ├── logs.csv
│   └── analytics.csv
│
├── assets/
│   ├── system-prompt.md         # AI Agent system prompt
│   └── tool-definitions.json    # 9 tool schemas
│
└── scripts/
    ├── setup.sh                 # Environment setup
    └── test.sh                  # Connection testing
```

## Cost Estimation

Per 100 products:

| Service | Est. Cost |
|---------|-----------|
| Claude API | ~$1.50 |
| Design Generation | ~$4.00 |
| Mockup API | ~$30.00 |
| n8n (self-hosted) | $0.00 |
| Airtable (free tier) | $0.00 |
| **Total** | **~$35.50** |

## Documentation

- [Project Plan](docs/PROJECT_PLAN.md) - Comprehensive implementation guide
- [Contributing](CONTRIBUTING.md) - How to contribute
- [Changelog](CHANGELOG.md) - Version history

## Contributing

Contributions are welcome! Please read our [Contributing Guide](CONTRIBUTING.md) for details.

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing`)
3. Commit your changes (`git commit -m 'feat: add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing`)
5. Open a Pull Request

## Resources

- [n8n Documentation](https://docs.n8n.io/)
- [n8n AI Agents Guide](https://docs.n8n.io/advanced-ai/)
- [Printify API Reference](https://developers.printify.com/)
- [Anthropic API Docs](https://docs.anthropic.com/)
- [Slack API](https://api.slack.com/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<p align="center">
  Built with AI assistance using Claude Code
</p>
