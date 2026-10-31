-- Q3: Within each month, do rainy days (5+ mm) have more goals than dry days (0 mm)?
-- Controls for seasonality seen in Q2.
SELECT ay,
       SUM(precip_mm = 0) AS kuru_mac,
       ROUND(AVG(CASE WHEN precip_mm = 0 THEN toplam_gol END), 2) AS kuru_ort_gol,
       SUM(precip_mm >= 5) AS yagisli_mac,
       ROUND(AVG(CASE WHEN precip_mm >= 5 THEN toplam_gol END), 2) AS yagisli_ort_gol
FROM match_weather
WHERE ay <> 7
GROUP BY ay
ORDER BY CASE WHEN ay >= 8 THEN ay - 8 ELSE ay + 4 END;