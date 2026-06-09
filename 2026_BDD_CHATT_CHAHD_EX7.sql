-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX7.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 7 : 

Partie A :

1.
SELECT
    st.titre,
    s.pseudo,
    c.date_debut_autorisee,
    c.date_fin_autorisee,
    st.heure_debut,
    st.heure_fin,
    CASE
        WHEN st.heure_debut >= c.date_debut_autorisee
         AND st.heure_fin <= c.date_fin_autorisee
        THEN 'VALIDE'
        ELSE 'INVALIDE'
    END AS statut_validation
FROM Stream st
JOIN Streamer s
    ON st.id_streamer = s.id_streamer
JOIN Creneau c
    ON st.id_creneau = c.id_creneau;


2.
SELECT
    st.titre,
    s.pseudo,
    c.date_debut_autorisee,
    c.date_fin_autorisee,
    st.heure_debut,
    st.heure_fin
FROM Stream st
JOIN Streamer s
    ON st.id_streamer = s.id_streamer
JOIN Creneau c
    ON st.id_creneau = c.id_creneau
WHERE NOT (
    st.heure_debut >= c.date_debut_autorisee
    AND st.heure_fin <= c.date_fin_autorisee
);


Partie B :

3.
SELECT
    st.titre,
    s.pseudo,
    st.heure_fin AS heure_fin_prevue,
    st.date_fin_effective,
    CASE
        WHEN st.date_fin_effective IS NULL THEN 'DEPASSEMENT'
        WHEN st.date_fin_effective <= st.heure_fin THEN 'OK'
        ELSE 'DEPASSEMENT'
    END AS statut,

    CASE
        WHEN st.date_fin_effective > st.heure_fin
        THEN EXTRACT(EPOCH FROM (st.date_fin_effective - st.heure_fin)) / 60
        ELSE 0
    END AS duree_depassement_minutes

FROM Stream st
JOIN Streamer s
    ON st.id_streamer = s.id_streamer;


4.
SELECT
    COUNT(*) AS nombre_streams_en_retard,
    AVG(
        EXTRACT(EPOCH FROM (st.date_fin_effective - st.heure_fin)) / 60
    ) AS duree_moyenne_retard_minutes
FROM Stream st
WHERE st.date_fin_effective > st.heure_fin;


PHASE 4
