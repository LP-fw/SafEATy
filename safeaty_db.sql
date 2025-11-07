CREATE DATABASE IF NOT EXISTS safEATy_db;
USE safEATy_db;

-- =====================================================
-- CREAZIONE TABELLE PRINCIPALI
-- =====================================================

-- Tabella UTENTE
CREATE TABLE Utente (
    ID_Utente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Cognome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Telefono VARCHAR(20),
    Data_Registrazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_email CHECK (Email LIKE '%@%.%')
);

-- Tabella ALLERGENE
CREATE TABLE Allergene (
    ID_Allergene INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) UNIQUE NOT NULL,
    Descrizione TEXT,
    Codice_EU VARCHAR(10) -- Codice secondo normativa europea
);

-- Tabella INGREDIENTE
CREATE TABLE Ingrediente (
    ID_Ingrediente INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) UNIQUE NOT NULL,
    Descrizione TEXT
);

-- Tabella PIATTO
CREATE TABLE Piatto (
    ID_Piatto INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(100) UNIQUE NOT NULL,
    Descrizione TEXT,
    Prezzo DECIMAL(6,2),
    Disponibile BOOLEAN DEFAULT TRUE,
    Data_Creazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabella SEGNALAZIONE
CREATE TABLE Segnalazione (
    ID_Segnalazione INT PRIMARY KEY AUTO_INCREMENT,
    Data_Segnalazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Descrizione TEXT NOT NULL,
    Gravita ENUM('Bassa', 'Media', 'Alta') DEFAULT 'Media',
    Stato ENUM('Aperta', 'In_Lavorazione', 'Chiusa') DEFAULT 'Aperta',
    ID_Utente INT NOT NULL,
    ID_Piatto INT NOT NULL,
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Piatto) REFERENCES Piatto(ID_Piatto) ON DELETE CASCADE
);

-- =====================================================
-- TABELLE DI RELAZIONE (N:M)
-- =====================================================

-- Relazione UTENTE-ALLERGENE (AllergicxA)
CREATE TABLE AllergicxA (
    ID_Utente INT,
    ID_Allergene INT,
    Data_Dichiarazione TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Note TEXT,
    PRIMARY KEY (ID_Utente, ID_Allergene),
    FOREIGN KEY (ID_Utente) REFERENCES Utente(ID_Utente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Allergene) REFERENCES Allergene(ID_Allergene) ON DELETE CASCADE
);

-- Relazione INGREDIENTE-ALLERGENE (Contiene)
CREATE TABLE Contiene (
    ID_Ingrediente INT,
    ID_Allergene INT,
    Quantita_Tracce BOOLEAN DEFAULT FALSE, -- Se contiene solo tracce
    PRIMARY KEY (ID_Ingrediente, ID_Allergene),
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente) ON DELETE CASCADE,
    FOREIGN KEY (ID_Allergene) REFERENCES Allergene(ID_Allergene) ON DELETE CASCADE
);

-- Relazione PIATTO-INGREDIENTE (CompostoDa)
CREATE TABLE CompostoDa (
    ID_Piatto INT,
    ID_Ingrediente INT,
    Quantita VARCHAR(50), -- es. "200g", "1 cucchiaio"
    Essenziale BOOLEAN DEFAULT TRUE, -- Se l'ingrediente è essenziale o opzionale
    PRIMARY KEY (ID_Piatto, ID_Ingrediente),
    FOREIGN KEY (ID_Piatto) REFERENCES Piatto(ID_Piatto) ON DELETE CASCADE,
    FOREIGN KEY (ID_Ingrediente) REFERENCES Ingrediente(ID_Ingrediente) ON DELETE CASCADE
);

-- =====================================================
-- INSERIMENTO DATI DI ESEMPIO
-- =====================================================

-- Inserimento Allergeni (14 principali secondo normativa UE)
INSERT INTO Allergene (Nome, Descrizione, Codice_EU) VALUES
('Glutine', 'Cereali contenenti glutine (grano, segale, orzo, avena)', 'A1'),
('Crostacei', 'Crostacei e prodotti a base di crostacei', 'A2'),
('Uova', 'Uova e prodotti a base di uova', 'A3'),
('Pesce', 'Pesce e prodotti a base di pesce', 'A4'),
('Arachidi', 'Arachidi e prodotti a base di arachidi', 'A5'),
('Soia', 'Soia e prodotti a base di soia', 'A6'),
('Latte', 'Latte e prodotti a base di latte (incluso lattosio)', 'A7'),
('Frutta a guscio', 'Frutta a guscio (mandorle, nocciole, noci, etc.)', 'A8'),
('Sedano', 'Sedano e prodotti a base di sedano', 'A9'),
('Senape', 'Senape e prodotti a base di senape', 'A10'),
('Semi di sesamo', 'Semi di sesamo e prodotti a base di semi di sesamo', 'A11'),
('Anidride solforosa', 'Anidride solforosa e solfiti', 'A12'),
('Lupini', 'Lupini e prodotti a base di lupini', 'A13'),
('Molluschi', 'Molluschi e prodotti a base di molluschi', 'A14');

