-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX5.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 5 

1.
UPDATE Defi 
SET montant_palier = montant_palier + montant_palier * 0.10
WHERE intitule = 'Saut en parachute en live'


2.
UPDATE Defi
SET etat_validation = TRUE
WHERE etat_validation = FALSE
  AND id_defi IN (
      SELECT id_defi
      FROM Participation_Defi
      GROUP BY id_defi
      HAVING COUNT(id_streamer) >= 3
  );


3.
SELECT *
FROM Stream
WHERE date_fin_effective IS NULL;
DELETE FROM Stream
WHERE date_fin_effective IS NULL;


4.
SELECT *
FROM creneau
WHERE date_fin_autorisee < CURRENT_DATE;
DELETE FROM Creneau
WHERE date_fin_autorisee < CURRENT_DATE;


PHASE 3
