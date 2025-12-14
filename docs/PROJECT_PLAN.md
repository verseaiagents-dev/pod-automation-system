# POD Automation System - Comprehensive Project Plan

## Project Overview

An AI-powered Print-on-Demand automation system that transforms a simple Slack command into a fully published Etsy product. Built with n8n, Claude 3.5 Sonnet, and integrated with Printify.

**Example Flow:**
```
User: "Generate design: abstract ocean waves"
     ↓
Bot: Creates design → Generates mockups → Writes copy → Creates Printify product → Publishes to Etsy
     ↓
Result: Live Etsy listing in ~30 minutes
```

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            SLACK INTERFACE                                   │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐        │
│  │ /generate   │  │ /status     │  │ /approve    │  │ /publish    │        │
│  │ /list       │  │ /reject     │  │ /edit       │  │ /help       │        │
│  └─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘        │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                          n8n WORKFLOW ENGINE                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │                      CLAUDE 3.5 SONNET AI AGENT                      │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐       │   │
│  │  │ Tool 1  │ │ Tool 2  │ │ Tool 3  │ │ Tool 4  │ │ Tool 5  │       │   │
│  │  │ Design  │ │ Mockup  │ │ Copy    │ │ Product │ │ Publish │       │   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘       │   │
│  │  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐                   │   │
│  │  │ Tool 6  │ │ Tool 7  │ │ Tool 8  │ │ Tool 9  │                   │   │
│  │  │ Status  │ │ Airtable│ │ Error   │ │ Notify  │                   │   │
│  │  └─────────┘ └─────────┘ └─────────┘ └─────────┘                   │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
└────────────────────────────────┬────────────────────────────────────────────┘
                                 │
        ┌────────────────────────┼────────────────────────┐
        ▼                        ▼                        ▼
