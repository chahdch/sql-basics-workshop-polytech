-- ============================================================
-- 2026_BDD_CHATT_CHAHD_EX1.sql
-- Projet : Gestion de l'Infrastructure de Données du ZEvent
-- Étudiant : CHATT CHAHD
-- ============================================================

Exercice 0 : creation des tableaux 


CREATE TABLE Streamer (
    id_streamer SERIAL PRIMARY KEY,
    pseudo VARCHAR(100) UNIQUE NOT NULL,
    url_twitch VARCHAR(255)
);

CREATE TABLE Creneau (
    id_creneau SERIAL PRIMARY KEY,
    id_streamer INT NOT NULL,
    date_debut_autorisee TIMESTAMP NOT NULL,
    date_fin_autorisee TIMESTAMP NOT NULL,
    FOREIGN KEY (id_streamer) REFERENCES Streamer(id_streamer)
);

CREATE TABLE Stream (
    id_stream SERIAL PRIMARY KEY,
    id_streamer INT NOT NULL,
    id_creneau INT NOT NULL,
    titre VARCHAR(255) NOT NULL,
    heure_debut TIMESTAMP NOT NULL,
    heure_fin TIMESTAMP NOT NULL,
    date_fin_effective TIMESTAMP,
    FOREIGN KEY (id_streamer) REFERENCES Streamer(id_streamer),
    FOREIGN KEY (id_creneau) REFERENCES Creneau(id_creneau)
);

CREATE TABLE Defi (
    id_defi SERIAL PRIMARY KEY,
    intitule VARCHAR(255) NOT NULL,
    montant_palier DECIMAL(12,2) NOT NULL,
    etat_validation BOOLEAN NOT NULL
);

CREATE TABLE Participation_Defi (
    id_streamer INT,
    id_defi INT,
    PRIMARY KEY (id_streamer, id_defi),
    FOREIGN KEY (id_streamer) REFERENCES Streamer(id_streamer),
    FOREIGN KEY (id_defi) REFERENCES Defi(id_defi)
);





PHASE 1

Exercice 1 : Population de la base de données



INSERT INTO Streamer (pseudo, url_twitch) VALUES
('xQc', 'https://www.twitch.tv/xqc'),
('KaiCenat', 'https://www.twitch.tv/kaicenat'),
('Pokimane', 'https://www.twitch.tv/pokimane'),
('Ninja', 'https://www.twitch.tv/ninja'),
('HasanAbi', 'https://www.twitch.tv/hasanabi'),
('Asmongold', 'https://www.twitch.tv/asmongold'),
('Shroud', 'https://www.twitch.tv/shroud'),
('Ludwig', 'https://www.twitch.tv/ludwig'),
('ExtraEmily', 'https://www.twitch.tv/extraemily'),
('IShowSpeed', 'https://www.twitch.tv/ishowspeed');



INSERT INTO Creneau (id_streamer, date_debut_autorisee, date_fin_autorisee) VALUES
(1, '2026-05-22 18:00:00', '2026-05-22 23:00:00'),
(1, '2026-05-24 14:00:00', '2026-05-24 20:00:00'),

(2, '2026-05-22 20:00:00', '2026-05-23 01:00:00'),
(2, '2026-05-25 15:00:00', '2026-05-25 19:00:00'),

(3, '2026-05-21 17:00:00', '2026-05-21 22:00:00'),
(3, '2026-05-23 12:00:00', '2026-05-23 18:00:00'),

(4, '2026-05-22 16:00:00', '2026-05-22 21:00:00'),
(4, '2026-05-24 10:00:00', '2026-05-24 15:00:00'),

(5, '2026-05-21 19:00:00', '2026-05-22 00:00:00'),
(5, '2026-05-23 14:00:00', '2026-05-23 20:00:00'),

(6, '2026-05-22 18:30:00', '2026-05-22 23:30:00'),
(6, '2026-05-25 13:00:00', '2026-05-25 18:00:00'),

(7, '2026-05-21 15:00:00', '2026-05-21 20:00:00'),
(7, '2026-05-24 16:00:00', '2026-05-24 22:00:00'),

