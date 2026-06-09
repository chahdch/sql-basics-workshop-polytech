ETAPE 7 : 

EXPLAIN ANALYZE
SELECT s.pseudo, COUNT(pd.id_defi) as nb_defis
FROM streamer s
LEFT JOIN participation_defi pd ON s.id_streamer = pd.id_streamer
WHERE s.pseudo LIKE '%pseudo%1%'
GROUP BY s.id_streamer, s.pseudo;
