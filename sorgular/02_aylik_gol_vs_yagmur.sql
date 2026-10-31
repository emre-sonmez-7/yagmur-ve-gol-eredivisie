SELECT ay,
       COUNT(*) AS mac,
       ROUND(AVG(toplam_gol), 2) AS ort_gol,
       ROUND(AVG(precip_mm), 2) AS ort_yagis_mm
FROM match_weather
GROUP BY ay
ORDER BY CASE WHEN ay >= 8 THEN ay - 8 ELSE ay + 4 END;