-- Inserimento Ingredienti
INSERT INTO Ingrediente (Nome, Descrizione) VALUES
('Farina di frumento', 'Farina bianca tipo 00'),
('Latte intero', 'Latte vaccino fresco'),
('Uova fresche', 'Uova di gallina categoria A'),
('Burro', 'Burro salato da latte vaccino'),
('Parmigiano Reggiano', 'Formaggio stagionato DOP'),
('Pomodori pelati', 'Pomodori San Marzano in scatola'),
('Olio extravergine oliva', 'Olio EVO toscano'),
('Basilico fresco', 'Basilico genovese DOP'),
('Aglio', 'Aglio bianco di Vessalico'),
('Sale marino', 'Sale marino integrale'),
('Pepe nero', 'Pepe nero macinato fresco'),
('Salmone fresco', 'Filetto di salmone norvegese'),
('Gamberi', 'Gamberi rossi del Mediterraneo'),
('Vongole', 'Vongole veraci'),
('Noci', 'Noci sgusciate'),
('Mandorle', 'Mandorle pelate'),
('Mozzarella', 'Mozzarella di bufala campana DOP'),
('Prosciutto crudo', 'Prosciutto di Parma DOP'),
('Rucola', 'Rucola selvatica'),
('Pomodorini', 'Pomodorini ciliegino');

-- Inserimento Piatti
INSERT INTO Piatto (Nome, Descrizione, Prezzo) VALUES
('Spaghetti Carbonara', 'Pasta con uova, guanciale, pecorino e pepe nero', 12.50),
('Pizza Margherita', 'Pizza con pomodoro, mozzarella e basilico', 8.00),
('Risotto ai Funghi', 'Risotto cremoso con porcini e parmigiano', 14.00),
('Salmone Grigliato', 'Filetto di salmone con verdure di stagione', 18.00),
('Linguine alle Vongole', 'Pasta con vongole, aglio, olio e prezzemolo', 16.00),
('Insalata di Mare', 'Gamberi, polpo e verdure fresche', 15.00),
('Tagliatelle al Tartufo', 'Pasta fresca con tartufo nero e parmigiano', 22.00),
('Caprese', 'Mozzarella, pomodoro e basilico', 10.00),
('Torta della Nonna', 'Dolce con crema pasticcera e pinoli', 6.00),
('Tiramisu', 'Dolce al mascarpone e caffè', 7.00);

-- Inserimento Utenti di esempio
INSERT INTO Utente (Nome, Cognome, Email, Telefono) VALUES
('Mario', 'Rossi', 'mario.rossi@email.com', '3331234567'),
('Anna', 'Verdi', 'anna.verdi@email.com', '3337654321'),
('Luca', 'Bianchi', 'luca.bianchi@email.com', '3339876543'),
('Giulia', 'Neri', 'giulia.neri@email.com', '3335551234'),
('Marco', 'Ferrari', 'marco.ferrari@email.com', '3338889999');

-- Associazione Ingredienti-Allergeni
INSERT INTO Contiene (ID_Ingrediente, ID_Allergene, Quantita_Tracce) VALUES
-- Farina di frumento contiene glutine
(1, 1, FALSE),
-- Latte contiene lattosio
(2, 7, FALSE),
-- Uova contengono allergene uova
(3, 3, FALSE),
-- Burro contiene latte
(4, 7, FALSE),
-- Parmigiano contiene latte
(5, 7, FALSE),
-- Salmone contiene pesce
(12, 4, FALSE),
-- Gamberi contengono crostacei
(13, 2, FALSE),
-- Vongole contengono molluschi
(14, 14, FALSE),
-- Noci contengono frutta a guscio
(15, 8, FALSE),
-- Mandorle contengono frutta a guscio
(16, 8, FALSE),
-- Mozzarella contiene latte
(17, 7, FALSE);

-- Composizione piatti (esempio per alcuni piatti)
INSERT INTO CompostoDa (ID_Piatto, ID_Ingrediente, Quantita, Essenziale) VALUES
-- Spaghetti Carbonara (ID_Piatto = 1)
(1, 1, '100g', TRUE),  -- Farina (per pasta)
(1, 3, '2 uova', TRUE), -- Uova
(1, 5, '50g', TRUE),   -- Parmigiano
(1, 11, 'q.b.', TRUE),  -- Pepe nero
-- Pizza Margherita (ID_Piatto = 2)
(2, 1, '200g', TRUE),   -- Farina (per impasto)
(2, 6, '100g', TRUE),   -- Pomodori pelati
(2, 17, '150g', TRUE),  -- Mozzarella
(2, 8, 'q.b.', TRUE),   -- Basilico
-- Salmone Grigliato (ID_Piatto = 4)
(4, 12, '200g', TRUE),  -- Salmone
(4, 7, 'q.b.', TRUE),   -- Olio EVO
(4, 10, 'q.b.', TRUE),  -- Sale
-- Linguine alle Vongole (ID_Piatto = 5)
(5, 1, '100g', TRUE),   -- Farina (per pasta)
(5, 14, '300g', TRUE),  -- Vongole
(5, 9, '2 spicchi', TRUE), -- Aglio
(5, 7, 'q.b.', TRUE);   -- Olio EVO

