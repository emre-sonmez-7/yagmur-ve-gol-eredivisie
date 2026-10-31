SELECT CASE WHEN temp_mean_c < 5 THEN '1: <5 C'
            WHEN temp_mean_c < 10 THEN '2: 5-10 C'
            WHEN temp_mean_c < 15 THEN '3: 10-15 C'
            ELSE '4: 15+ C' END AS sicaklik_grubu,
       COUNT(*) AS mac,
       ROUND(AVG(toplam_gol), 2) AS ort_gol,
       ROUND(100.0 * AVG(ev_galibiyet), 1) AS ev_galibiyet_yuzde
FROM match_weather
GROUP BY sicaklik_grubu
ORDER BY sicaklik_grubu;