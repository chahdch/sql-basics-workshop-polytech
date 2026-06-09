-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX2.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 2 :   Requêtes SELECT simples et filtrées


SELECT s.id_streamer, s.pseudo, s.url_twitch
FROM Streamer s;



SELECT *
FROM Creneau
WHERE DATE(date_debut_autorisee) = '2025-09-06'
   OR DATE(date_fin_autorisee) = '2025-09-06';


SELECT d.montant_palier
FROM defi d
WHERE d.montant_palier > 5000;



SELECT s.id_stream
FROM stream s
WHERE s.date_fin_effective IS NULL;