(8, '2026-05-22 21:00:00', '2026-05-23 02:00:00'),
(8, '2026-05-24 13:00:00', '2026-05-24 18:00:00'),

(9, '2026-05-21 18:00:00', '2026-05-21 23:00:00'),
(9, '2026-05-23 11:00:00', '2026-05-23 16:00:00'),

(10, '2026-05-22 17:00:00', '2026-05-22 22:00:00'),
(10, '2026-05-25 14:00:00', '2026-05-25 19:00:00');


INSERT INTO Defi (intitule, montant_palier, etat_validation) VALUES
('Teinture de cheveux en bleu', 500.00, FALSE),
('Stream de 24 heures', 1000.00, FALSE),
('Jouer a un jeu d horreur', 2500.00, FALSE),
('Deguisement ridicule pendant 1 stream', 5000.00, FALSE),
('Chanter en live', 7500.00, FALSE),
('Tournoi communautaire', 10000.00, FALSE),
('Marathon gaming de 48 heures', 25000.00, FALSE),
('IRL dans une ville choisie par le chat', 50000.00, FALSE),
('Tatouage choisi par la communaute', 75000.00, FALSE),
('Saut en parachute en live', 100000.00, FALSE);


INSERT INTO Participation_Defi (id_streamer, id_defi) VALUES
(1, 1),
(1, 4),
(1, 10),

(2, 2),
(2, 5),

(3, 3),
(3, 7),

(4, 1),
(4, 6),

(5, 8),
(5, 10),

(6, 2),
(6, 9),

(7, 4),
(7, 7),

(8, 3),
(8, 10),

(9, 5),
(9, 8),

(10, 6),
(10, 9);


INSERT INTO Stream (
    id_streamer,
    id_creneau,
    titre,
    heure_debut,
    heure_fin,
    date_fin_effective
) VALUES
(1, 1, 'Ranked Gameplay Night',
'2026-05-22 18:30:00',
'2026-05-22 22:30:00',
'2026-05-22 22:25:00'),

(1, 2, 'Community Games',
'2026-05-24 15:00:00',
'2026-05-24 19:00:00',
NULL),

(2, 3, 'Late Night Just Chatting',
'2026-05-22 20:30:00',
'2026-05-23 00:30:00',
'2026-05-23 00:10:00'),

(2, 4, 'React Stream',
'2026-05-25 15:30:00',
'2026-05-25 18:30:00',
NULL),

(3, 5, 'MMO Adventure',
'2026-05-21 18:00:00',
'2026-05-21 21:30:00',
'2026-05-21 21:20:00'),

(3, 6, 'Weekend Tournament',
'2026-05-23 13:00:00',
'2026-05-23 17:00:00',
NULL),

(4, 7, 'Variety Stream',
'2026-05-22 17:00:00',
'2026-05-22 20:00:00',
'2026-05-22 19:50:00'),

(5, 9, 'FPS Ranked Grind',
'2026-05-21 20:00:00',
'2026-05-21 23:30:00',
NULL),

(6, 11, 'Challenge Run',
'2026-05-22 19:00:00',
'2026-05-22 23:00:00',
'2026-05-22 22:45:00'),

(7, 13, 'Competitive Matches',
'2026-05-21 16:00:00',
'2026-05-21 19:30:00',
NULL),

(8, 15, 'Night Gaming Session',
'2026-05-22 21:30:00',
'2026-05-23 01:30:00',
'2026-05-23 01:15:00'),

(8, 16, 'Weekend Chill Stream',
'2026-05-24 14:00:00',
'2026-05-24 17:30:00',
NULL),

(9, 17, 'Story Game Marathon',
'2026-05-21 18:30:00',
'2026-05-21 22:00:00',
'2026-05-21 21:55:00'),

(10, 19, 'Speedrun Practice',
'2026-05-22 17:30:00',
'2026-05-22 21:00:00',
NULL),

(10, 20, 'Community Event',
'2026-05-25 15:00:00',
'2026-05-25 18:30:00',
'2026-05-25 18:20:00');
