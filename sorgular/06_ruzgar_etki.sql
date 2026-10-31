SELECT CASE WHEN wind_max_kmh < 15 THEN '1: <15 km/h'
            WHEN wind_max_kmh < 25 THEN '2: 15-25 km/h'
            WHEN wind_max_kmh < 35 THEN '3: 25-35 km/h'
            ELSE '4: 35+ km/h' END AS ruzgar_grubu,
       COUNT(*) AS mac,
       ROUND(AVG(toplam_gol), 2) AS ort_gol,
       ROUND(100.0 * AVG(ev_galibiyet), 1) AS ev_galibiyet_yuzde
FROM match_weather
GROUP BY ruzgar_grubu
ORDER BY ruzgar_grubu;