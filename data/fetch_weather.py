"""
takim_sehir_koordinat.csv icindeki her benzersiz sehir icin Open-Meteo'dan gunluk hava verisi ceker
ve hava_gunluk.csv dosyasina yazar.

Kullanim:
    pip install requests
    python fetch_weather.py
"""
import csv
import time

import requests

START_DATE = "2008-08-01"
END_DATE = "2016-05-31"
URL = "https://archive-api.open-meteo.com/v1/archive"
DAILY = [
    "temperature_2m_mean",
    "precipitation_sum",
    "wind_speed_10m_max",
    "wind_gusts_10m_max",
]

# 1) Benzersiz sehirleri oku (Rotterdam 3 takimda tekrar eder, bir kez cekilir)
cities = {}
with open("takim_sehir_koordinat.csv", newline="", encoding="utf-8") as f:
    for row in csv.DictReader(f):
        cities[row["city"]] = (float(row["latitude"]), float(row["longitude"]))

print(f"{len(cities)} sehir icin veri cekilecek")

# 2) Her sehir icin API'ye istek at
rows = []
for city, (lat, lon) in cities.items():
    params = {
        "latitude": lat,
        "longitude": lon,
        "start_date": START_DATE,
        "end_date": END_DATE,
        "daily": ",".join(DAILY),
        "timezone": "Europe/Amsterdam",
    }
    for attempt in range(5):
        resp = requests.get(URL, params=params, timeout=60)
        if resp.status_code == 200:
            break
        wait = 10 * (attempt + 1)
        print(f"  {city}: HTTP {resp.status_code}, {wait} sn bekleniyor...")
        time.sleep(wait)
    else:
        raise SystemExit(f"{city} icin veri alinamadi, daha sonra tekrar dene")

    d = resp.json()["daily"]
    for i, day in enumerate(d["time"]):
        rows.append([
            city,
            day,
            d["temperature_2m_mean"][i],
            d["precipitation_sum"][i],
            d["wind_speed_10m_max"][i],
            d["wind_gusts_10m_max"][i],
        ])
    print(f"  {city}: {len(d['time'])} gun")
    time.sleep(2) 

# 3) CSV'ye yaz
with open("hava_gunluk.csv", "w", newline="", encoding="utf-8") as f:
    w = csv.writer(f)
    w.writerow(["city", "date", "temp_mean_c", "precip_mm", "wind_max_kmh", "gust_max_kmh"])
    w.writerows(rows)

print(f"Bitti: {len(rows)} satir -> hava_gunluk.csv")
