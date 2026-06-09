-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX6.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 6: 

1.
SELECT s.pseudo , COUNT(p.id_defi)
FROM participation_defi p 
JOIN Streamer s ON s.id_streamer = p.id_streamer
GROUP BY s.id_streamer, s.pseudo;


2.
SELECT
    d.intitule,
    d.montant_palier
FROM Defi d
LEFT JOIN Participation_Defi pd
    ON d.id_defi = pd.id_defi
WHERE pd.id_defi IS NULL;


3.
SELECT
    d.intitule,
    d.montant_palier,
	COALESCE(COUNT(p.id_streamer),0) AS nbr_participants
FROM Defi d
LEFT JOIN Participation_Defi p
    ON d.id_defi = p.id_defi
GROUP BY   d.intitule, d.montant_palier, d.id_defi
HAVING COUNT(p.id_streamer) > 2; 


4.
SELECT
    s.pseudo,
    COUNT(pd.id_defi) AS nombre_defis,
    SUM(d.montant_palier) AS montant_total_engage
FROM Streamer s
LEFT JOIN Participation_Defi pd
    ON s.id_streamer = pd.id_streamer
LEFT JOIN Defi d
    ON pd.id_defi = d.id_defi
GROUP BY s.id_streamer, s.pseudo
ORDER BY montant_total_engage DESC;



5.
SELECT
    s.pseudo,
    c.date_debut_autorisee,
    c.date_fin_autorisee,
    COUNT(st.id_stream) AS nombre_streams
FROM Streamer s
JOIN Creneau c
    ON s.id_streamer = c.id_streamer
LEFT JOIN Stream st
    ON s.id_streamer = st.id_streamer
    AND c.id_creneau = st.id_creneau
GROUP BY
    s.id_streamer,
    s.pseudo,
    c.id_creneau,
    c.date_debut_autorisee,
    c.date_fin_autorisee
ORDER BY s.pseudo, c.date_debut_autorisee;
