SELECT CASE WHEN precip_mm = 0 THEN '1: 0 mm'
            WHEN precip_mm < 2 THEN '2: 0-2 mm'
            WHEN precip_mm < 5 THEN '3: 2-5 mm'
            WHEN precip_mm < 10 THEN '4: 5-10 mm'
            ELSE '5: 10+ mm' END AS yagis_grubu,
       COUNT(*) AS mac,
       ROUND(AVG(toplam_gol), 2) AS ort_gol
FROM match_weather
GROUP BY yagis_grubu
ORDER BY yagis_grubu;