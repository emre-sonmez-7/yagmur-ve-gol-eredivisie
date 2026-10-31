SELECT CASE WHEN precip_mm = 0 THEN '1 Kuru (0 mm)'
            WHEN precip_mm < 5 THEN '2 Hafif (0-5 mm)'
            ELSE '3 Yagisli (5+ mm)' END AS yagis_grubu,
       COUNT(*) AS mac,
       ROUND(AVG(toplam_gol), 2) AS ort_gol,
       ROUND(100.0 * AVG(ev_galibiyet), 1) AS ev_galibiyet_yuzde
FROM match_weather
GROUP BY yagis_grubu
ORDER BY yagis_grubu;