# API Reference

This document provides detailed documentation for all AI Agent tools and API integrations in the POD Automation System.

---

## Table of Contents

- [AI Agent Tools](#ai-agent-tools)
  - [generate_design](#generate_design)
  - [approve_design](#approve_design)
  - [create_mockups](#create_mockups)
  - [generate_copy](#generate_copy)
  - [create_printify_product](#create_printify_product)
  - [publish_to_etsy](#publish_to_etsy)
  - [get_status](#get_status)
  - [manage_airtable](#manage_airtable)
  - [handle_error](#handle_error)
- [External APIs](#external-apis)
- [Webhooks](#webhooks)
- [Error Codes](#error-codes)

---

## AI Agent Tools

### generate_design

Creates a new AI-generated design based on a text prompt.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `prompt` | string | ✅ | - | Design description/concept |
| `style` | string | ❌ | "modern" | Visual style (abstract, minimal, vintage, modern, artistic, geometric, nature, typography) |
| `colors` | array | ❌ | [] | Preferred color palette |
| `dimensions` | string | ❌ | "square" | Output dimensions (square, portrait, landscape) |
| `enhance_prompt` | boolean | ❌ | true | AI-enhance prompt before generation |

**Returns:**

```json
{
  "design_id": "rec123abc",
  "image_url": "https://...",
  "thumbnail_url": "https://...",
  "quality_score": 8.5,
  "enhanced_prompt": "...",
  "status": "ready"
}
```

**Example:**

```javascript
await generateDesign({
  prompt: "abstract ocean waves",
  style: "modern",
  colors: ["blue", "white", "gold"],
  dimensions: "square"
});
```

---

### approve_design

Approves or rejects a generated design.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `design_id` | string | ✅ | - | Design identifier |
| `action` | string | ✅ | - | "approve" or "reject" |
| `feedback` | string | ❌ | - | Reason for rejection |
| `regenerate` | boolean | ❌ | false | Auto-regenerate if rejected |

**Returns:**

```json
{
  "success": true,
  "design_id": "rec123abc",
  "new_status": "approved",
  "next_step": "create_mockups"
}
```

---

### create_mockups

Generates product mockups for an approved design.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `design_id` | string | ✅ | - | Source design ID |
| `product_types` | array | ✅ | - | Products to mock up |
| `mockup_styles` | array | ❌ | ["front", "lifestyle"] | Mockup view types |
| `colors` | array | ❌ | ["black", "white"] | Product color variants |

**Product Types:**

- `t-shirt`
- `hoodie`
- `mug`
- `poster`
- `phone-case`
- `tote-bag`
- `pillow`
- `sticker`

**Returns:**

```json
{
  "mockups": [
    {
      "mockup_id": "mock123",
      "product_type": "t-shirt",
      "style": "front",
      "color": "black",
      "image_url": "https://..."
    }
  ],
  "count": 6
}
```

---

### generate_copy

Creates SEO-optimized product copy.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `design_id` | string | ✅ | - | Source design ID |
| `product_type` | string | ✅ | - | Product category |
| `target_audience` | string | ❌ | "general" | Ideal customer description |
| `keywords` | array | ❌ | [] | SEO keywords to include |
| `tone` | string | ❌ | "casual" | Writing tone |
| `variants_count` | integer | ❌ | 3 | Number of title variants |

**Tone Options:**

- `professional`
- `casual`
- `fun`
- `luxury`
- `minimalist`

**Returns:**

```json
{
  "copy_id": "copy123",
  "titles": [
    "Ocean Waves Abstract Art T-Shirt",
    "Blue Wave Design Tee",
    "Coastal Abstract Print Shirt"
  ],
  "description": "Dive into tranquility with this stunning abstract ocean wave design...",
  "tags": [
    "ocean waves",
    "abstract art",
    "blue aesthetic",
    "coastal design",
    "wave pattern",
    "nature inspired",
    "modern art",
    "minimalist design",
    "beach vibes",
    "water art",
    "sea waves",
    "abstract tee",
    "artistic shirt"
  ],
  "seo_score": 8.2
}
```

---

### create_printify_product

Creates a product in Printify.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `design_id` | string | ✅ | - | Source design ID |
| `blueprint_id` | string | ✅ | - | Printify blueprint ID |
| `print_provider_id` | string | ✅ | - | Print provider ID |
| `title` | string | ✅ | - | Product title |
| `description` | string | ❌ | - | Product description |
| `tags` | array | ❌ | [] | Product tags (max 13) |
| `variants` | array | ✅ | - | Variant configurations |
| `mockup_ids` | array | ❌ | [] | Mockups for images |

**Returns:**

```json
{
  "printify_product_id": "64abc123",
  "preview_url": "https://printify.com/...",
  "variants_created": 12,
  "status": "draft"
}
```

---

### publish_to_etsy

Publishes a Printify product to Etsy.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `printify_product_id` | string | ✅ | - | Printify product ID |
| `shop_section_id` | string | ❌ | - | Etsy shop section |
| `publish_immediately` | boolean | ❌ | true | Publish now or save draft |
| `notify_user` | boolean | ❌ | true | Send Slack notification |

**Returns:**

```json
{
  "etsy_listing_id": "1234567890",
  "listing_url": "https://etsy.com/listing/...",
  "status": "active",
  "published_at": "2024-12-14T12:00:00Z"
}
```

---

### get_status

Retrieves status of designs, products, or queue items.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `entity_type` | string | ✅ | - | Type to query |
| `entity_id` | string | ❌ | - | Specific ID (omit for list) |
| `status_filter` | string | ❌ | "all" | Filter by status |
| `limit` | integer | ❌ | 10 | Max items to return |
| `include_details` | boolean | ❌ | false | Include full details |

**Entity Types:**

- `design`
- `product`
- `mockup`
- `queue`
- `all`

**Returns:**

```json
{
  "entity_type": "design",
  "items": [
    {
      "id": "rec123",
      "status": "approved",
      "created_at": "2024-12-14T10:00:00Z"
    }
  ],
  "total": 1,
  "summary": {
    "pending": 2,
    "approved": 5,
    "rejected": 1
  }
}
```

---

### manage_airtable

Performs CRUD operations on Airtable.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `operation` | string | ✅ | - | Operation type |
| `table` | string | ✅ | - | Table name |
| `record_id` | string | ❌ | - | Record ID (for read/update/delete) |
| `data` | object | ❌ | - | Record data |
| `filter` | string | ❌ | - | Airtable formula filter |
| `sort` | array | ❌ | - | Sort configuration |

**Operations:**

- `create`
- `read`
- `update`
- `delete`
- `search`

**Tables:**

- `designs`
- `products`
- `mockups`
- `copy`
- `queue`
- `settings`
- `logs`
- `analytics`

---

### handle_error

Handles errors with retry logic.

**Parameters:**

| Parameter | Type | Required | Default | Description |
|-----------|------|----------|---------|-------------|
| `error_type` | string | ✅ | - | Error category |
| `error_message` | string | ✅ | - | Error details |
| `source` | string | ✅ | - | Component where error occurred |
| `context` | object | ❌ | {} | Additional context |
| `retry_count` | integer | ❌ | 0 | Current retry attempt |
| `auto_retry` | boolean | ❌ | true | Automatically retry |
| `notify_user` | boolean | ❌ | false | Send notification |

**Error Types:**

- `api_error`
- `rate_limit`
- `validation_error`
- `timeout`
- `unknown`

---

## External APIs

### Printify API

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/v1/shops.json` | GET | List shops |
| `/v1/shops/{id}/products.json` | POST | Create product |
| `/v1/shops/{id}/products/{id}/publish.json` | POST | Publish to marketplace |
| `/v1/uploads/images.json` | POST | Upload image |
| `/v1/catalog/blueprints.json` | GET | List blueprints |

### NanoBanana API (Gemini)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/v1beta/models/gemini-2.0-flash-exp:generateContent` | POST | Generate image |

### Anthropic API (Claude)

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/v1/messages` | POST | Chat completion |

---

## Webhooks

### Slack Webhooks

| Path | Description |
|------|-------------|
| `/webhook/slack-commands` | Slash command handler |
| `/webhook/slack-interactive` | Button/action handler |

### n8n Webhooks

| Path | Description |
|------|-------------|
| `/webhook/generate-design` | Design generation trigger |
| `/webhook/ai-agent` | AI agent endpoint |
| `/webhook/printify-create` | Printify product creation |

---

## Error Codes

| Code | Description | Resolution |
|------|-------------|------------|
| `E001` | Invalid API key | Check credentials |
| `E002` | Rate limit exceeded | Wait and retry |
| `E003` | Invalid design ID | Verify ID exists |
| `E004` | Generation failed | Retry with different prompt |
| `E005` | Printify error | Check product configuration |
| `E006` | Etsy publishing failed | Verify shop connection |
| `E007` | Airtable error | Check table/field names |
| `E008` | Slack error | Verify bot permissions |

---

*Last Updated: December 2024*
