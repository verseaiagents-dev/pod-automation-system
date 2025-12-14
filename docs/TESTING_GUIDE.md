# Testing Guide - POD Automation System

Bu rehber, POD Automation System'i yerel ortamınızda test etmeniz için adım adım talimatlar içerir.

---

## 📋 İçindekiler

1. [Gereksinimler](#1-gereksinimler)
2. [n8n Kurulumu](#2-n8n-kurulumu)
3. [API Key'leri Alma](#3-api-keyleri-alma)
4. [Airtable Kurulumu](#4-airtable-kurulumu)
5. [Slack App Kurulumu](#5-slack-app-kurulumu)
6. [n8n Workflow Import](#6-n8n-workflow-import)
7. [Test Senaryoları](#7-test-senaryoları)
8. [Sorun Giderme](#8-sorun-giderme)

---

## 1. Gereksinimler

### Yazılım

| Yazılım | Minimum Versiyon | Kurulum |
|---------|-----------------|---------|
| Docker | 20.x+ | [docker.com](https://docker.com) |
| Git | 2.x+ | `brew install git` |
| curl | - | Genellikle yüklü |

### Hesaplar (Ücretsiz)

- [Anthropic Console](https://console.anthropic.com) - Claude API
- [Airtable](https://airtable.com) - Veritabanı
- [Slack](https://slack.com) - Workspace
- [Printify](https://printify.com) - POD (opsiyonel, test için)

---

## 2. n8n Kurulumu

### Option A: Docker (Önerilen)

```bash
# n8n'i başlat
docker run -d \
  --name n8n \
  -p 5678:5678 \
  -v n8n_data:/home/node/.n8n \
  -e GENERIC_TIMEZONE="Europe/Istanbul" \
  -e TZ="Europe/Istanbul" \
  n8nio/n8n

# Çalıştığını kontrol et
docker ps | grep n8n

# Logları izle
docker logs -f n8n
```

### Option B: npm

```bash
npm install -g n8n
n8n start
```

### Erişim

Tarayıcıda aç: **http://localhost:5678**

İlk açılışta:
1. Email ve şifre oluştur
2. "Get started" ile devam et

---

## 3. API Key'leri Alma

### 3.1 Anthropic (Claude) API Key

1. https://console.anthropic.com adresine git
2. Hesap oluştur veya giriş yap
3. **API Keys** → **Create Key**
4. Key'i kopyala: `sk-ant-api03-...`

**Maliyet:** İlk $5 ücretsiz kredi

### 3.2 Airtable API Key

1. https://airtable.com/create/tokens adresine git
2. **Create new token**
3. İsim ver: "POD Automation"
4. Scopes ekle:
   - `data.records:read`
   - `data.records:write`
   - `schema.bases:read`
5. Access: "All current and future bases"
6. **Create token** → Kopyala: `pat...`

### 3.3 Slack Bot Token

1. https://api.slack.com/apps adresine git
2. **Create New App** → **From scratch**
3. App Name: "POD Agent"
4. Workspace seç
5. Sol menü → **OAuth & Permissions**
6. **Bot Token Scopes** ekle:
   - `chat:write`
   - `commands`
   - `channels:history`
   - `users:read`
7. **Install to Workspace**
8. **Bot User OAuth Token** kopyala: `xoxb-...`

### 3.4 Printify API Key (Opsiyonel)

1. https://printify.com → Giriş yap
2. **My Profile** → **Connections**
3. **API** → **Generate new token**
4. Token'ı kopyala

### 3.5 Design Generation (Birini Seç)

**Option A: Google AI (NanoBanana/Gemini)**
1. https://aistudio.google.com/apikey
2. **Create API Key**
3. Kopyala

**Option B: OpenAI (DALL-E)**
1. https://platform.openai.com/api-keys
2. **Create new secret key**
3. Kopyala

---

## 4. Airtable Kurulumu

### 4.1 Base Oluştur

1. https://airtable.com → **Add a base** → **Start from scratch**
2. İsim: "POD Automation"
3. Base ID'yi al: URL'den `app...` kısmını kopyala

### 4.2 Tabloları Oluştur

Her tablo için aşağıdaki alanları ekle:

#### Table 1: Designs
```
- design_id (Autonumber)
- prompt (Long text)
- enhanced_prompt (Long text)
- image_url (URL)
- status (Single select: pending, generating, ready, approved, rejected)
- quality_score (Number)
- created_at (Created time)
```

#### Table 2: Products
```
- product_id (Autonumber)
- design_id (Link to Designs)
- title (Single line text)
- description (Long text)
- status (Single select: draft, published)
- printify_id (Single line text)
- created_at (Created time)
```

#### Table 3: Queue
```
- queue_id (Autonumber)
- task_type (Single select: design, mockup, copy, publish)
- status (Single select: queued, processing, completed, failed)
- payload (Long text)
- created_at (Created time)
```

> **Kısayol:** Projedeki CSV dosyalarını import edebilirsin:
> `airtable-schemas/*.csv`

---

## 5. Slack App Kurulumu

### 5.1 Slash Commands Ekle

1. Slack App sayfasında → **Slash Commands**
2. **Create New Command**

| Command | Request URL | Description |
|---------|-------------|-------------|
| `/generate` | `http://YOUR_N8N_URL/webhook/slack-commands` | Create new design |
| `/status` | `http://YOUR_N8N_URL/webhook/slack-commands` | Check status |
| `/approve` | `http://YOUR_N8N_URL/webhook/slack-commands` | Approve design |
| `/help` | `http://YOUR_N8N_URL/webhook/slack-commands` | Show help |

### 5.2 Event Subscriptions (Opsiyonel)

1. **Event Subscriptions** → Enable
2. Request URL: `http://YOUR_N8N_URL/webhook/slack-events`
3. **Subscribe to bot events**:
   - `message.channels`
   - `app_mention`

### 5.3 Interactivity

1. **Interactivity & Shortcuts** → Enable
2. Request URL: `http://YOUR_N8N_URL/webhook/slack-interactive`

---

## 6. n8n Workflow Import

### 6.1 Credentials Ekle

n8n'de **Settings** → **Credentials**:

#### Anthropic API
```
- Name: Anthropic API
- API Key: sk-ant-api03-...
```

#### Airtable
```
- Name: Airtable Token
- API Key: pat...
```

#### Slack
```
- Name: Slack API
- Access Token: xoxb-...
```

### 6.2 Workflow'ları Import Et

1. **Workflows** → **Import from File**
2. `n8n-workflows/` klasöründen sırayla import et:
   - `01-slack-handler.json`
   - `02-ai-agent.json`
   - `03-design-generation.json`
   - `04-printify-integration.json`

### 6.3 Workflow'ları Aktifleştir

1. Her workflow'u aç
2. Credentials'ları bağla (node'lara tıkla)
3. Sağ üstten **Active** toggle'ını aç
4. **Save**

---

## 7. Test Senaryoları

### Test 1: Webhook Bağlantısı

```bash
# Slack webhook'u test et
curl -X POST http://localhost:5678/webhook/slack-commands \
  -H "Content-Type: application/json" \
  -d '{"command": "/help", "user_id": "U123", "channel_id": "C123"}'
```

Beklenen yanıt: `200 OK` ve JSON response

### Test 2: Design Generation (Basit)

```bash
# Design generation endpoint'i test et
curl -X POST http://localhost:5678/webhook/generate-design \
  -H "Content-Type: application/json" \
  -d '{
    "prompt": "abstract ocean waves",
    "style": "modern",
    "userId": "test-user",
    "channelId": "test-channel"
  }'
```

### Test 3: AI Agent

```bash
# AI Agent'ı test et
curl -X POST http://localhost:5678/webhook/ai-agent \
  -H "Content-Type: application/json" \
  -d '{
    "message": "Generate a design with sunset colors",
    "userId": "test-user"
  }'
```

### Test 4: Slack'ten Test

1. Slack'te herhangi bir kanala git
2. `/generate abstract mountain landscape` yaz
3. Bot'un yanıt vermesini bekle

### Test 5: Tam Pipeline

```bash
# 1. Design oluştur
/generate minimalist coffee cup design

# 2. Durumu kontrol et
/status

# 3. Onayla (design_id ile)
/approve design-1

# 4. Yayınla
/publish product-1
```

---

## 8. Sorun Giderme

### n8n Başlamıyor

```bash
# Container'ı yeniden başlat
docker restart n8n

# Logları kontrol et
docker logs n8n --tail 100
```

### Webhook 404 Hatası

1. Workflow'un aktif olduğundan emin ol
2. Webhook URL'ini kontrol et
3. n8n'i yeniden başlat

### Slack Yanıt Vermiyor

1. Bot'un kanala eklendiğinden emin ol
2. Request URL'inin doğru olduğunu kontrol et
3. Slack App'in workspace'e kurulu olduğunu doğrula

### API Key Hataları

```bash
# Test script'ini çalıştır
./scripts/test.sh
```

### Airtable Bağlantı Hatası

1. Base ID'nin doğru olduğunu kontrol et
2. Token scope'larını doğrula
3. Tablo isimlerinin eşleştiğini kontrol et

---

## 🚀 Hızlı Test Komutları

```bash
# Tüm servisleri test et
cd ~/projects/pod-automation-system
./scripts/test.sh

# n8n'in çalıştığını kontrol et
curl http://localhost:5678/healthz

# Webhook'u test et
curl -X POST http://localhost:5678/webhook/slack-commands \
  -d "command=/help&user_id=U123"
```

---

## 📝 Test Checklist

- [ ] Docker kuruldu
- [ ] n8n çalışıyor (localhost:5678)
- [ ] Anthropic API key alındı
- [ ] Airtable base oluşturuldu
- [ ] Slack App kuruldu
- [ ] Credentials n8n'e eklendi
- [ ] Workflow'lar import edildi
- [ ] Workflow'lar aktif
- [ ] Webhook testi başarılı
- [ ] Slack komutu çalışıyor

---

*Son Güncelleme: Aralık 2024*
