-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX3.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 3 : Requêtes de jointure simples


SELECT 
    s.pseudo,
    c.date_debut_autorisee,
    c.date_fin_autorisee
FROM Streamer s
JOIN Creneau c ON s.id_streamer = c.id_streamer
ORDER BY s.pseudo, c.date_debut_autorisee;
   



SELECT 
    st.titre,
    s.pseudo,
    c.date_debut_autorisee,
    c.date_fin_autorisee
FROM Stream st
JOIN Streamer s ON st.id_streamer = s.id_streamer
JOIN Creneau c ON st.id_creneau = c.id_creneau
WHERE DATE(c.date_debut_autorisee) IN ('2025-09-05', '2025-09-06')
   OR DATE(c.date_fin_autorisee) IN ('2025-09-05', '2025-09-06')
ORDER BY c.date_debut_autorisee;





SELECT d.intitule, s.pseudo, d.montant_palier
FROM participation_defi p
JOIN Streamer s ON p.id_streamer = s.id_streamer
JOIN defi d ON p.id_defi = d.id_defi
ORDER BY s.pseudo;



PHASE 2 :
