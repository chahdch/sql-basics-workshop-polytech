-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX8.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 8 :

Etape 1 :

TRUNCATE TABLE stream, participation_defi, creneau, defi, streamer RESTART IDENTITY CASCADE;

-- 2. Insert 50,000 streamers
DO $$
BEGIN
    FOR i IN 1..50000 LOOP
        INSERT INTO streamer (pseudo, url_twitch)
        VALUES ('pseudo_' || i, 'https://twitch.tv/pseudo_' || i);
    END LOOP;
END $$;

-- 3. Insert 50,000 défis
DO $$
BEGIN
    FOR i IN 1..50000 LOOP
        INSERT INTO defi (intitule, montant_palier, etat_validation)
        VALUES (
            'defi_' || i,
            (random() * 50000)::DECIMAL(12,2) + 500,
            (random() < 0.5)
        );
    END LOOP;
END $$;

-- 4. Insert 250,000 participations (M:N)
-- Correction : Utilisation de FLOOR et gestion des conflits de clés primaires
DO $$
BEGIN
    FOR i IN 1..250000 LOOP
        INSERT INTO participation_defi (id_streamer, id_defi)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            FLOOR(random() * 50000 + 1)::INT
        )
        ON CONFLICT DO NOTHING; -- Évite l'erreur si le couple existe déjà
    END LOOP;
END $$;

-- 5. Insert 100,000 créneaux
DO $$
DECLARE
    start_date TIMESTAMP;
    end_date TIMESTAMP;
BEGIN
    FOR i IN 1..100000 LOOP
        start_date := TIMESTAMP '2025-09-05 18:00:00' + (random() * 48)::INT * INTERVAL '1 hour';
        end_date := start_date + (random() * 4 + 1)::INT * INTERVAL '1 hour';
        INSERT INTO creneau (id_streamer, date_debut_autorisee, date_fin_autorisee)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            start_date,
            end_date
        );
    END LOOP;
END $$;

-- 6. Insert 100,000 streams
DO $$
DECLARE
    start_date TIMESTAMP;
    end_date TIMESTAMP;
    effective_end_date TIMESTAMP;
BEGIN
    FOR i IN 1..100000 LOOP
        start_date := TIMESTAMP '2025-09-05 18:00:00' + (random() * 48)::INT * INTERVAL '1 hour';
        end_date := start_date + (random() * 4 + 1)::INT * INTERVAL '1 hour';
        effective_end_date := CASE WHEN random() < 0.7 
                              THEN end_date 
                              ELSE end_date + (random() * 3)::INT * INTERVAL '1 hour'
                              END;
        INSERT INTO stream (id_streamer, id_creneau, titre, heure_debut, heure_fin, date_fin_effective)
        VALUES (
            FLOOR(random() * 50000 + 1)::INT,
            FLOOR(random() * 100000 + 1)::INT,
            'Stream caritatif ' || i,
            start_date,
            end_date,
            effective_end_date
        );
    END LOOP;
END $$;


ETAPE 2 : 

EXPLAIN ANALYZE
SELECT 
    s.pseudo,
    d.intitule,
    COUNT(st.id_stream) as nb_streams,
    COUNT(CASE WHEN st.date_fin_effective > st.heure_fin THEN 1 END) as nb_depassements
FROM streamer s
JOIN participation_defi pd ON s.id_streamer = pd.id_streamer
JOIN defi d ON pd.id_defi = d.id_defi
LEFT JOIN stream st ON s.id_streamer = st.id_streamer
-- MODIFICATION : On applique une fonction sur la colonne indexée
-- Cela empêche l'utilisation de l'index B-Tree classique
WHERE (s.id_streamer + 0) < 5000 
GROUP BY s.id_streamer, s.pseudo, d.id_defi, d.intitule
ORDER BY s.pseudo, d.intitule;


ETAPE 3 : 

1. temps d'execution : 
		Planning Time : 0.972 ms
		Execution Time : 243.667 ms

2. Seq Scans :
		Seq Scan on participation_defi pd  (cost=0.00..3606.89 rows=249989 width=8) (actual time=0.008..14.268 rows=249989 loops=1)
	  	Seq Scan on stream st  (cost=0.00..2137.00 rows=100000 width=24) (actual time=0.007..6.242 rows=100000 loops=1)
	  	Seq Scan on streamer s  (cost=0.00..1218.00 rows=16667 width=16) (actual time=0.008..3.621 rows=4999 loops=1)
	  	Seq Scan on defi d  (cost=0.00..851.00 rows=50000 width=14) (actual time=0.013..5.094 rows=50000 loops=1)

