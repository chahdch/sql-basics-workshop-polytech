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