┌───────────────┐       ┌───────────────┐       ┌───────────────┐
│   AIRTABLE    │       │  AI SERVICES  │       │   POD APIs    │
│   (8 Tables)  │       │               │       │               │
│ ┌───────────┐ │       │ ┌───────────┐ │       │ ┌───────────┐ │
│ │ Designs   │ │       │ │ Claude    │ │       │ │ Printify  │ │
│ │ Products  │ │       │ │ 3.5 Sonnet│ │       │ │ API       │ │
│ │ Mockups   │ │       │ └───────────┘ │       │ └───────────┘ │
│ │ Copy      │ │       │ ┌───────────┐ │       │ ┌───────────┐ │
│ │ Orders    │ │       │ │ NanoBanana│ │       │ │ Etsy      │ │
│ │ Settings  │ │       │ │ /DALL-E 3 │ │       │ │ (via      │ │
│ │ Logs      │ │       │ └───────────┘ │       │ │ Printify) │ │
│ │ Queue     │ │       │ ┌───────────┐ │       │ └───────────┘ │
│ └───────────┘ │       │ │ Placeit/  │ │       │               │
│               │       │ │ Mockup API│ │       │               │
└───────────────┘       └───────────────┘       └───────────────┘
```

---

## Tech Stack

| Component | Technology | Purpose |
|-----------|------------|---------|
| Workflow Engine | n8n (self-hosted or cloud) | Automation orchestration |
| AI Brain | Claude 3.5 Sonnet (Anthropic) | Natural language processing, decision making |
| Design Generation | NanoBanana (Gemini) / DALL-E 3 | AI artwork creation |
| Mockup Creation | Placeit API / Custom | Product visualization |
| Database | Airtable | Data storage, tracking |
| User Interface | Slack Bot | Command interface |
| POD Platform | Printify | Product fulfillment |
| Marketplace | Etsy (via Printify) | Sales channel |

---

## Airtable Database Schema (8 Tables)

### Table 1: Designs
| Field | Type | Description |
|-------|------|-------------|
| design_id | Auto Number | Primary key |
| prompt | Long Text | Original design prompt |
| enhanced_prompt | Long Text | AI-enhanced prompt |
| image_url | URL | Generated design URL |
| thumbnail_url | URL | Thumbnail version |
| status | Single Select | pending/generating/ready/approved/rejected |
| quality_score | Number | AI quality rating (1-10) |
| style_tags | Multiple Select | abstract, minimal, vintage, etc. |
| created_at | DateTime | Creation timestamp |
| approved_at | DateTime | Approval timestamp |
| linked_products | Link to Products | Related products |

### Table 2: Products
| Field | Type | Description |
|-------|------|-------------|
| product_id | Auto Number | Primary key |
| design_id | Link to Designs | Source design |
| product_type | Single Select | t-shirt, mug, poster, etc. |
| title | Single Line Text | Product title |
| description | Long Text | Full description |
| tags | Long Text | SEO tags (comma separated) |
| price | Currency | Selling price |
| cost | Currency | Production cost |
| margin | Formula | price - cost |
| printify_id | Single Line Text | Printify product ID |
| etsy_listing_id | Single Line Text | Etsy listing ID |
| status | Single Select | draft/pending_review/published/paused |
| created_at | DateTime | Creation timestamp |
| published_at | DateTime | Publication timestamp |

### Table 3: Mockups
| Field | Type | Description |
|-------|------|-------------|
| mockup_id | Auto Number | Primary key |
| design_id | Link to Designs | Source design |
| product_id | Link to Products | Related product |
| mockup_type | Single Select | front/back/lifestyle/detail |
| image_url | URL | Mockup image URL |
| is_primary | Checkbox | Primary listing image |
| created_at | DateTime | Creation timestamp |

### Table 4: Copy
| Field | Type | Description |
|-------|------|-------------|
| copy_id | Auto Number | Primary key |
| product_id | Link to Products | Related product |
| title_version | Number | Title variant number |
| title | Single Line Text | Product title |
| description | Long Text | Product description |
| tags | Long Text | Etsy tags |
| seo_score | Number | SEO quality score |
| is_selected | Checkbox | Currently used version |
| created_at | DateTime | Creation timestamp |

### Table 5: Queue
| Field | Type | Description |
|-------|------|-------------|
| queue_id | Auto Number | Primary key |
| task_type | Single Select | design/mockup/copy/publish |
| payload | Long Text | JSON task data |
| priority | Single Select | low/normal/high/urgent |
| status | Single Select | queued/processing/completed/failed |
| attempts | Number | Retry count |
| error_message | Long Text | Last error if failed |
| created_at | DateTime | Queued timestamp |
| started_at | DateTime | Processing start |
| completed_at | DateTime | Completion timestamp |

### Table 6: Settings
| Field | Type | Description |
|-------|------|-------------|
| setting_key | Single Line Text | Setting identifier |
| setting_value | Long Text | Setting value |
| setting_type | Single Select | string/number/boolean/json |
| description | Long Text | What this setting does |
| updated_at | DateTime | Last update |

### Table 7: Logs
| Field | Type | Description |
|-------|------|-------------|
| log_id | Auto Number | Primary key |
| level | Single Select | info/warning/error/debug |
| source | Single Select | slack/n8n/printify/etsy/ai |
| message | Long Text | Log message |
| metadata | Long Text | JSON additional data |
| related_design | Link to Designs | Related design if any |
| related_product | Link to Products | Related product if any |
| timestamp | DateTime | Log timestamp |

### Table 8: Analytics
| Field | Type | Description |
|-------|------|-------------|
| date | Date | Analytics date |
| designs_generated | Number | Count of designs |
| products_created | Number | Count of products |
| products_published | Number | Count published |
| api_costs | Currency | Total API costs |
| estimated_revenue | Currency | Based on prices |
| conversion_rate | Percent | approved/generated |

---

## 9 AI Agent Tools Specification

### Tool 1: generate_design
```json
{
  "name": "generate_design",
  "description": "Generate a new design using AI image generation",
  "parameters": {
    "prompt": "string - Design description",
    "style": "string - Design style (abstract, minimal, vintage, etc.)",
    "colors": "array - Preferred color palette",
    "dimensions": "string - Output dimensions"
  },
  "returns": {
    "design_id": "string",
    "image_url": "string",
    "quality_score": "number"
  }
}
```

### Tool 2: approve_design
```json
{
  "name": "approve_design",
  "description": "Approve or reject a generated design",
  "parameters": {
    "design_id": "string - Design to approve/reject",
    "action": "string - approve/reject",
    "feedback": "string - Optional feedback"
  },
  "returns": {
    "success": "boolean",
    "next_step": "string"
  }
}
```

### Tool 3: create_mockups
```json
{
  "name": "create_mockups",
  "description": "Generate product mockups for a design",
  "parameters": {
    "design_id": "string - Source design",
    "product_types": "array - Products to mock up",
    "mockup_styles": "array - front/back/lifestyle"
  },
  "returns": {
    "mockup_ids": "array",
    "mockup_urls": "array"
  }
}
```

### Tool 4: generate_copy
```json
{
  "name": "generate_copy",
  "description": "Generate product title, description, and tags",
  "parameters": {
    "design_id": "string - Source design",
    "product_type": "string - Product category",
    "target_audience": "string - Who is this for",
    "keywords": "array - SEO keywords to include"
  },
  "returns": {
    "title": "string",
    "description": "string",
    "tags": "array (max 13 for Etsy)"
  }
}
```

### Tool 5: create_printify_product
```json
{
  "name": "create_printify_product",
  "description": "Create a product in Printify",
  "parameters": {
    "design_id": "string - Source design",
    "mockup_ids": "array - Mockups to use",
    "copy_id": "string - Copy to use",
    "blueprint_id": "string - Printify product template",
    "variants": "array - Size/color variants"
  },
  "returns": {
    "printify_product_id": "string",
    "preview_url": "string"
  }
}
```

### Tool 6: publish_to_etsy
```json
{
  "name": "publish_to_etsy",
  "description": "Publish Printify product to Etsy",
  "parameters": {
    "printify_product_id": "string - Product to publish",
    "shop_section": "string - Etsy shop section",
    "pricing": "object - Price settings"
  },
  "returns": {
    "etsy_listing_id": "string",
    "listing_url": "string"
  }
}
```

### Tool 7: get_status
```json
{
  "name": "get_status",
  "description": "Get status of designs, products, or queue",
  "parameters": {
    "entity_type": "string - design/product/queue",
    "entity_id": "string - Specific ID or 'all'",
    "status_filter": "string - Filter by status"
  },
  "returns": {
    "items": "array",
    "summary": "object"
  }
}
```

### Tool 8: manage_airtable
```json
{
  "name": "manage_airtable",
  "description": "CRUD operations on Airtable",
  "parameters": {
    "operation": "string - create/read/update/delete",
    "table": "string - Table name",
    "record_id": "string - For update/delete",
    "data": "object - Record data"
  },
  "returns": {
    "success": "boolean",
    "record": "object"
  }
}
```

### Tool 9: handle_error
```json
{
  "name": "handle_error",
  "description": "Handle and recover from errors",
  "parameters": {
    "error_type": "string - Error category",
    "error_message": "string - Error details",
    "context": "object - Where error occurred",
    "retry_count": "number - Current attempt"
  },
  "returns": {
    "action": "string - retry/skip/notify",
    "message": "string"
  }
}
```

---

## Implementation Phases

### Phase 1: Foundation (20%) - Week 1-2

#### 1.1 n8n Setup
- [ ] Install n8n (Docker recommended)
- [ ] Configure environment variables
- [ ] Set up credentials store
- [ ] Create base workflow structure

#### 1.2 Slack Bot Setup
- [ ] Create Slack App in Slack API
- [ ] Configure OAuth scopes
- [ ] Set up Event Subscriptions
- [ ] Create Slash Commands
- [ ] Configure Interactive Components
- [ ] Connect to n8n webhook

#### 1.3 Airtable Setup
- [ ] Create Airtable Base
- [ ] Import 8 table schemas
- [ ] Configure field types and validations
- [ ] Set up linked records
- [ ] Create API key with proper scopes
- [ ] Test CRUD operations from n8n

#### 1.4 AI Agent Setup
- [ ] Configure Anthropic API credentials
- [ ] Create AI Agent node in n8n
- [ ] Define system prompt (4 pages)
- [ ] Configure tool definitions
- [ ] Test basic conversation flow

**Deliverables:**
- Working Slack bot responding to commands
- Airtable database with all tables
- AI Agent processing natural language
- Basic logging system

---

### Phase 2: Design Generation (25%) - Week 2-3

#### 2.1 Image Generation Integration
- [ ] Set up NanoBanana/DALL-E API
- [ ] Create prompt enhancement workflow
- [ ] Implement quality scoring system
- [ ] Add style presets
- [ ] Configure output dimensions

#### 2.2 Design Workflow
```
User Input → Enhance Prompt → Generate Image → Quality Check → Store in Airtable → Notify User
```

- [ ] Build prompt enhancement with Claude
- [ ] Create image generation node
- [ ] Implement quality assessment (Claude Vision)
- [ ] Auto-retry for low-quality outputs
- [ ] Store designs in Airtable
- [ ] Send preview to Slack

#### 2.3 Approval System
- [ ] Create Slack interactive buttons
- [ ] Implement approve/reject flow
- [ ] Add feedback collection
- [ ] Update Airtable status
- [ ] Trigger next phase on approval

**Deliverables:**
- Design generation from Slack command
- AI quality assessment
- Interactive approval in Slack
- Design storage and tracking

---

### Phase 3: Mockups & Copy (25%) - Week 3-4

#### 3.1 Mockup Generation
- [ ] Integrate mockup API (Placeit/Custom)
- [ ] Define product templates
- [ ] Create multi-angle mockups
- [ ] Implement lifestyle mockups
- [ ] Store mockups in Airtable

#### 3.2 AI Copywriting
```
Design + Context → Claude → Title + Description + Tags → Store → Review
```

- [ ] Create copy generation prompt
- [ ] Implement Etsy SEO best practices
- [ ] Generate multiple title variants
- [ ] Create compelling descriptions
- [ ] Generate 13 relevant tags
- [ ] Add A/B testing capability

#### 3.3 Copy Optimization
- [ ] Implement SEO scoring
- [ ] Add keyword density check
- [ ] Ensure Etsy character limits
- [ ] Create copy review interface
- [ ] Allow manual edits via Slack

**Deliverables:**
- Automated mockup generation
- AI-generated product copy
- SEO-optimized titles and tags
- Review and edit workflow

---

### Phase 4: Printify & Etsy (20%) - Week 4-5

#### 4.1 Printify Integration
- [ ] Configure Printify API credentials
- [ ] Map product blueprints
- [ ] Set up print areas
- [ ] Configure variants (sizes, colors)
- [ ] Implement pricing logic
- [ ] Create product in Printify

#### 4.2 Etsy Publishing
```
Printify Product → Configure Listing → Set Price → Add to Section → Publish → Get URL
```

- [ ] Configure Etsy shop connection
- [ ] Map shop sections
- [ ] Set pricing rules
- [ ] Configure shipping profiles
- [ ] Publish listing
- [ ] Verify publication

#### 4.3 Sync & Updates
- [ ] Implement inventory sync
- [ ] Handle order notifications
- [ ] Update product status
- [ ] Track listing performance

**Deliverables:**
- One-click Printify product creation
- Automated Etsy publishing
- Price and inventory management
- End-to-end automation

---

### Phase 5: Testing & Documentation (10%) - Week 5-6

#### 5.1 Error Handling
- [ ] Implement retry logic for all APIs
- [ ] Add rate limiting awareness
- [ ] Create fallback mechanisms
- [ ] Set up error notifications
- [ ] Implement graceful degradation

#### 5.2 Testing
- [ ] Unit test each tool
- [ ] Integration test full workflow
- [ ] Load test with multiple designs
- [ ] Test error recovery
- [ ] User acceptance testing

#### 5.3 Documentation
- [ ] API documentation
- [ ] User guide for Slack commands
- [ ] Admin guide for configuration
- [ ] Troubleshooting guide
- [ ] Video walkthrough

#### 5.4 Handoff
- [ ] Final review with stakeholder
- [ ] Knowledge transfer session
- [ ] Production deployment
- [ ] Monitor first week

**Deliverables:**
- Robust error handling
- Comprehensive documentation
- Training materials
- Production-ready system

---

## Slack Commands Reference

| Command | Description | Example |
|---------|-------------|---------|
| `/generate` | Create new design | `/generate abstract ocean waves, blue palette` |
| `/status` | Check workflow status | `/status design-123` |
| `/list` | List items | `/list designs pending` |
| `/approve` | Approve design | `/approve design-123` |
| `/reject` | Reject design | `/reject design-123 "too busy"` |
| `/mockup` | Generate mockups | `/mockup design-123 tshirt,mug` |
| `/copy` | Generate product copy | `/copy design-123` |
| `/publish` | Publish to Etsy | `/publish product-456` |
| `/help` | Show help | `/help` |

---

## Error Handling Strategy

### Retry Logic
```javascript
const retryConfig = {
  maxAttempts: 3,
  backoffMultiplier: 2,
  initialDelay: 1000, // ms
  maxDelay: 30000 // ms
};
```

### Error Categories
| Category | Action | Notification |
|----------|--------|--------------|
| API Rate Limit | Wait & Retry | None |
| API Error | Retry 3x | If fails |
| Invalid Input | Skip & Notify | Immediate |
| System Error | Alert Admin | Immediate |

---

## Cost Estimation (per 100 products)

| Service | Cost per Unit | Units | Total |
|---------|--------------|-------|-------|
| Claude 3.5 Sonnet | ~$0.003/1K tokens | 500K tokens | $1.50 |
| NanoBanana/DALL-E | ~$0.02-0.04/image | 100 images | $4.00 |
| Mockup API | ~$0.10/mockup | 300 mockups | $30.00 |
| Airtable | Free tier | - | $0.00 |
| n8n | Self-hosted | - | $0.00 |
| **Total** | | | **~$35.50** |

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Design Generation Time | < 2 minutes |
| Full Pipeline Time | < 30 minutes |
| Design Approval Rate | > 70% |
| System Uptime | > 99% |
| Error Rate | < 5% |

---

## Security Considerations

1. **API Keys**: Store in n8n credentials, never in workflows
2. **Airtable**: Use scoped tokens with minimum permissions
3. **Slack**: Verify request signatures
4. **Rate Limiting**: Implement client-side limits
5. **Logging**: Never log sensitive data

---

## GitHub Repository Structure

```
pod-automation-system/
├── README.md
├── LICENSE
├── .gitignore
├── .env.example
├── docs/
│   ├── PROJECT_PLAN.md
│   ├── ARCHITECTURE.md
│   ├── API_REFERENCE.md
│   ├── USER_GUIDE.md
│   └── TROUBLESHOOTING.md
├── n8n-workflows/
│   ├── main-agent.json
│   ├── design-generation.json
│   ├── mockup-creation.json
│   ├── copy-generation.json
│   ├── printify-integration.json
│   └── slack-handler.json
├── slack-bot/
│   ├── commands/
│   └── interactive/
├── airtable-schemas/
│   ├── designs.csv
│   ├── products.csv
│   ├── mockups.csv
│   ├── copy.csv
│   ├── queue.csv
│   ├── settings.csv
│   ├── logs.csv
│   └── analytics.csv
├── assets/
│   ├── system-prompt.md
│   └── tool-definitions.json
└── scripts/
    ├── setup.sh
    └── test.sh
