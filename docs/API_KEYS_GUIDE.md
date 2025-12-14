# API Key'leri Alma Rehberi

Bu rehber, POD Automation System için gerekli tüm API key'lerini adım adım nasıl alacağınızı gösterir.

---

## 📋 Gerekli API Key'ler Özeti

| Servis | Zorunlu | Maliyet | Süre |
|--------|---------|---------|------|
| Anthropic (Claude) | ✅ Evet | İlk $5 ücretsiz | 5 dk |
| Airtable | ✅ Evet | Ücretsiz | 3 dk |
| Slack Bot | ✅ Evet | Ücretsiz | 10 dk |
| Google AI (Gemini) | ⚡ Birini seç | Ücretsiz | 2 dk |
| OpenAI (DALL-E) | ⚡ Birini seç | $5 minimum | 3 dk |
| Printify | ❌ Opsiyonel | Ücretsiz | 5 dk |

---

## 1. Anthropic API Key (Claude)

Claude 3.5 Sonnet, sistemin AI beynidir. Tüm doğal dil işleme ve karar verme işlemleri için kullanılır.

### Adım 1: Hesap Oluştur

1. **https://console.anthropic.com** adresine git
2. **Sign Up** butonuna tıkla
3. Email adresini gir
4. Şifre oluştur (min. 8 karakter)
5. Email doğrulama linkine tıkla

### Adım 2: API Key Oluştur

1. Giriş yaptıktan sonra sol menüden **API Keys** sekmesine git
2. **Create Key** butonuna tıkla
3. Key'e isim ver: `pod-automation`
4. **Create** butonuna tıkla
5. Gösterilen key'i hemen kopyala (bir daha gösterilmez!)

```
Key Format: sk-ant-api03-xxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### Adım 3: Kredi Kontrolü

1. Sol menüden **Billing** → **Credits** sekmesine git
2. Yeni hesaplarda $5 ücretsiz kredi olur
3. Kredi yoksa **Add Credits** ile ekleyebilirsin

### Fiyatlandırma

| Model | Input | Output |
|-------|-------|--------|
| Claude 3.5 Sonnet | $3 / 1M token | $15 / 1M token |
| Claude 3 Haiku | $0.25 / 1M token | $1.25 / 1M token |

> **İpucu:** 100 ürün oluşturmak yaklaşık $1-2 Claude maliyeti

### Doğrulama

```bash
curl https://api.anthropic.com/v1/messages \
  -H "x-api-key: YOUR_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-3-5-sonnet-20241022","max_tokens":10,"messages":[{"role":"user","content":"Hi"}]}'
```

---

## 2. Airtable API Token

Airtable, tüm verilerin saklandığı veritabanıdır.

### Adım 1: Hesap Oluştur

1. **https://airtable.com** adresine git
2. **Sign up for free** butonuna tıkla
3. Google hesabıyla veya email ile kayıt ol
4. Workspace oluştur

### Adım 2: Base Oluştur

1. **Add a base** → **Start from scratch**
2. İsim ver: `POD Automation`
3. URL'den Base ID'yi kopyala:
   ```
   https://airtable.com/appXXXXXXXXXXXXXX/...
                        ↑
                    Bu kısım Base ID
   ```

### Adım 3: Personal Access Token Oluştur

1. **https://airtable.com/create/tokens** adresine git
2. **Create new token** butonuna tıkla
3. Token ayarları:

| Ayar | Değer |
|------|-------|
| Name | `pod-automation-token` |
| Scopes | `data.records:read`, `data.records:write`, `schema.bases:read` |
| Access | Specific bases → `POD Automation` seç |

4. **Create token** butonuna tıkla
5. Token'ı kopyala:

```
Token Format: patXXXXXXXXXXXXXXXX.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

### Adım 4: Tabloları Oluştur

Base'e gir ve şu tabloları oluştur (veya CSV import et):

```
Tables:
├── Designs
├── Products
├── Mockups
├── Copy
├── Queue
├── Settings
├── Logs
└── Analytics
```

### Doğrulama

