<p align="center">
  <img src="assets/images/logo.png" width="400" alt="POD Automation System">
</p>

<p align="center">
  <strong>🚀 AI-Powered Print-on-Demand Automation Framework</strong>
</p>

<p align="center">
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/stargazers">
    <img src="https://img.shields.io/github/stars/verseaiagents-dev/pod-automation-system?style=flat-square&logo=github&color=yellow" alt="Stars">
  </a>
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/network/members">
    <img src="https://img.shields.io/github/forks/verseaiagents-dev/pod-automation-system?style=flat-square&logo=github" alt="Forks">
  </a>
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/Version-1.0.0-green.svg?style=flat-square" alt="Version">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/n8n-1.x-FF6D5A?style=flat-square&logo=n8n&logoColor=white" alt="n8n">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/Claude-3.5%20Sonnet-6B5CE7?style=flat-square&logo=anthropic&logoColor=white" alt="Claude">
  </a>
</p>

<p align="center">
  <b>English</b> | <a href="docs/README_TR.md">Türkçe</a>
</p>

<p align="center">
  <a href="#-overview">Overview</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-key-features">Key Features</a> •
  <a href="#-getting-started">Getting Started</a> •
  <a href="#-api-reference">API Reference</a> •
  <a href="#-developer-guide">Developer Guide</a>
</p>

---

## 📌 Overview

**POD Automation System** is an end-to-end AI-powered automation framework for Print-on-Demand businesses. It transforms simple text commands into fully published marketplace products through intelligent workflow orchestration.

Built on **n8n** workflow engine with **Claude 3.5 Sonnet** as the AI brain, the system handles everything from design generation to Etsy publishing - all controllable through natural language commands in Slack.

```
You: /generate abstract ocean waves, blue palette

🤖 POD Agent:
   ✅ Design generated (Quality: 8.5/10)
   ✅ Mockups created (3 products)
   ✅ SEO copy written (13 tags)
   ✅ Published to Etsy

📦 Result: Live listing in ~30 minutes
```

---

## ✨ Latest Updates

- 🎨 **v1.0.0** - Initial release with full automation pipeline
- 🤖 **AI Agent** - Claude 3.5 Sonnet integration with 9 specialized tools
- 🖼️ **Design Generation** - NanoBanana (Gemini) & DALL-E 3 support
- 📊 **Airtable Integration** - 8 interconnected tables for complete tracking
- 🔄 **n8n Workflows** - 4 production-ready workflow templates
- 📝 **Smart Copywriting** - SEO-optimized titles, descriptions, and Etsy tags

---

## 🔒 Security Notice

> ⚠️ **Important**: Never commit API keys or sensitive credentials to the repository. Always use environment variables and the `.env` file (which is gitignored) for configuration.

---

## 🏗️ Architecture

<p align="center">
  <img src="assets/images/architecture.png" width="800" alt="System Architecture">
</p>

```
┌─────────────────────────────────────────────────────────────────────────┐
│                            SLACK INTERFACE                               │
│    /generate    /status    /approve    /publish    /mockup    /help     │
└────────────────────────────────┬────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         n8n WORKFLOW ENGINE                              │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                   CLAUDE 3.5 SONNET AI AGENT                       │  │
│  │                                                                    │  │
│  │   ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐            │  │
│  │   │ Design   │ │ Mockup   │ │ Copy     │ │ Product  │            │  │
│  │   │ Tool     │ │ Tool     │ │ Tool     │ │ Tool     │            │  │
│  │   └──────────┘ └──────────┘ └──────────┘ └──────────┘            │  │
│  │   ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐            │  │
│  │   │ Publish  │ │ Status   │ │ Airtable │ │ Error    │            │  │
│  │   │ Tool     │ │ Tool     │ │ Tool     │ │ Handler  │            │  │
│  │   └──────────┘ └──────────┘ └──────────┘ └──────────┘            │  │
│  └───────────────────────────────────────────────────────────────────┘  │
└────────────────────────────────┬────────────────────────────────────────┘
                                 │
           ┌─────────────────────┼─────────────────────┐
           ▼                     ▼                     ▼
   ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
   │   AIRTABLE    │     │  AI SERVICES  │     │   POD APIs    │
   │   Database    │     │               │     │               │
   │               │     │ • Claude 3.5  │     │ • Printify    │
   │ • Designs     │     │ • NanoBanana  │     │ • Etsy        │
   │ • Products    │     │ • DALL-E 3    │     │               │
   │ • Mockups     │     │ • Placeit     │     │               │
   │ • Copy        │     │               │     │               │
   │ • Queue       │     │               │     │               │
   │ • Analytics   │     │               │     │               │
   └───────────────┘     └───────────────┘     └───────────────┘
```

---

## 🎯 Key Features

