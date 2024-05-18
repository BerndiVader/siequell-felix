--- 1_a:
INSERT into Material (Bezeichnung) VALUES ("Kupfer");
INSERT INTO Erhaltung (Bezeichnung) VALUES ("Gut erhalten");
INSERT INTO Erhaltung (Bezeichnung) VALUES ("Schön");
INSERT INTO Hersteller (Herstellername, Land) VALUES ("The Perth Mint","AUS");
INSERT INTO Hersteller (Herstellername, Land) VALUES ("Casa de moneda de mexiko","MEX");
INSERT INTO Muenzserie (Bezeichnung, Erscheinungsjahr) VALUES ("Lunar",1996);

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "Lunar 1/20 Unze" as Bezeichnung,
    1.56 as Rohgewicht,
    1.56 as Feingewicht,
    999.9 as Feinheit,
    14.6 as Durchmesser,
    1 as FS_MaterialID,
    Hersteller.HerstellerID as FS_HerstellerID,
    Muenzserie.MuenzserieID as FS_MuenzserieID
FROM
    Hersteller, Muenzserie
WHERE
    Hersteller.Herstellername="The Perth Mint"
AND
    Muenzserie.Bezeichnung="Lunar";

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "Lunar 5 Unzen" as Bezeichnung,
    155.518 as Rohgewicht,
    155.518 as Feingewicht,
    999 as Feinheit,
    60.6 as Durchmesser,
    2 as FS_MaterialID,
    Hersteller.HerstellerID as FS_HerstellerID,
    Muenzserie.MuenzserieID as FS_MuenzserieID
FROM
    Hersteller, Muenzserie
WHERE
    Hersteller.Herstellername="The Perth Mint"
AND
    Muenzserie.Bezeichnung="Lunar";

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "Lunar 10 Unzen" as Bezeichnung,
    311.035 as Rohgewicht,
    311.035 as Feingewicht,
    999.9 as Feinheit,
    60.6 as Durchmesser,
    1 as FS_MaterialID,
    Hersteller.HerstellerID as FS_HerstellerID,
    Muenzserie.MuenzserieID as FS_MuenzserieID
FROM
    Hersteller, Muenzserie
WHERE
    Hersteller.Herstellername="The Perth Mint"
AND
    Muenzserie.Bezeichnung="Lunar";

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "1 Unze Maple Leaf" as Bezeichnung,
    31.104 as Rohgewicht,
    31.104 as Feingewicht,
    999 as Feinheit,
    38 as Durchmesser,
    2 as FS_MaterialID,
    3 as FS_HerstellerID,
    2 as FS_MuenzserieID;

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "1 Unze Mexiko Libertad" as Bezeichnung,
    31.104 as Rohgewicht,
    31.104 as Feingewicht,
    999 as Feinheit,
    40 as Durchmesser,
    2 as FS_MaterialID,
    Hersteller.HerstellerID as FS_HerstellerID,
    3 as FS_MuenzserieID
FROM
    Hersteller
WHERE
    Hersteller.Herstellername="Casa de moneda de mexiko";

INSERT INTO Muenze (Bezeichnung, Rohgewicht, Feingewicht, Feinheit, Durchmesser, FS_MaterialID, FS_HerstellerID, FS_MuenzserieID)
SELECT
    "Philhamoniker 1 Unze" as Bezeichnung,
    31.104 as Rohgewicht,
    31.104 as Feingewicht,
    999.5 as Feinheit,
    37 as Durchmesser,
    4 as FS_MaterialID,
    1 as FS_HerstellerID,
    3 as FS_MuenzserieID;

--- 2_a:
SELECT * FROM Muenze WHERE Rohgewicht<=30;
--- 2_b:
SELECT Bezeichnung, Durchmesser FROM Muenze WHERE Bezeichnung like "*Unze*";
--- 2_c:
SELECT * FROM Hersteller WHERE Land IN ("GBR","MEX","CAN");
--- 2_d:
--- Selektion = Datensätze auswählen, Projektion = Spalte auswählen. 
--- Aufgabe 2_b = Selektion weil mit "*Unze" Datensätze gefiltert wurden.

--- 3_a:
UPDATE Bestand SET Anzahl=Anzahl+105 WHERE FS_ErhaltungID=2 AND FS_MuenzeID=1;
UPDATE Bestand SET Anzahl=Anzahl+38 WHERE FS_ErhaltungID=1 AND FS_MuenzeID=2;

--- 3_b:
UPDATE Bestand SET Anzahl=Anzahl-27 WHERE FS_ErhaltungID=1 AND FS_MuenzeID=1;
UPDATE Bestand  SET Anzahl=Anzahl-15 WHERE FS_ErhaltungID=1 AND FS_MuenzeID=8;
UPDATE Bestand SET Anzahl=Anzahl-50 WHERE FS_ErhaltungID=2 AND FS_MuenzeID=2;

--- 4_a:
SELECT Muenze.*, IIF(ISNULL(Dummy.Gesamtmenge),0,Dummy.Gesamtmenge) as Gesamtmenge FROM Muenze
LEFT JOIN (
    SELECT Bestand.FS_MuenzeID, SUM(Bestand.Anzahl) as Gesamtmenge FROM Bestand
    GROUP BY Bestand.FS_MuenzeID
) AS Dummy ON Muenze.MuenzeID=Dummy.FS_MuenzeID
ORDER BY Dummy.Gesamtmenge DESC;

--- 4_b:
SELECT Muenzserie.Bezeichnung, Round(IIF(ISNULL(Dummy.Durchschnitt),0,Dummy.Durchschnitt),4) as Durchschnitt FROM Muenzserie
LEFT JOIN (
    select FS_MuenzserieID, AVG(Feinheit) as Durchschnitt from Muenze
    GROUP BY Muenze.FS_MuenzserieID
) as Dummy ON Muenzserie.MuenzserieID=Dummy.FS_MuenzserieID
WHERE Durchschnitt>998;

--- 5_a:
UPDATE Bestand
INNER JOIN (
        select Muenze.MuenzeID,Muenze.FS_MuenzserieID, Dummy.Bezeichnung from Muenze
        left JOIN (
            select * from Muenzserie
        ) as Dummy on Muenze.FS_MuenzserieID=Dummy.MuenzserieID
        WHERE Dummy.Bezeichnung="Krügerrand"    
) AS Temp
on Temp.MuenzeID=Bestand.FS_MuenzeID
SET Anzahl=0;

--- 5_b:
UPDATE Hersteller SET Herstellername="The Best Mint" WHERE Herstellername="Rand Refinery";

--- 6_a:
SELECT Muenze.*, dummy.* FROM Muenze
LEFT JOIN (
    SELECT * FROM Muenzserie
    LEFT JOIN (
        SELECT AVG(Erscheinungsjahr) as average FROM Muenzserie
    ) AS avg ON avg.average<Muenzserie.Erscheinungsjahr
) AS dummy ON Muenze.FS_MuenzserieID=dummy.MuenzserieID
WHERE
dummy.average<dummy.Erscheinungsjahr;

--- 6_b:
SELECT Muenzserie.*,IIF(ISNULL(dummy.FS_MuenzserieID),"##KEINE MÜNZEN",dummy.Bezeichnung) as Muenzname FROM Muenzserie
LEFT JOIN (
    SELECT FS_MuenzserieID, Bezeichnung FROM Muenze
) as dummy ON Muenzserie.MuenzserieID=dummy.FS_MuenzserieID;