```bash
curl "https://api.airtable.com/v0/YOUR_BASE_ID/Designs" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

---

## 3. Slack Bot Token

Slack Bot, kullanıcı arayüzü olarak çalışır.

### Adım 1: Slack Workspace

1. Slack workspace'in yoksa: **https://slack.com/create**
2. Yeni workspace oluştur veya mevcut olanı kullan

### Adım 2: Slack App Oluştur

1. **https://api.slack.com/apps** adresine git
2. **Create New App** butonuna tıkla
3. **From scratch** seç
4. App ayarları:

| Ayar | Değer |
|------|-------|
| App Name | `POD Agent` |
| Workspace | Kendi workspace'ini seç |

5. **Create App** butonuna tıkla

### Adım 3: Bot Token Scopes Ekle

1. Sol menüden **OAuth & Permissions** sekmesine git
2. **Scopes** bölümüne scroll et
3. **Bot Token Scopes** altında **Add an OAuth Scope** tıkla
4. Şu scope'ları ekle:

| Scope | Açıklama |
|-------|----------|
| `chat:write` | Mesaj gönderme |
| `commands` | Slash komutları |
| `channels:history` | Kanal geçmişi okuma |
| `channels:read` | Kanal bilgisi okuma |
| `users:read` | Kullanıcı bilgisi okuma |
| `files:write` | Dosya yükleme (görsel için) |

### Adım 4: App'i Workspace'e Kur

1. Sayfanın üstüne scroll et
2. **Install to Workspace** butonuna tıkla
3. İzinleri onayla: **Allow**
4. **Bot User OAuth Token** kopyala:

```
Token Format: xoxb-XXXXXXXXXXXX-XXXXXXXXXXXX-XXXXXXXXXXXXXXXXXXXXXXXX
```

### Adım 5: Slash Commands Ekle

1. Sol menüden **Slash Commands** sekmesine git
2. **Create New Command** butonuna tıkla
3. Her komut için:

| Command | Request URL | Description |
|---------|-------------|-------------|
| `/generate` | `https://YOUR_N8N_URL/webhook/slack-commands` | Create a new AI design |
| `/status` | `https://YOUR_N8N_URL/webhook/slack-commands` | Check workflow status |
| `/approve` | `https://YOUR_N8N_URL/webhook/slack-commands` | Approve a design |
| `/reject` | `https://YOUR_N8N_URL/webhook/slack-commands` | Reject a design |
| `/publish` | `https://YOUR_N8N_URL/webhook/slack-commands` | Publish to Etsy |
| `/help` | `https://YOUR_N8N_URL/webhook/slack-commands` | Show help |

> **Not:** Request URL'i n8n çalıştıktan sonra güncelleyeceksin

### Adım 6: Interactivity Aktifleştir (Butonlar için)

1. Sol menüden **Interactivity & Shortcuts** sekmesine git
2. **Interactivity** toggle'ını **On** yap
3. Request URL: `https://YOUR_N8N_URL/webhook/slack-interactive`
4. **Save Changes**

### Adım 7: Bot'u Kanala Ekle

1. Slack'te herhangi bir kanala git
2. Kanal adına tıkla → **Integrations** → **Add apps**
3. **POD Agent** bul ve ekle

### Doğrulama

```bash
curl -X POST https://slack.com/api/auth.test \
  -H "Authorization: Bearer xoxb-YOUR-TOKEN"
```

---

## 4. Google AI (Gemini/NanoBanana) API Key

Gemini, tasarım oluşturmak için kullanılır. Ücretsiz ve hızlıdır.

### Adım 1: Google AI Studio

1. **https://aistudio.google.com** adresine git
2. Google hesabınla giriş yap

### Adım 2: API Key Oluştur

1. Sol menüden **Get API Key** sekmesine git
2. **Create API Key** butonuna tıkla
3. Proje seç veya yeni oluştur
4. Key'i kopyala:

```
Key Format: AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

### Fiyatlandırma

| Model | Görsel Üretimi |
|-------|----------------|
| Gemini 2.0 Flash | Ücretsiz (limitli) |
| Gemini 1.5 Pro | $0.00265 / görsel |

### Doğrulama

```bash
curl "https://generativelanguage.googleapis.com/v1beta/models?key=YOUR_API_KEY"
```

---

## 5. OpenAI API Key (Alternatif - DALL-E)

DALL-E 3, yüksek kaliteli tasarımlar için alternatif bir seçenektir.

### Adım 1: Hesap Oluştur

1. **https://platform.openai.com** adresine git
2. **Sign up** ile hesap oluştur
3. Telefon doğrulaması yap

### Adım 2: Kredi Ekle

1. Sol menüden **Settings** → **Billing**
2. **Add payment method** ile kart ekle
3. Minimum $5 kredi yükle

### Adım 3: API Key Oluştur

1. **https://platform.openai.com/api-keys** adresine git
2. **Create new secret key** butonuna tıkla
3. İsim ver: `pod-automation`
4. Key'i kopyala:

```
Key Format: sk-proj-XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

### Fiyatlandırma

