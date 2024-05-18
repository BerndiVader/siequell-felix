-- 1_a:
create TABLE Hersteller (
HerstellerID AUTOINCREMENT PRIMARY KEY,
Herstellername TEXT(255) NOT NULL,
Land TEXT(255) NOT NULL
);

-- 1_b:
INSERT INTO Hersteller (Herstellername,Land)
VALUES
('Münze Austria','Österreich');
INSERT INTO Hersteller (Herstellername,Land)
VALUES
('Münze Germany','Deutschland');
INSERT INTO Hersteller (Herstellername,Land)
VALUES
('Münze Italy','Italien');

-- 2_a:
create TABLE Muenzserie (
MuenzserieID AUTOINCREMENT PRIMARY KEY,
Bezeichnung TEXT(255) NOT NULL,
Erscheinungsjahr int
);

-- 2_b:
INSERT into Muenzserie (Bezeichnung,Erscheinungsjahr)
VALUES
('Schilling',1901);
INSERT into Muenzserie (Bezeichnung,Erscheinungsjahr)
VALUES
('Euro',2000);
INSERT into Muenzserie (Bezeichnung,Erscheinungsjahr)
VALUES
('Krone',1800);

-- 3_a:
create TABLE [Muenze] (
MuenzeID AUTOINCREMENT PRIMARY KEY,
Bezeichnung TEXT(255) NOT NULL,
Rohgewicht float,
Feingewicht float,
Feinheit float,
Durchmesser float
);

-- 3_b:
INSERT into Muenze (Bezeichnung,Rohgewicht,Feingewicht,Feinheit,Durchmesser)
VALUES
('blabla',0.5,0.2,1,10);
INSERT into Muenze (Bezeichnung,Rohgewicht,Feingewicht,Feinheit,Durchmesser)
VALUES
('blabla1',0.333,0.3,2,8);
INSERT into Muenze (Bezeichnung,Rohgewicht,Feingewicht,Feinheit,Durchmesser)
VALUES
('blabla2',0.222,0.1,3,7);

-- 4_a:
create table [Material] (
MaterialID AUTOINCREMENT PRIMARY KEY,
Bezeichnung TEXT(255) NOT NULL
);

-- 4_b:
INSERT into Material (Bezeichnung)
VALUES
('Gold');
INSERT into Material (Bezeichnung)
VALUES
('Silber');
INSERT into Material (Bezeichnung)
VALUES
('Kupfer');

-- 5_a:
create table Erhaltung (
ErhaltungID AUTOINCREMENT PRIMARY KEY,
Bezeichnung TEXT(255) NOT NULL
);

-- 5_b:
INSERT into Erhaltung (Bezeichnung)
VALUES
('Blubb');
INSERT into Erhaltung (Bezeichnung)
VALUES
('Blabb');
INSERT into Erhaltung (Bezeichnung)
VALUES
('Blibb');

-- 6_a:
CREATE TABLE [Bestand] (
FS_ErhaltungsID integer not NULL REFERENCES Erhaltung(ErhaltungID),
FS_MuenzeID int NOT NULL REFERENCES Muenze(MuenzeID),
Anzahl INT
);

-- 6_b:
INSERT into Bestand (FS_ErhaltungsID,FS_MuenzeID,Anzahl)
VALUES
(1,1,10);
INSERT into Bestand (FS_ErhaltungsID,FS_MuenzeID,Anzahl)
VALUES
(2,2,20);
INSERT into Bestand (FS_ErhaltungsID,FS_MuenzeID,Anzahl)
VALUES
(3,3,30);