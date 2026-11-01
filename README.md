# yagmur-ve-gol-eredivisie
Hollanda ligi maçları ve günlük hava verisiyle yağmurun gol sayısına etkisi (SQL, Python, Power BI)

# Yağmur Gol Sayısını Değiştirir mi? Hollanda Ligi (Eredivisie) ve Hava Durumu

> **English summary:** Exploratory SQL analysis joining Dutch Eredivisie matches (2,448 matches, 2008/09–2015/16) with daily weather data collected from the Open-Meteo API with Python. Days with 5 mm or more rain have about 0.3 more goals per match; home win rate is unaffected.


> **Not:** Dashboard görseli (`dashboard/dashboard.png`) eklenecek.

## Proje Ne Hakkında?

Hollanda liginde oynanan maçların verisini günlük hava durumu verisiyle birleştirip basit bir soruyu test ettim: **yağmurlu, rüzgârlı ya da soğuk günlerde gol sayısı ve ev sahibi avantajı değişiyor mu?**

## Ne Yaptım?

1. **Maç verisi:** Kaggle'daki European Soccer Database'den Hollanda liginin 8 sezonunu (2008/09–2015/16, 2.448 maç) aldım.
2. **Hava verisi:** Maç verisinde hava bilgisi olmadığı için, Python ile Open-Meteo API'sinden 23 şehrin günlük yağış, rüzgâr ve sıcaklık verisini çektim.
3. **Birleştirme:** Ev sahibi takımın şehri doğrudan maçın konumu gibi düşünüp, SQL'de maç, takım, şehir ve hava tablolarını tarih ve şehir üzerinden birleştirdim.
4. **Analiz:** Yağışa göre gol ortalamalarını karşılaştırdım. Sonucun mevsimden, takımdan ya da rüzgârdan gelip gelmediğini ayrı ayrı kontrol ettim.
5. **Görselleştirme:** Sonuçlar için Power BI üzerinden dashboard hazırlanacaktır.

## Neleri İnceledim?

- Yağış miktarına göre maç başına gol ve ev sahibi galibiyet oranı
- Aynı ay içinde kuru ve yağışlı günlerin karşılaştırması (mevsim etkisi kontrolü)
- Aynı takımın evindeki kuru ve yağışlı maçları (takım etkisi kontrolü)
- Yağış arttıkça gol sayısının kademeli artıp artmadığı
- Rüzgâr ve sıcaklığın etkisi

## Bulgular

1. **Günlük yağışı 5 mm ve üzeri olan günlerde maç başına yaklaşık 0,3 gol daha fazla atılıyor** (kuru günlerde 3,03, şiddetli yağışlı günlerde yaklaşık 3,3). Hafif yağmurda fark yok. Fark, ay ve takım etkisi kontrol edilince de aynı kaldı.
2. **Ev sahibi avantajı yağıştan etkilenmiyor.** Ev sahibi galibiyet oranı kuru ve yağışlı günlerde yaklaşık %48.
3. **Rüzgâr gol sayısını etkilemiyor.** Soğuk günlerde daha az gol atılıyor, ama sıcaklık mevsimle iç içe olduğu için ayrı bir etki sayılmaz.

**Öneri:** Gol tahmin modeline "şiddetli yağış" göstergesi eklenebilir. Etki küçük ve analiz keşifsel olduğu için, kullanmadan önce sonraki sezonlarda doğrulanmalı.

**Sınırlamalar:** Nedensellik değil ilişki bulundu. Hava günlük değer (maç anının havası değil) ve şehir bazlı. Tek lig, 8 sezon ve şiddetli yağışlı maç sayısı küçük (352), bu yüzden sonuçlar kesin değil, ipucu niteliğinde.

## Araçlar ve Veri Kaynakları

- **Araçlar:** SQL (SQLite, DB Browser), Python (yalnızca veri toplama), Power BI
- **Maçlar:** [European Soccer Database (Kaggle)](https://www.kaggle.com/datasets/hugomathien/soccer)
- **Hava durumu:** [Open-Meteo](https://open-meteo.com/) (Open-Meteo.com'dan alınmıştır)

## Depo Yapısı

```
├── README.md
├── data/          # hava verisini toplayan betik ve veri dosyaları
├── sorgular/      # her analiz için SQL dosyası ve CSV sonucu
└── dashboard/
```

## Nasıl Çalıştırılır?

1. Kaggle'dan `database.sqlite` dosyasını indirip DB Browser for SQLite ile açın.
2. `veri/takim_sehir_koordinat.csv` dosyasını `team_city`, `veri/hava_gunluk.csv` dosyasını `weather_daily` adlı tablo olarak içe aktarın.
3. `sorgular/00_mac_hava_gorunum_olusturma_sorgusu.sql` dosyasını, ardından diğer sorguları sırayla çalıştırın.