| Feature | Description |
|---------|-------------|
| 🎨 **AI Design Generation** | Create unique artwork from text prompts using NanoBanana (Gemini) or DALL-E 3 with automatic quality scoring |
| 🔍 **Smart Quality Control** | AI-powered design evaluation with auto-retry for low-quality outputs (threshold: 7/10) |
| 👕 **Automated Mockups** | Generate professional product mockups across 8+ product types (t-shirts, mugs, posters, etc.) |
| ✍️ **SEO Copywriting** | AI-generated titles, descriptions, and exactly 13 Etsy-optimized tags |
| 🚀 **One-Click Publishing** | Direct Printify product creation and Etsy listing publication |
| 💬 **Conversational Interface** | Natural language commands via Slack with interactive buttons |
| 📊 **Complete Tracking** | Full audit trail in Airtable with 8 interconnected tables |
| 🔄 **Error Recovery** | Automatic retry logic with exponential backoff and user notifications |
| 📈 **Analytics Dashboard** | Track designs, products, costs, and conversion rates |

---

## 📋 Application Scenarios

| Scenario | Applications | Core Value |
|----------|-------------|------------|
| **Solo Entrepreneur** | Individual POD sellers managing their own shop | Automate 80% of product creation workflow |
| **Design Agency** | Teams creating products for multiple clients | Scale output without scaling headcount |
| **Dropshipping Business** | High-volume sellers on multiple platforms | Rapid product listing with consistent quality |
| **Content Creator** | YouTubers/influencers selling merchandise | Convert ideas to products in minutes |
| **E-commerce Brand** | Established brands expanding product lines | Test new designs quickly and cheaply |

---

## 📊 Feature Matrix

| Module | Status | Description |
|--------|--------|-------------|
| **Slack Integration** | ✅ Ready | Full command interface with interactive buttons |
| **AI Agent (Claude)** | ✅ Ready | 9 specialized tools for workflow automation |
| **Design Generation** | ✅ Ready | NanoBanana & DALL-E 3 support |
| **Quality Scoring** | ✅ Ready | AI-powered design evaluation |
| **Mockup Creation** | ✅ Ready | Multi-product mockup generation |
| **Copy Generation** | ✅ Ready | SEO-optimized Etsy copywriting |
| **Printify Integration** | ✅ Ready | Product creation and management |
| **Etsy Publishing** | ✅ Ready | Direct listing publication |
| **Airtable Database** | ✅ Ready | 8-table schema with relationships |
| **Error Handling** | ✅ Ready | Retry logic and notifications |
| **Analytics** | ✅ Ready | Cost and performance tracking |
| **Multi-language Copy** | 🔜 Planned | Support for multiple languages |
| **Shopify Integration** | 🔜 Planned | Alternative marketplace support |
| **Bulk Operations** | 🔜 Planned | Process multiple designs at once |
| **Custom Workflows** | 🔜 Planned | User-defined automation rules |

---

## 🚀 Getting Started

### Prerequisites

| Requirement | Version | Purpose |
|-------------|---------|---------|
| n8n | 1.x+ | Workflow automation engine |
| Node.js | 18+ | Runtime (for n8n) |
| Docker | Latest | Containerized deployment |
| Slack Workspace | - | Command interface |
| Airtable Account | - | Database |

### ① Clone Repository

```bash
git clone https://github.com/verseaiagents-dev/pod-automation-system.git
cd pod-automation-system
```

### ② Configure Environment

```bash
# Copy environment template
cp .env.example .env

# Edit with your API keys
nano .env
```

**Required API Keys:**
```env
ANTHROPIC_API_KEY=sk-ant-xxxxx      # Claude AI
AIRTABLE_API_KEY=patxxxxx           # Airtable
AIRTABLE_BASE_ID=appxxxxx           # Airtable Base
SLACK_BOT_TOKEN=xoxb-xxxxx          # Slack Bot
PRINTIFY_API_KEY=xxxxx              # Printify
NANOBANANA_API_KEY=xxxxx            # Design Generation (or OPENAI_API_KEY)
```

### ③ Start n8n

**Option A: Docker (Recommended)**
```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  -e N8N_BASIC_AUTH_ACTIVE=true \
  -e N8N_BASIC_AUTH_USER=admin \
  -e N8N_BASIC_AUTH_PASSWORD=password \
  n8nio/n8n
```

**Option B: npm**
```bash
npm install -g n8n
n8n start
```

### ④ Import Workflows

1. Open n8n at `http://localhost:5678`
2. Go to **Workflows** → **Import from File**
3. Import all JSON files from `n8n-workflows/`:
   - `01-slack-handler.json`
   - `02-ai-agent.json`
   - `03-design-generation.json`
   - `04-printify-integration.json`

### ⑤ Setup Airtable

1. Create new Airtable base
2. Import tables from `airtable-schemas/` CSV files
3. Configure linked records between tables
4. Copy Base ID to `.env`

### ⑥ Configure Slack App