-- Associazione Utenti-Allergeni (profili allergici)
INSERT INTO AllergicxA (ID_Utente, ID_Allergene, Note) VALUES
-- Mario Rossi è allergico al glutine
(1, 1, 'Allergia severa al glutine'),
-- Anna Verdi è allergica al latte
(2, 7, 'Intolleranza al lattosio'),
-- Luca Bianchi è allergico ai crostacei e molluschi
(3, 2, 'Allergia ai crostacei'),
(3, 14, 'Allergia ai molluschi'),
-- Giulia Neri è allergica alle uova
(4, 3, 'Allergia alle uova'),
-- Marco Ferrari è allergico alla frutta a guscio
(5, 8, 'Allergia a noci e mandorle');

-- Inserimento Segnalazioni di esempio
INSERT INTO Segnalazione (Descrizione, Gravita, ID_Utente, ID_Piatto) VALUES
('Ho riscontrato tracce di glutine nel piatto che doveva essere senza glutine', 'Alta', 1, 4),
('Il piatto conteneva latticini non segnalati nel menu', 'Media', 2, 1),
('Reazione allergica lieve, possibili tracce di crostacei', 'Bassa', 3, 8);

-- =====================================================
-- CREAZIONE INDICI PER OTTIMIZZARE LE PRESTAZIONI
-- =====================================================

-- Indici per ricerche frequenti
CREATE INDEX idx_utente_email ON Utente(Email);
CREATE INDEX idx_piatto_disponibile ON Piatto(Disponibile);
CREATE INDEX idx_segnalazione_data ON Segnalazione(Data_Segnalazione);
CREATE INDEX idx_segnalazione_stato ON Segnalazione(Stato);
CREATE INDEX idx_allergene_nome ON Allergene(Nome);

-- =====================================================
-- VISTE UTILI PER IL SISTEMA
-- =====================================================

-- Vista per mostrare i piatti con i loro allergeni
CREATE VIEW Vista_Piatti_Allergeni AS
SELECT DISTINCT
    p.ID_Piatto,
    p.Nome AS Nome_Piatto,
    p.Descrizione AS Descrizione_Piatto,
    a.ID_Allergene,
    a.Nome AS Nome_Allergene
FROM Piatto p
JOIN CompostoDa cd ON p.ID_Piatto = cd.ID_Piatto
JOIN Ingrediente i ON cd.ID_Ingrediente = i.ID_Ingrediente
JOIN Contiene c ON i.ID_Ingrediente = c.ID_Ingrediente
JOIN Allergene a ON c.ID_Allergene = a.ID_Allergene
WHERE p.Disponibile = TRUE;

-- Vista per il profilo allergenico degli utenti
CREATE VIEW Vista_Profili_Allergici AS
SELECT 
    u.ID_Utente,
    u.Nome,
    u.Cognome,
    u.Email,
    a.Nome AS Allergene,
    aa.Note,
    aa.Data_Dichiarazione
FROM Utente u
JOIN AllergicxA aa ON u.ID_Utente = aa.ID_Utente
JOIN Allergene a ON aa.ID_Allergene = a.ID_Allergene;

-- =====================================================
-- PROCEDURE STORED UTILI
-- =====================================================

DELIMITER //

-- Procedura per trovare piatti sicuri per un utente
CREATE PROCEDURE TrovaPiattiSicuri(IN utente_id INT)
BEGIN
    SELECT DISTINCT p.ID_Piatto, p.Nome, p.Descrizione, p.Prezzo
    FROM Piatto p
    WHERE p.Disponibile = TRUE
    AND p.ID_Piatto NOT IN (
        -- Esclude piatti che contengono allergeni dell'utente
        SELECT DISTINCT cd.ID_Piatto
        FROM CompostoDa cd
        JOIN Contiene c ON cd.ID_Ingrediente = c.ID_Ingrediente
        JOIN AllergicxA aa ON c.ID_Allergene = aa.ID_Allergene
        WHERE aa.ID_Utente = utente_id
    );
END //

-- Procedura per generare report settimanale segnalazioni
CREATE PROCEDURE ReportSegnalazioniSettimanali()
BEGIN
    SELECT 
        p.Nome AS Piatto,
        COUNT(s.ID_Segnalazione) AS Num_Segnalazioni,
        AVG(CASE 
            WHEN s.Gravita = 'Bassa' THEN 1
            WHEN s.Gravita = 'Media' THEN 2
            WHEN s.Gravita = 'Alta' THEN 3
        END) AS Gravita_Media
    FROM Piatto p
    LEFT JOIN Segnalazione s ON p.ID_Piatto = s.ID_Piatto
    WHERE s.Data_Segnalazione >= DATE_SUB(NOW(), INTERVAL 1 WEEK)
    GROUP BY p.ID_Piatto, p.Nome
    ORDER BY Num_Segnalazioni DESC;
END //

DELIMITER ;