3. Les operations lourdes : 
		Seq Scan on participation_defi pd  (.... rows=249989 loops=1)
		Seq Scan on stream st  (.... rows=100000 loops=1)
		Seq Scan on defi d  (.... rows=50000 loops=1)
		Hash Join  (.... rows=52991 loops=1)
		HashAggregate  (.... rows=24735 loops=1)

4. la requête présente des performances élevées car elle repose sur des lectures complètes des tables (Seq Scan), 
ce qui oblige la base de données à parcourir l’ensemble des lignes sans utiliser d’index. 
Les jointures entre les différentes tables génèrent un volume important de données intermédiaires, et les opérations de regroupement et de tri augmentent encore le coût de traitement. 
Ainsi, plusieurs centaines de milliers de lignes sont manipulées, ce qui entraîne un temps d’exécution élevé et une charge importante sur le système






ETAPE 5 :
-- Index sur les clés étrangères impliquées dans les jointures
CREATE INDEX idx_participation_defi_id_streamer 
    ON participation_defi(id_streamer);
CREATE INDEX idx_participation_defi_id_defi 
    ON participation_defi(id_defi);

-- Index sur les jointures de stream
CREATE INDEX idx_stream_id_streamer 
    ON stream(id_streamer);

-- Index sur les comparaisons et filtres
CREATE INDEX idx_stream_date_fin_effective 
    ON stream(date_fin_effective);

-- Index composé pour les filtres combinés
CREATE INDEX idx_stream_id_streamer_date_fin_effective 
    ON stream(id_streamer, date_fin_effective);




ETAPE 6 : 

1. temps d'execution :
		Planning Time : 1.231 ms
		Execution Time : 172.644 ms

2. Seq Scans :
		Parallel Seq Scan on participation_defi pd  (cost=0.00..2577.52 rows=147052 width=8) (actual time=0.006..8.231 rows=124994 loops=2)
		Seq Scan on streamer s  (cost=0.00..1218.00 rows=16667 width=16) (actual time=0.040..4.438 rows=4999 loops=2)
		Seq Scan on defi d  (cost=0.00..851.00 rows=50000 width=14) (actual time=0.032..5.830 rows=50000 loops=2)
		Index Scan using idx_stream_id_streamer on stream st  (cost=0.29..6876.28 rows=100000 width=24) (actual time=0.058..7.858 rows=10019 loops=1)

3. Nombre de lignes traités :
		Parallel Seq Scan → 124994 rows × 2 loops ≈ 249 988 lignes
		Seq Scan → 50000 rows × 2 loops ≈ 100 000 lignes
		Seq Scan → 4999 rows × 2 loops ≈ 9 998 lignes lues (mais 50 000 filtrées au total)
		Index Scan → 10019 rows
		Materialize → 49808 rows
		Index Scan → 10019 rows
		Materialize → 49808 rows
	Environ 450000 lignes brute

4. Le gain en performance : 
		Gain (%) = (Ancien temps - Nouveau temps) / Ancien temps × 100
			   = (243.667 - 172.644) / 243.667 × 100
			   = 71.023 / 243.667 × 100
			   ≈ 29.14 %




ETAPE 7 : 

EXPLAIN ANALYZE
SELECT s.pseudo, COUNT(pd.id_defi) as nb_defis
FROM streamer s
LEFT JOIN participation_defi pd ON s.id_streamer = pd.id_streamer
WHERE s.pseudo LIKE '%pseudo%1%'
GROUP BY s.id_streamer, s.pseudo;



ETAPE 8 : CONCLUSION

1. Quels index ont eu le plus d'impact ?
Les index qui ont eu le plus d'impact sont ceux liés aux jointures :
- idx_stream_id_streamer sur stream(id_streamer)
- idx_participation_defi_id_streamer sur participation_defi(id_streamer)
- idx_participation_defi_id_defi sur participation_defi(id_defi)

L'index idx_stream_id_streamer a notamment permis d'utiliser un Index Scan sur la table stream,
au lieu de parcourir toute la table avec un Seq Scan.

2. Pourquoi les jointures sur participation_defi étaient lentes sans index ?
La table participation_defi contient environ 250 000 lignes et sert de table de liaison M:N
entre les streamers et les défis. Sans index sur id_streamer et id_defi, PostgreSQL doit parcourir
une grande partie de la table pour trouver les correspondances avec streamer et defi.
Cela provoque des Seq Scan et augmente fortement le coût des jointures.

3. Quel est le gain de performance global ?
Temps avant index : 243.667 ms
Temps après index : 172.644 ms

Calcul :
(243.667 - 172.644) / 243.667 * 100 = 29.14 %

Le gain de performance global est donc d'environ 29.14 %.
Même si certains Seq Scan restent présents, les index ont réduit le temps d'exécution
en accélérant surtout les jointures et l'accès à la table stream.