1. Go to [api.slack.com/apps](https://api.slack.com/apps)
2. Create new app → From manifest
3. Add required scopes:
   - `commands`
   - `chat:write`
   - `channels:history`
   - `users:read`
4. Create slash commands (`/generate`, `/status`, etc.)
5. Install to workspace

### ⑦ Verify Setup

```bash
./scripts/test.sh
```

---

## 💬 Slack Commands

| Command | Description | Example |
|---------|-------------|---------|
| `/generate` | Create new AI design | `/generate sunset over mountains, warm colors` |
| `/status` | Check workflow status | `/status design-123` |
| `/list` | List items by status | `/list designs pending` |
| `/approve` | Approve a design | `/approve design-123` |
| `/reject` | Reject with feedback | `/reject design-123 "too busy"` |
| `/mockup` | Generate mockups | `/mockup design-123 tshirt,mug` |
| `/copy` | Generate product copy | `/copy design-123` |
| `/publish` | Publish to Etsy | `/publish product-456` |
| `/help` | Show all commands | `/help` |

---

## 🔧 AI Agent Tools

The system includes **9 specialized tools** that the AI agent can invoke:

```
┌─────────────────────────────────────────────────────────────────┐
│                        AI AGENT TOOLS                            │
├─────────────────────────────────────────────────────────────────┤
│  generate_design      │ Create AI artwork from text prompt      │
│  approve_design       │ Approve/reject generated designs        │
│  create_mockups       │ Generate product mockups                │
│  generate_copy        │ Write SEO-optimized product copy        │
│  create_printify_product │ Create product in Printify           │
│  publish_to_etsy      │ Publish listing to Etsy                 │
│  get_status           │ Check status of any entity              │
│  manage_airtable      │ CRUD operations on database             │
│  handle_error         │ Error recovery and retry logic          │
└─────────────────────────────────────────────────────────────────┘
```

See [Tool Definitions](assets/tool-definitions.json) for complete schemas.

---

## 📁 Project Structure

```
pod-automation-system/
│
├── 📄 README.md                 # This file
├── 📄 LICENSE                   # MIT License
├── 📄 CONTRIBUTING.md           # Contribution guidelines
├── 📄 CHANGELOG.md              # Version history
├── 📄 .env.example              # Environment template
├── 📄 .gitignore                # Git ignore rules
│
├── 📁 docs/                     # Documentation
│   ├── PROJECT_PLAN.md          # Comprehensive implementation plan
│   ├── API_REFERENCE.md         # API documentation
│   └── README_TR.md             # Turkish README
│
├── 📁 n8n-workflows/            # n8n workflow templates
│   ├── 01-slack-handler.json    # Slack command router
│   ├── 02-ai-agent.json         # Core AI agent
│   ├── 03-design-generation.json # Design pipeline
│   └── 04-printify-integration.json # POD integration
│
├── 📁 airtable-schemas/         # Database schemas
│   ├── designs.csv
│   ├── products.csv
│   ├── mockups.csv
│   ├── copy.csv
│   ├── queue.csv
│   ├── settings.csv
│   ├── logs.csv
│   └── analytics.csv
│
├── 📁 assets/                   # Assets and configs
│   ├── system-prompt.md         # AI agent system prompt
│   ├── tool-definitions.json    # Tool schemas
│   └── 📁 images/               # Documentation images
│
└── 📁 scripts/                  # Utility scripts
    ├── setup.sh                 # Environment setup
    └── test.sh                  # Connection testing
```

---

## 💰 Cost Estimation

| Service | Per Unit | Per 100 Products | Notes |
|---------|----------|------------------|-------|
| Claude API | ~$0.003/1K tokens | ~$1.50 | Agent + copywriting |
| NanoBanana | ~$0.02/image | ~$2.00 | Design generation |
| DALL-E 3 | ~$0.04/image | ~$4.00 | Alternative option |
| Mockup API | ~$0.10/mockup | ~$30.00 | 3 mockups per product |
| Airtable | Free | $0.00 | Free tier sufficient |
| n8n | Self-hosted | $0.00 | Or ~$20/mo cloud |
| **Total** | | **~$33-36** | Per 100 products |

---

## 📚 Documentation

| Document | Description |
|----------|-------------|
| [Project Plan](docs/PROJECT_PLAN.md) | Comprehensive implementation guide |
| [API Reference](docs/API_REFERENCE.md) | Tool and endpoint documentation |
| [Contributing](CONTRIBUTING.md) | How to contribute |
| [Changelog](CHANGELOG.md) | Version history |
| [System Prompt](assets/system-prompt.md) | AI agent configuration |

---

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

```bash
# Fork and clone
git clone https://github.com/YOUR_USERNAME/pod-automation-system.git

# Create feature branch
git checkout -b feature/amazing-feature

# Commit changes
git commit -m "feat: add amazing feature"

# Push and create PR
git push origin feature/amazing-feature
```

---

## 📜 License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---

## ⭐ Star History

<p align="center">
  <a href="https://star-history.com/#verseaiagents-dev/pod-automation-system&Date">
    <img src="https://api.star-history.com/svg?repos=verseaiagents-dev/pod-automation-system&type=Date" alt="Star History Chart">
  </a>
</p>

---

## 👥 Contributors

<p align="center">
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=verseaiagents-dev/pod-automation-system" alt="Contributors">
  </a>
</p>

---

<p align="center">
  Made with ❤️ by <a href="https://github.com/verseaiagents-dev">VerseAI Agents</a>
</p>

<p align="center">
  <sub>Built with AI assistance using Claude Code</sub>
</p>
