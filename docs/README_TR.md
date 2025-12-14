<p align="center">
  <img src="../assets/images/logo.png" width="400" alt="POD Automation System">
</p>

<p align="center">
  <strong>🚀 AI Destekli Print-on-Demand Otomasyon Framework'ü</strong>
</p>

<p align="center">
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/stargazers">
    <img src="https://img.shields.io/github/stars/verseaiagents-dev/pod-automation-system?style=flat-square&logo=github&color=yellow" alt="Stars">
  </a>
  <a href="https://github.com/verseaiagents-dev/pod-automation-system/blob/main/LICENSE">
    <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/Version-1.0.0-green.svg?style=flat-square" alt="Version">
  </a>
</p>

<p align="center">
  <a href="../README.md">English</a> | <b>Türkçe</b>
</p>

<p align="center">
  <a href="#-genel-bakış">Genel Bakış</a> •
  <a href="#-mimari">Mimari</a> •
  <a href="#-özellikler">Özellikler</a> •
  <a href="#-başlangıç">Başlangıç</a> •
  <a href="#-dokümantasyon">Dokümantasyon</a>
</p>

---

## 📌 Genel Bakış

**POD Automation System**, Print-on-Demand işletmeleri için uçtan uca AI destekli otomasyon framework'üdür. Basit metin komutlarını akıllı iş akışı düzenlemesi ile tam yayınlanmış marketplace ürünlerine dönüştürür.

**n8n** iş akışı motoru üzerine kurulu ve AI beyni olarak **Claude 3.5 Sonnet** kullanan sistem, tasarım oluşturmadan Etsy yayınlamaya kadar her şeyi - Slack'teki doğal dil komutlarıyla kontrol edilebilir şekilde - yönetir.

```
Sen: /generate soyut okyanus dalgaları, mavi palet

🤖 POD Agent:
   ✅ Tasarım oluşturuldu (Kalite: 8.5/10)
   ✅ Mockup'lar hazırlandı (3 ürün)
   ✅ SEO içerik yazıldı (13 etiket)
   ✅ Etsy'de yayınlandı

📦 Sonuç: ~30 dakikada canlı ilan
```

---

## ✨ Son Güncellemeler

- 🎨 **v1.0.0** - Tam otomasyon pipeline'ı ile ilk sürüm
- 🤖 **AI Agent** - 9 özel araçla Claude 3.5 Sonnet entegrasyonu
- 🖼️ **Tasarım Üretimi** - NanoBanana (Gemini) & DALL-E 3 desteği
- 📊 **Airtable Entegrasyonu** - Tam takip için 8 bağlantılı tablo
- 🔄 **n8n Workflow'ları** - 4 production-ready iş akışı şablonu
- 📝 **Akıllı İçerik Yazımı** - SEO optimize başlık, açıklama ve Etsy etiketleri

---

## 🏗️ Mimari

```
┌─────────────────────────────────────────────────────────────────────────┐
│                            SLACK ARAYÜZÜ                                 │
│    /generate    /status    /approve    /publish    /mockup    /help     │
└────────────────────────────────┬────────────────────────────────────────┘
                                 │
                                 ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                         n8n WORKFLOW MOTORU                              │
│  ┌───────────────────────────────────────────────────────────────────┐  │
│  │                   CLAUDE 3.5 SONNET AI AGENT                       │  │
│  │                                                                    │  │
│  │   ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐            │  │
│  │   │ Tasarım  │ │ Mockup   │ │ İçerik   │ │ Ürün     │            │  │
│  │   │ Aracı    │ │ Aracı    │ │ Aracı    │ │ Aracı    │            │  │
│  │   └──────────┘ └──────────┘ └──────────┘ └──────────┘            │  │
│  └───────────────────────────────────────────────────────────────────┘  │
└────────────────────────────────┬────────────────────────────────────────┘
                                 │
           ┌─────────────────────┼─────────────────────┐
           ▼                     ▼                     ▼
   ┌───────────────┐     ┌───────────────┐     ┌───────────────┐
   │   AIRTABLE    │     │  AI SERVİSLER │     │   POD API'ler │
   │   Veritabanı  │     │               │     │               │
   │               │     │ • Claude 3.5  │     │ • Printify    │
   │ • Tasarımlar  │     │ • NanoBanana  │     │ • Etsy        │
   │ • Ürünler     │     │ • DALL-E 3    │     │               │
   │ • Mockup'lar  │     │               │     │               │
   │ • İçerikler   │     │               │     │               │
   │ • Kuyruk      │     │               │     │               │
   │ • Analitik    │     │               │     │               │
   └───────────────┘     └───────────────┘     └───────────────┘
```

---

## 🎯 Özellikler

