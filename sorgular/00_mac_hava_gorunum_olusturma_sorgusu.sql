CREATE VIEW match_weather AS
SELECT m.id AS match_id,
       m.season,
       DATE(m.date) AS mac_tarihi,
       CAST(strftime('%m', m.date) AS INTEGER) AS ay,
       t.team_long_name AS ev_sahibi,
       tc.city AS sehir,
       m.home_team_goal AS ev_gol,
       m.away_team_goal AS dep_gol,
       m.home_team_goal + m.away_team_goal AS toplam_gol,
       CASE WHEN m.home_team_goal > m.away_team_goal THEN 1 ELSE 0 END AS ev_galibiyet,
       w.temp_mean_c,
       w.precip_mm,
       w.wind_max_kmh,
       w.gust_max_kmh
FROM Match m
JOIN Country c ON c.id = m.country_id
JOIN Team t ON t.team_api_id = m.home_team_api_id
JOIN team_city tc ON tc.team_long_name = t.team_long_name
JOIN weather_daily w ON w.city = tc.city AND w.date = DATE(m.date)
WHERE c.name = 'Netherlands'