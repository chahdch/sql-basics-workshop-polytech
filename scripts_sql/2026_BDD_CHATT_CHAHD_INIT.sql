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