| Model | Kalite | Fiyat |
|-------|--------|-------|
| DALL-E 3 | Standard 1024x1024 | $0.040 / görsel |
| DALL-E 3 | HD 1024x1024 | $0.080 / görsel |
| DALL-E 2 | 1024x1024 | $0.020 / görsel |

### Doğrulama

```bash
curl https://api.openai.com/v1/models \
  -H "Authorization: Bearer YOUR_API_KEY"
```

---

## 6. Printify API Key (Opsiyonel)

Printify, ürünleri oluşturmak ve Etsy'e yayınlamak için kullanılır.

### Adım 1: Hesap Oluştur

1. **https://printify.com** adresine git
2. **Start selling** veya **Sign up** butonuna tıkla
3. Email ile kayıt ol
4. Mağaza oluştur (Etsy bağlantısı opsiyonel)

### Adım 2: API Token Oluştur

1. Sağ üstten profil ikonuna tıkla
2. **My Profile** → **Connections**
3. **Personal Access Tokens** bölümüne git
4. **Generate new token** butonuna tıkla
5. Token'ı kopyala

```
Token Format: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.XXXXX...
```

### Adım 3: Shop ID'yi Bul

```bash
curl https://api.printify.com/v1/shops.json \
  -H "Authorization: Bearer YOUR_TOKEN"
```

Yanıttan `id` değerini al.

### Rate Limits

| Endpoint | Limit |
|----------|-------|
| Product Creation | 200 / 30 dakika |
| Image Upload | Sınırsız |
| General | 600 / dakika |

---

## 7. Tüm Key'leri .env Dosyasına Kaydet

```bash
cd ~/projects/pod-automation-system
cp .env.example .env
nano .env
```

Şu değerleri doldur:

```env
# ===========================================
# Anthropic (Claude) API - ZORUNLU
# ===========================================
ANTHROPIC_API_KEY=sk-ant-api03-XXXXXXXXXXXX

# ===========================================
# Airtable - ZORUNLU
# ===========================================
AIRTABLE_API_KEY=patXXXXXXXXXXXXXXXX.XXXXXXXX
AIRTABLE_BASE_ID=appXXXXXXXXXXXXXX

# ===========================================
# Slack - ZORUNLU
# ===========================================
SLACK_BOT_TOKEN=xoxb-XXXXXXXXXXXX-XXXXXXXXXXXX-XXXX
SLACK_SIGNING_SECRET=XXXXXXXXXXXXXXXX

# ===========================================
# Design Generation - BİRİNİ SEÇ
# ===========================================
# Option A: Google AI (Gemini) - ÜCRETSİZ
GOOGLE_AI_API_KEY=AIzaSyXXXXXXXXXXXXXXXXXXXX

# Option B: OpenAI (DALL-E) - ÜCRETLI
OPENAI_API_KEY=sk-proj-XXXXXXXXXXXXXXXXXXXX

# ===========================================
# Printify - OPSİYONEL
# ===========================================
PRINTIFY_API_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6...
PRINTIFY_SHOP_ID=1234567
```

---

## 8. Test Script'ini Çalıştır

```bash
./scripts/test.sh
```

Beklenen çıktı:

```
================================================
  POD Automation System - Connection Test
================================================

Testing Anthropic API... [PASS]
Testing Airtable API... [PASS]
Testing Slack API... [PASS]
Testing Google AI API... [PASS]
Testing n8n (localhost:5678)... [PASS]

================================================
  Test Summary
================================================
Passed: 5
Failed: 0

All tests passed!
```

---

## 🔐 Güvenlik İpuçları

1. **Asla** API key'lerini Git'e commit etme
2. `.env` dosyası `.gitignore`'da olmalı
3. Production'da environment variables kullan
4. Key'leri düzenli olarak rotate et (3-6 ayda bir)
5. Her servis için ayrı key kullan

---

## ❓ Sık Sorulan Sorular

### API key'im çalışmıyor?

1. Key'in başında/sonunda boşluk olmadığından emin ol
2. Key'in tam kopyalandığını kontrol et
3. Hesapta kredi/limit olduğunu doğrula

### Ücretsiz limitler nedir?

| Servis | Ücretsiz Limit |
|--------|----------------|
| Anthropic | $5 kredi (yeni hesap) |
| Google AI | 60 request/dakika |
| Airtable | 1000 kayıt / base |
| Slack | Sınırsız |

### Hangi tasarım API'sini seçmeliyim?

- **Google AI (Gemini):** Ücretsiz, hızlı, iyi kalite
- **OpenAI (DALL-E 3):** Ücretli, en iyi kalite

Başlangıç için **Google AI** önerilir.

---

*Son Güncelleme: Aralık 2024*
