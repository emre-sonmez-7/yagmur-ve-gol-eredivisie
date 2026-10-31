--looking for team effect
SELECT ev_sahibi,
       SUM(precip_mm = 0) AS kuru_mac,
       ROUND(AVG(CASE WHEN precip_mm = 0 THEN toplam_gol END), 2) AS kuru_ort_gol,
       SUM(precip_mm >= 5) AS yagisli_mac,
       ROUND(AVG(CASE WHEN precip_mm >= 5 THEN toplam_gol END), 2) AS yagisli_ort_gol
FROM match_weather
GROUP BY ev_sahibi
HAVING COUNT(*) >= 68
ORDER BY ev_sahibi;