```

---

## References & Resources

### Official Documentation
- [n8n AI Agents](https://n8n.io/ai-agents/)
- [n8n Airtable Integration](https://n8n.io/integrations/airtable/)
- [Printify API Reference](https://developers.printify.com/)
- [NanoBanana API](https://ai.google.dev/gemini-api/docs/image-generation)
- [Slack API](https://api.slack.com/)

### Workflow Templates
- [Auto-Generate Trending Merchandise on Printify](https://n8n.io/workflows/11175-auto-generate-trending-merchandise-on-printify-with-gpt-4o-stable-diffusion-and-google-trends/)
- [Slack AI Chatbot with Claude 3.7](https://n8n.io/workflows/3414-slack-ai-chatbot-for-business-team-with-rag-claude-37-sonnet-and-google-drive/)
- [AI Agent to Chat with Airtable](https://n8n.io/workflows/2700-ai-agent-to-chat-with-airtable-and-analyze-data/)

### Tutorials
- [n8n AI Workflow Tutorial](https://docs.n8n.io/advanced-ai/intro-tutorial/)
- [How to Build AI Agent](https://blog.n8n.io/how-to-build-ai-agent/)
- [Connect Claude AI with n8n](https://blog.horizon.dev/connect-claude-ai-with-n8n/)

---

## Next Steps

1. **Immediate**: Set up development environment
2. **Day 1-2**: Create GitHub repo and basic structure
3. **Week 1**: Complete Phase 1 (Foundation)
4. **Week 2-3**: Complete Phase 2 (Design Generation)
5. **Week 3-4**: Complete Phase 3 (Mockups & Copy)
6. **Week 4-5**: Complete Phase 4 (Printify & Etsy)
7. **Week 5-6**: Complete Phase 5 (Testing & Docs)

---

*Last Updated: December 2024*
*Version: 1.0*
