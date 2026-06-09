-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX4.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 4 : 

1.
SELECT  s.pseudo, COALESCE(COUNT(st.id_stream), 0) AS sttream_count
FROM Streamer s
JOIN Stream st ON st.id_streamer = s.id_streamer
GROUP BY s.pseudo

2.
SELECT 
    d.intitule,
    SUM(d.montant_palier) AS total_paliers_valides
FROM defi d
WHERE d.etat_validation = TRUE
GROUP BY d.intitule;

3. 
SELECT
    s.pseudo,
    COUNT(p.id_defi) AS nombre_defis
FROM Streamer s
JOIN Participation_Defi p
    ON s.id_streamer = p.id_streamer
GROUP BY s.id_streamer, s.pseudo
HAVING COUNT(p.id_defi) >= 2;


4.
SELECT
    s.titre, 
	EXTRACT(EPOCH FROM (s.heure_fin - s.heure_debut)) / 3600 AS duree_total,
	AVG(EXTRACT(EPOCH FROM (s.heure_fin - s.heure_debut)) / 3600) OVER() AS duree_moyenne
FROM Stream s



5. 
SELECT DISTINCT 
    s.pseudo,
	st.titre, 
	st.heure_debut
FROM Stream st
INNER JOIN Streamer s ON s.id_streamer = st.id_streamer