| Özellik | Açıklama |
|---------|----------|
| 🎨 **AI Tasarım Üretimi** | NanoBanana veya DALL-E 3 ile metin komutlarından benzersiz sanat eserleri oluşturma |
| 🔍 **Akıllı Kalite Kontrol** | Düşük kaliteli çıktılar için otomatik yeniden deneme ile AI destekli değerlendirme |
| 👕 **Otomatik Mockup'lar** | 8+ ürün tipinde profesyonel mockup oluşturma |
| ✍️ **SEO İçerik Yazımı** | AI ile başlık, açıklama ve tam 13 Etsy etiketi |
| 🚀 **Tek Tıkla Yayınlama** | Doğrudan Printify ve Etsy entegrasyonu |
| 💬 **Konuşma Arayüzü** | Slack'te doğal dil komutları |
| 📊 **Tam Takip** | Airtable'da 8 bağlantılı tablo ile denetim izi |

---

## 📋 Kullanım Senaryoları

| Senaryo | Uygulamalar | Temel Değer |
|---------|-------------|-------------|
| **Solo Girişimci** | Kendi mağazasını yöneten bireysel satıcılar | İş akışının %80'ini otomatikleştirme |
| **Tasarım Ajansı** | Birden fazla müşteri için ürün oluşturan ekipler | Kadro artırmadan ölçeklendirme |
| **Dropshipping** | Yüksek hacimli satıcılar | Tutarlı kalitede hızlı listeleme |
| **İçerik Üretici** | Merchandise satan YouTuber/influencer'lar | Dakikalar içinde fikirden ürüne |
| **E-ticaret Markası** | Ürün yelpazesini genişleten markalar | Hızlı ve ucuz tasarım testi |

---

## 🚀 Başlangıç

### Gereksinimler

| Gereksinim | Versiyon | Amaç |
|------------|----------|------|
| n8n | 1.x+ | İş akışı otomasyon motoru |
| Docker | Latest | Container deployment |
| Slack Workspace | - | Komut arayüzü |
| Airtable Hesabı | - | Veritabanı |

### ① Repo'yu Klonla

```bash
git clone https://github.com/verseaiagents-dev/pod-automation-system.git
cd pod-automation-system
```

### ② Environment'ı Yapılandır

```bash
cp .env.example .env
nano .env  # API key'lerinizi ekleyin
```

### ③ n8n'i Başlat

```bash
docker run -it --rm \
  --name n8n \
  -p 5678:5678 \
  -v ~/.n8n:/home/node/.n8n \
  n8nio/n8n
```

### ④ Workflow'ları İçe Aktar

1. n8n'i `http://localhost:5678` adresinde aç
2. **Workflows** → **Import from File**
3. `n8n-workflows/` klasöründeki JSON dosyalarını içe aktar

### ⑤ Kurulumu Doğrula

```bash
./scripts/test.sh
```

---

## 💬 Slack Komutları

| Komut | Açıklama | Örnek |
|-------|----------|-------|
| `/generate` | Yeni tasarım oluştur | `/generate gün batımı dağlar, sıcak renkler` |
| `/status` | Durum kontrolü | `/status design-123` |
| `/approve` | Tasarımı onayla | `/approve design-123` |
| `/reject` | Geri bildirimle reddet | `/reject design-123 "çok karmaşık"` |
| `/mockup` | Mockup oluştur | `/mockup design-123 tshirt,mug` |
| `/publish` | Etsy'de yayınla | `/publish product-456` |

---

## 💰 Maliyet Tahmini

| Servis | Birim | 100 Ürün Başına |
|--------|-------|-----------------|
| Claude API | ~$0.003/1K token | ~$1.50 |
| NanoBanana | ~$0.02/görsel | ~$2.00 |
| Mockup API | ~$0.10/mockup | ~$30.00 |
| **Toplam** | | **~$33-36** |

---

## 📚 Dokümantasyon

- [Proje Planı](PROJECT_PLAN.md) - Kapsamlı uygulama rehberi
- [API Referansı](API_REFERENCE.md) - Araç ve endpoint dokümantasyonu
- [Katkı Rehberi](../CONTRIBUTING.md) - Nasıl katkıda bulunulur
- [Değişiklik Günlüğü](../CHANGELOG.md) - Versiyon geçmişi

---

## 📜 Lisans

Bu proje **MIT Lisansı** altında lisanslanmıştır - detaylar için [LICENSE](../LICENSE) dosyasına bakın.

---

<p align="center">
  ❤️ ile <a href="https://github.com/verseaiagents-dev">VerseAI Agents</a> tarafından yapıldı
</p>

<p align="center">
  <sub>Claude Code kullanılarak AI yardımıyla oluşturuldu</sub>
</p>
