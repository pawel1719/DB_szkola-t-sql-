/* ************************************************
Projekt bazy SZKOLA
************************************************** */

-----------------------------------------
--Utworzenie bazy danych o nazwie szkoła
CREATE DATABASE szkola;
GO
USE szkola;
GO

------------------------------------------------------------
------------------------------------------------------------
---------     5 KWEREND TWORZĄCYCH TABELE       ------------
------------------------------------------------------------

-----------------------------------------
--Utworzenie tabeli "uczniowie"
-----------------------------------------
IF OBJECT_ID('dbo.uczniowie') IS NOT NULL
    DROP TABLE dbo.uczniowie;
create table uczniowie
(
	IdUcznia		int identity (1,1) primary key not null,
	Imie			nvarchar(15) not null,
	Nazwisko		nvarchar(20) not null,
	DataUrodzenia	date not null default getdate(),
	Miejscowosc		nvarchar(15) not null,
	Ulica			nvarchar(30) not null,
	NrDomu_Mieszkania	nvarchar(8) not null,
	Telefon			nvarchar(15) not null,
	IdKlasy			int not null
);
GO

-----------------------------------------
--Utworzenie tabeli "klasy"
-----------------------------------------
IF OBJECT_ID('dbo.klasy') IS NOT NULL
    DROP TABLE dbo.klasy;
create table klasy
(
	IdKlasy			int identity (1,1) primary key not null,
	Nazwa			nvarchar(15) not null,
	Opis			nvarchar(60) not null,
	Wychowawca		int not null
);
GO

-----------------------------------------
--Utworzenie tabeli "nauczyciele"
-----------------------------------------
IF OBJECT_ID('dbo.nauczyciele') IS NOT NULL
    DROP TABLE dbo.nauczyciele;
create table nauczyciele
(
	IdNauczyciela	int identity (1,1) primary key not null,
	Imie			nvarchar(20) not null,
	Nazwisko		nvarchar(30) not null,
	Miejscowosc		nvarchar(15) not null,
	Ulica			nvarchar(50) not null,
	NrDomu_Mieszkania	nvarchar(8) not null,
	Telefon			nvarchar(14) not null,
	IdPrzedmiotu	int not null
);
GO

-----------------------------------------
--Utworzenie tabeli "przedmioty"
-----------------------------------------
IF OBJECT_ID('dbo.przedmioty') IS NOT NULL
    DROP TABLE dbo.przedmioty;
create table przedmioty
(
	IdPrzedmiotu	int identity (1,1) primary key not null,
	Nazwa			nvarchar(35) not null,
	Opis			nvarchar(20) not null
);
GO

-----------------------------------------
--Utworzenie tabeli "oceny"
-----------------------------------------
IF OBJECT_ID('dbo.oceny') IS NOT NULL
    DROP TABLE dbo.oceny;
create table oceny
(
	IdOceny			int identity (1,1) primary key not null,
	Ocena			float not null,
	IdUcznia		int not null,
	IdPrzedmiotu	int not null
);
GO


------------------------------------------------------------
------------------------------------------------------------
---------------     RELACJE       --------------------------
------------------------------------------------------------

---------------------------------------------------
---Relacje w rejestrze nauczyciele - przedmiot
---------------------------------------------------
ALTER TABLE nauczyciele  
ADD CONSTRAINT KluczObcyNauczyciele1 FOREIGN KEY (IdPrzedmiotu) 
REFERENCES przedmioty (IdPrzedmiotu)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

---------------------------------------------------
---Relacje w rejestrze klasy - nauczyciel
---------------------------------------------------
ALTER TABLE klasy  
ADD CONSTRAINT KluczObcyKlasy1 FOREIGN KEY (Wychowawca) 
REFERENCES nauczyciele (IdNauczyciela)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

---------------------------------------------------
---Relacje w rejestrze uczniowie - klasy
---------------------------------------------------
ALTER TABLE uczniowie  
ADD CONSTRAINT KluczObcyUczniowie1 FOREIGN KEY (IdKlasy) 
REFERENCES klasy (IdKlasy)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

------------------------------------------
---Relacje w rejestrze oceny - uczniowie
------------------------------------------
--Usuwanie relacji
------------------------------------------
--ALTER TABLE oceny
--DROP CONSTRAINT KluczObcyOceny1;
--ALTER TABLE oceny
--DROP CONSTRAINT KluczObcyOceny2;
------------------------------------------
------------------------------------------
ALTER TABLE oceny  
ADD CONSTRAINT KluczObcyOceny1 FOREIGN KEY (IdUcznia) 
REFERENCES uczniowie (IdUcznia)
ON UPDATE CASCADE
ON DELETE CASCADE
GO

ALTER TABLE oceny 
ADD CONSTRAINT KluczObcyOceny2 FOREIGN KEY (IdPrzedmiotu) 
REFERENCES przedmioty (IdPrzedmiotu)
GO


------------------------------------------------------------
------------------------------------------------------------
-----     5 KWEREND UZUPEŁNIAJĄCYCH DANE W TABELI     ------
------------------------------------------------------------

--dodawanie danych do tabeli
--------------------------------------
INSERT INTO [dbo].[przedmioty]
           ([Nazwa], [Opis])
     VALUES
           ('Matematyka', 'Podstawa'),
		   ('Język Angielski', 'Podstawa'),
		   ('Język Angielski', 'Rozszerzenie'),
		   ('Język Niemiecki', 'Podstawa'),
		   ('Fizyka', 'Rozszerzenie'),
		   ('Język Polski', 'Podstawa'),
		   ('Język Polski', 'Rozszerzenie'),
		   ('Biologia', 'Rozszerzenie'),
		   ('Chemia', 'Rozszerzenie'),
		   ('Matematyka', 'Rozszerzenie'),		   
		   ('Informatyka', 'Rozszerzenie'),
		   ('Programowanie w jezyku C++', 'Rozszerzenie'),
		   ('Programowanie w jezyku C#', 'Rozszerzenie'),
		   ('Programowanie w jezyku Java', 'Rozszerzenie'),
		   ('Tworzenie stron internetowych', 'Rozszerzenie'),		   
		   ('Ergonomia', 'Podstawa'),
		   ('BHP', 'Podstawa'),
		   ('EDB', 'Podstawa'),
		   ('Wychowanie Fizyczne', 'Podstawa'),
		   ('Formy Działalności Gospodarczej', 'Podstawa'),		   
		   ('Sieci komputerowe', 'Rozszerzenie'),
		   ('Bazy danych', 'Rozszerzenie'),
		   ('Bezpieczeństwo', 'Rozszerzenie'),
		   ('Administracja Systemami', 'Rozszerzenie'),
		   ('Budowa Komputera Osobistego', 'Podstawa');
GO

--dodawanie danych do tabeli
--------------------------------------
INSERT INTO [dbo].[nauczyciele]
           ([Imie] ,[Nazwisko] ,[Miejscowosc] ,[Ulica] ,[NrDomu_Mieszkania]
           ,[Telefon] ,[IdPrzedmiotu])
     VALUES
           ('Aleksandra', 'Szemet', 'Warszawa', 'Słoneczna', '25a', '600357951', 9),
		   ('Monika', 'Leśniak', 'Warszawa', 'Długa', '147/25', '604736651', 2),
		   ('Marek', 'Leśniak', 'Warszawa', 'Długa', '147/25', '604736651', 1),
		   ('Krystyna', 'Jakubowska', 'Siedlce', 'Ogrodowa', '22', '227274658', 4),
		   ('Edward', 'Goliszek', 'Kielce', 'Różana', '154b', '516357951', 5),
		   ('Adam', 'Kowalski', 'Warszawa', 'Ogrodowa', '55a', '789357331', 6),
		   ('Marcin', 'Kozerski', 'Grójec', 'Narodowa', '6a', '6985456753', 9),
		   ('Alicja', 'Dancewicz', 'Piaseczno', 'KEN', '25/8a', '698369951', 7),
		   ('Zbigniew', 'Niedbała', 'Radom', 'Prosta', '125b', '606987951', 8),
		   ('Renata', 'Jakubczyk', 'Warszawa', 'Wyoska', '99b', '659656561', 10),
		   ('Alicja', 'Nowak', 'Warszawa', 'Wąska', '14/9', '632598789', 20),
		   ('Radosław', 'Nowacki', 'Piaseczno', 'Słoneczna', '365', '669357951', 21),
		   ('Beata', 'Roś', 'Zalesie', 'Nowa', '335a', '69746185', 3),
		   ('Małgorzata', 'Miesiak', 'Piasecznio', 'Powstańców', '69a', '61134851', 22),
		   ('Aneta', 'Maciejszyk', 'Grodzisk', 'Słoneczna', '44d', '8795486544', 10),
		   ('Władysła', 'Raźniak', 'Warka', 'Krótka', '225a', '244577951', 11),
		   ('Aleksandra', 'Ostrowska', 'Warszawa', 'Ursynowska', '125a', '999357951', 13),
		   ('Adam', 'Chmielewski', 'Pieczyska', 'Aleja Prymasa', '32', '696969698', 14),
		   ('Klaudia', 'Budzikur', 'Warszawa', 'Twarda', '65/9', '633000148', 19),
		   ('Sylwia', 'Nowak', 'Warszawa', 'Nowa', '29a', '654456654',20),
		   ('Krzysztof', 'Kubik', 'Warszawa', 'Cienka', '123c', '65478541', 11),
		   ('Krzysztof', 'Kowalski', 'Warszawa', 'Nowa', '63b', '600357951', 16),
		   ('Hania', 'Nowak', 'Warszawa', 'Wspólna', '66', '587412369', 17),
		   ('Ela', 'Hordejuk', 'Wołomin', 'Główna', '23/7', '325642589', 24),
		   ('Olek', 'Kociszewski', 'Mazwiecki', 'Ośla', '254', '6608751', 23);
GO

--dodawanie danych do tabeli
--------------------------------------
INSERT INTO [dbo].[klasy]
			( [Nazwa], [Opis], [Wychowawca] )
		VALUES
			( '3LC', 'Klasa licealna o profilu matematyczno - geograficznym', 7),			
			( '2LC', 'Klasa licealna o profilu matematyczno - geograficznym', 7),
			( '1LC', 'Klasa licealna o profilu matematyczno - geograficznym', 7),
			( '3LB', 'Klasa licealna o profilu matematyczno - fizycznym', 16),
			( '2LB', 'Klasa licealna o profilu matematyczno - fizycznym', 12),
			( '1LB', 'Klasa licealna o profilu matematyczno - fizycznym', 11),			
			( '3LA', 'Klasa licealna o profilu biologiczno - chemicznynym', 25),
			( '2LA', 'Klasa licealna o profilu biologiczno - chemicznynym', 22),
			( '1LA', 'Klasa licealna o profilu biologiczno - chemicznynym', 3),
			( '4TMA', 'Klasa mechatroniczna', 4),
			( '3TMA', 'Klasa mechatroniczna', 14),			
			( '2TMA', 'Klasa mechatroniczna', 17),
			( '1TMA', 'Klasa mechatroniczna', 16),
			( '4TB', 'Klasa informatyczna', 2),
			( '4TA', 'Klasa informatyczna', 1),
			( '3TB', 'Klasa informatyczna', 6),			
			( '3TA', 'Klasa informatyczna', 3),
			( '2TB', 'Klasa informatyczna', 17),
			( '2TA', 'Klasa informatyczna', 18),
			( '1TB', 'Klasa informatyczna', 2),
			( '1TA', 'Klasa informatyczna', 19);
GO

--dodawanie danych do tabeli
--------------------------------------
INSERT INTO [dbo].[uczniowie]
			([Imie], [Nazwisko], [DataUrodzenia], [Miejscowosc], [Ulica], [NrDomu_Mieszkania], [Telefon], [IdKlasy])
		VALUES
			('Adam', 'Chrzanowski', '1991-03-23', 'Warszawa', 'Długa', '23', '48798211367', 7),
			('Marcin', 'Nowakowski', '1991-11-15', 'Warszawa', 'Komisji Edukacji Narodowej', '23a/12', '48732123832', 7),
			('Agnieszka', 'Hołysz', '1991-08-04', 'Grójec', 'Nowa', '23', '48510666823', 7),
			('Aleksandra', 'Kowalska', '1991-06-12', 'Piaseczno', 'Słoneczna', '23/12', '48504878345', 7),
			('Sylwia', 'Pepla', '1991-02-20', 'Zalesie Górne', 'Calineczki', '142', '227274314', 7),
			('Alekandra', 'Łuczak', '1992-07-23', 'Góra Kalwaria', 'Nowowiejska', '161', '48621876249', 19),
			('Adam', 'Myszkowski', '1992-05-17', 'Piaseczno', 'Kalwaryjska', '33/9', '48798621523', 19),
			('Piotr', 'Nowak', '1992-09-20', 'Warszawa', 'Stroma', '22/1', '48453987213', 19),
			('Ewelina', 'Kamińska', '1992-01-08', 'Warszawa', 'Kolorowa', '63', '48671892316', 19),
			('Magdalena', 'Mucha', '1992-02-27', 'Warszawa', 'Marszałkowska', '233a/21', '48765429902', 19),
			('Adam', 'Kowalski', '1996-02-12', 'Grójec', 'Nowa', '23', '48612489547', 10),
			('Anna', 'Moniak', '1996-06-19', 'Mińsk', 'Główna', '11', '48696357480', 10),
			('Kasia', 'Szymańska', '1996-06-03', 'Warszawa', 'Wiśnioowa', '166a', '48602147502', 10),
			('Elwira', 'Szymaniak', '1996-04-30', 'Warszawa', 'Nowowiejska', '23b', '4832569817', 10),
			('Kamil', 'Łysiak', '1996-01-29', 'Warka', 'Bajkowa', '9', '48789147369', 10),
			('Aleksandra', 'Łuczak', '1997-06-15', 'Wicentów', 'Lipowa', '14', '227274147', 4),
			('Katarzyna', 'Łyjak', '1997-09-12', 'Zalesie Dolne', 'Krótka', '71', '48516222444', 4),
			('Aleksander', 'Matysiak', '1997-11-12', 'Łuk', 'Nowa', '147', '48640125874', 4),
			('Mateusz', 'Myszkowski', '1997-04-13', 'Warszawa', 'Działkowa', '3', '48745122365', 4),
			('Tadeusz', 'Łukasiewicz', '1997-12-03', 'Warszawa', 'Racławicka', '247c/14', '48696932114', 4),
			('Michał', 'Chrzanowski', '1998-04-12', 'Czersk', 'Rzymowskiego', '23', '48711285465', 21),
			('Adam', 'Kędzierski', '1998-07-11', 'Półtusk', 'Cybernetyki', '17', '48714852148', 21),
			('Wiesław', 'Skrzypiec', '1998-08-03', 'Warszawa', 'Cyfrowa', '654', '48652147888', 21),
			('Dawid', 'Roś', '1998-04-28', 'Radom', 'Os', '23547/8', '48762647102', 21),
			('Edawrd', 'Szewczyk', '1998-02-21', 'Konstancin', 'Gwiezdna', '23g/21', '48600158471', 21);
GO

--dodawanie danych do tabeli oceny jest na końcu dokumentu ze względu na ilość danych 
--------------------------------------
INSERT INTO [dbo].[oceny]
           ([Ocena], [IdUcznia], [IdPrzedmiotu])
     VALUES
           (3.5, 11, 21);
GO




------------------------------------------------------------
------------------------------------------------------------
-----     5 KWEREND USUWAJĄCYCH DANE Z TABELI     ----------
------------------------------------------------------------

--usunięcie wiersza z tabeli
----------------------------
DELETE FROM przedmioty 
WHERE Nazwa = 'EDB';

--usuwanie kolumny z tabeli
----------------------------
ALTER TABLE nauczyciele
DROP COLUMN Ulica;

--usuwanie kolumny z tabeli
----------------------------
ALTER TABLE klasy
DROP COLUMN Opis;

--usunięcie wiersza z tabeli
----------------------------
DELETE FROM oceny 
WHERE IdOceny = 1;

--usunięcie odwołania do tabeli
----------------------------
ALTER TABLE nauczyciele
DROP CONSTRAINT KluczObcyNauczyciele1;

--usunięcie tabeli
----------------------------
DROP TABLE oceny;
GO

--usunięcie tabeli
----------------------------
TRUNCATE TABLE przedmioty;
GO

--usunięcie bazy danych
----------------------------
DROP DATABASE szkola;
GO


------------------------------------------------------------
------------------------------------------------------------
-----   5 KWEREND AKTUALIZUJACYCH DANE Z TABELI    ---------
------------------------------------------------------------

--zmiana danych w tabeli
----------------------------
UPDATE klasy
SET Nazwa = '3Lc'
WHERE IdKlasy = 3;

--zmiana danych w tabeli
----------------------------
UPDATE klasy
SET Nazwa = '2'
WHERE Nazwa > '3%';

--zmiana danych w tabeli
----------------------------
UPDATE nauczyciele
SET Telefon = '22 72-74-688';

--zmiana typu danych
--------------------------
ALTER TABLE uczniowie
ALTER COLUMN Ulica TEXT NOT NULL;

--zmiana ilosci znaków
----------------------------------
ALTER TABLE uczniowie
ALTER COLUMN Telefon NVARCHAR(20) NOT NULL;



------------------------------------------------------------
------------------------------------------------------------
---------     5 KWEREND WYBIERAJĄCYCH       ----------------
------------------------------------------------------------


--Wypisanie klas i ich wychowawców
-----------------------------------------
SELECT K.Nazwa, K.Opis, N.Nazwisko + ' ' + N.Imie Wychowawca
FROM klasy K JOIN nauczyciele N
ON K.Wychowawca=N.IdNauczyciela
ORDER BY K.Nazwa

--wyswietlenie kolumn NAZWA i OPIS z tabeli, 
--które są posortowane 
-------------------------------------------
SELECT Nazwa as 'Przedmiot', Opis as 'Poziom' 
FROM przedmioty
ORDER BY Nazwa ASC

--Wyświetlenie listy nauczycieli, którzy uczą 
--rozszeżenia w kolejności alfabetycznej
-------------------------------------------
SELECT N.Nazwisko + ' ' + N.Imie as 'Nauczyciel', P.Nazwa as 'Przedmiot', P.Opis as 'Poziom'
FROM przedmioty P JOIN nauczyciele N
	ON N.IdPrzedmiotu=P.IdPrzedmiotu
WHERE P.Opis LIKE 'Roz%'
ORDER BY N.Nazwisko, N.Imie ASC

--Wypisanie w kolejności alfabetycznej 
--uczniów klasami i ich wychowawców
-------------------------------------------
SELECT U.Nazwisko + ' ' + U.Imie Uczen, U.Miejscowosc 'Miejsce zamieszkania', K.Nazwa Klasa, N.Nazwisko + ' ' + N.Imie Wychowawca
FROM uczniowie U JOIN klasy K ON U.IdKlasy=K.IdKlasy
	 JOIN nauczyciele N ON K.Wychowawca=N.IdNauczyciela
ORDER BY K.Nazwa, U.Nazwisko, U.Imie ASC

--Wypisanie w kolejności alfabetycznej 
--przedmioty, uczniów i oceny
-------------------------------------------
SELECT P.Nazwa Przedmiot, U.Nazwisko + ' '+ U.Imie Uczeń, O.Ocena
FROM oceny O JOIN przedmioty P ON O.IdPrzedmiotu=P.IdPrzedmiotu
	JOIN uczniowie U ON O.IdUcznia=U.IdUcznia
ORDER BY P.Nazwa, U.Nazwisko

--Wyświetlenie średniej ocen z przedmiotów
-------------------------------------------
SELECT P.Nazwa Przedmiot, ROUND(AVG(O.Ocena),2) Srednia
FROM oceny O JOIN przedmioty P ON O.IdPrzedmiotu=P.IdPrzedmiotu
	JOIN uczniowie U ON O.IdUcznia=U.IdUcznia
	group by p.Nazwa
Order by p.Nazwa
--Tabela przestawna średnich ocen
-------------------------------------------
SELECT * FROM
(
	SELECT Uczen, Przedmiot, Ocena
	FROM v_oceny 
) as DaneZWidoku
PIVOT (AVG(Ocena) FOR Przedmiot IN (
	[Administracja Systemami], [Bazy danych], [Bezpieczenstwo], 
	[BHP], [Budowa Komputera Osobistego], [Jezyk Angielski], 
	[Jezyk Polski], [Matmatyka], [Programowanie w jezyku C++], 
	[Programowanie w jezyku Java], [Sieci komputerowe], 
	[Tworzenie stron internetowych])
) as PivotPrzedmiotow

--Tabela przestawna średnich ocen z dynamicznymi nagłówkami
---------
DECLARE @PivotNaglowki VARCHAR(MAX) = '';

SELECT 
 @PivotNaglowki = @PivotNaglowki + '[' + Przedmiot + '],'
FROM
	(SELECT DISTINCT Przedmiot
	 FROM v_oceny
	 WHERE Przedmiot IS NOT NULL) tabColors

SET @PivotNaglowki = LEFT(@PivotNaglowki,LEN(@PivotNaglowki)-1)
---------
DECLARE @uruchomPivot VARCHAR(MAX);
SET @uruchomPivot = '
SELECT
 *
FROM
(
	SELECT Uczen, Przedmiot, Ocena
	FROM v_oceny
) AS DaneZWidoku
PIVOT (AVG(Ocena) FOR Przedmiot IN ('+@PivotNaglowki+')) PivotSrednichOcen '
---------
EXECUTE (@uruchomPivot)

--Ilość oceny pięć w widoku v_oceny
---------
SELECT COUNT(V.Ocena) 'Liczba piatek'
FROM v_oceny V
WHERE V.Ocena = 5



------------------------------------------------------------
------------------------------------------------------------
-----------------     5 WIDOKÓW       ----------------------
------------------------------------------------------------

--Utworzenie widoku z danymi tabeli oceny
-------------------------------------------
CREATE VIEW v_oceny 
AS
SELECT P.Nazwa Przedmiot, U.Nazwisko + ' '+ U.Imie Uczen, O.Ocena
FROM oceny O JOIN przedmioty P ON O.IdPrzedmiotu=P.IdPrzedmiotu
			 JOIN uczniowie U  ON O.IdUcznia=U.IdUcznia;
GO

--Utworzenie widoku z danymi osobowymi uczniów i nauczycieli
-------------------------------------------
CREATE VIEW v_daneOsobowe
as
SELECT N.Nazwisko, N.Imie, N.Miejscowosc, N.Ulica, N.NrDomu_Mieszkania as 'Nr domu/Mieszkanie'
FROM nauczyciele N
UNION
SELECT U.Nazwisko, U.Imie, U.Miejscowosc, U.Ulica, U.NrDomu_Mieszkania as 'Nr domu/Mieszkanie'
FROM uczniowie U;
GO

--Utworzenie widoku z listą osób z oceną niedostateczną
-------------------------------------------
CREATE VIEW v_ocena_ndst
as
SELECT U.Nazwisko + ' ' + U.Imie as Uczen, P.Nazwa, P.Opis as Poziom
FROM oceny O JOIN przedmioty P ON O.IdPrzedmiotu=P.IdPrzedmiotu
			 JOIN uczniowie U  ON O.IdUcznia=U.IdUcznia
WHERE O.Ocena < 2;
GO

--Utworzenie widoku z listą osób 
--wychowawców poszczególnych klas
-------------------------------------------
CREATE VIEW v_wychowawcy
as
SELECT K.Nazwa Klasa, N.Nazwisko + ' ' + N.Imie Wychowawca
FROM klasy K JOIN nauczyciele N ON K.Wychowawca=N.IdNauczyciela;
GO

--Liczba uczniów szkoły
-------------------------------------------
CREATE VIEW v_liczb_uczniow
as
SELECT COUNT(U.Nazwisko) as 'Liczba wszystkich uczniow'
FROM uczniowie U JOIN klasy K ON U.IdKlasy=K.IdKlasy;
GO



------------------------------------------------------------
------------------------------------------------------------
----------------     5 PROCEDUR       ----------------------
------------------------------------------------------------

--Procedura wybierania uczniów z oceną 
-------------------------------------------
CREATE PROCEDURE [uczniowie_z_ocena] @ocena float
AS
SELECT	Uczen, 
		Przedmiot
FROM v_oceny
WHERE Ocena = @ocena
ORDER BY Uczen;
GO
---------
---------
EXEC uczniowie_z_ocena 4.5;
GO

--Procedura wybierająca liste osób z klasy
-------------------------------------------
CREATE PROCEDURE [lista_uczniow] @klasa varchar(4)
AS
SELECT U.Nazwisko + ' ' + U.Imie 'Lista:'
FROM uczniowie U JOIN klasy K 
	ON K.IdKlasy=U.IdKlasy
WHERE K.Nazwa LIKE @klasa
ORDER BY U.Nazwisko;
GO
--------------------
--------------------
EXEC lista_uczniow '3la';
GO

--Procedura wypisująca informacje o osobie
-------------------------------------------
CREATE PROCEDURE [inf_o_uczniu] @uczen varchar(20)
AS
SELECT	U.Nazwisko + ' ' + U.Imie Uczen, 
		U.DataUrodzenia 'Data urodzenia', 
		U.Miejscowosc, U.Ulica, U.NrDomu_Mieszkania 'Nr mieszkania', 
		U.Telefon, 
		K.Nazwa Klasa, 
		K.Opis Profil, 
		N.Nazwisko + ' ' + N.Imie Wychowawca
FROM uczniowie U JOIN klasy K ON K.IdKlasy=U.IdKlasy
				 JOIN nauczyciele N ON K.Wychowawca=N.IdNauczyciela
WHERE	U.Nazwisko LIKE (@uczen+'%') OR 
		U.Imie LIKE (@uczen+'%')
GO
-------------------------
-------------------------
EXEC inf_o_uczniu 'Ros';
GO

--Procedura wypisująca średnią z danego przedmiotu
-------------------------------------------
CREATE PROCEDURE [srednia_przdemiotu] @przedmiot varchar(35)
as
SELECT	P.Nazwa Przedmiot, 
		ROUND( AVG(O.Ocena), 2) Srednia
FROM oceny O JOIN przedmioty P ON O.IdPrzedmiotu=P.IdPrzedmiotu
WHERE P.Nazwa LIKE (@przedmiot+'%')
GROUP BY P.Nazwa;
GO
--------------------------------------
EXEC srednia_przdemiotu 'Bazy danych';
GO

--Procedura zwracajaca ucznia z najwyzsza srednia ocen
-------------------------------------------
CREATE PROCEDURE [najwyzsza_srednia]
as
SELECT	TOP(1)
		U.Nazwisko + ' ' + U.Imie Uczen, 
		ROUND(AVG(O.Ocena),2) 'Najwyzsza srednia'
FROM oceny O JOIN uczniowie U ON O.IdUcznia=U.IdUcznia
GROUP BY U.Nazwisko + ' ' + U.Imie
ORDER BY AVG(Ocena) DESC;
GO
-----------------------
EXEC najwyzsza_srednia;
GO

--------------------------------------
--------------------------------------
--dodawanie danych do tabeli
--------------------------------------
INSERT INTO [dbo].[oceny]
           ([Ocena], [IdUcznia], [IdPrzedmiotu])
     VALUES
           (3.5, 11, 21), (3.5, 12, 17), (3.5, 13, 25), (3.5, 14, 24), (3.5, 15, 23), (3.5, 23, 21), (3.5, 24, 17), (3.5, 25, 25), (3.5, 16, 24), (3.5, 7, 23), (3.5, 2, 21), (3.5, 8, 17), (3.5, 6, 25), (3.5, 4, 24), (3.5, 5, 23),
           (3.0, 11, 21), (3.0, 12, 17), (3.0, 13, 25), (3.0, 14, 24), (3.0, 15, 23), (3.0, 23, 21), (3.0, 24, 17), (3.0, 25, 25), (3.0, 16, 24), (3.0, 7, 23), (3.0, 2, 21), (3.0, 8, 17), (3.0, 6, 25), (3.0, 4, 24), (3.0, 5, 23),
           (5.0, 11, 21), (5.0, 12, 17), (5.0, 13, 25), (5.0, 14, 24), (5.0, 15, 23), (5.0, 23, 21), (5.0, 24, 17), (5.0, 25, 25), (5.0, 16, 24), (5.0, 7, 23), (5.0, 2, 21), (5.0, 8, 17), (5.0, 6, 25), (5.0, 4, 24), (5.0, 5, 23),
           (1.0, 11, 21), (1.0, 12, 17), (1.0, 13, 25), (1.0, 14, 24), (1.0, 15, 23), (1.0, 23, 21), (1.0, 24, 17), (1.0, 25, 25), (1.0, 16, 24), (1.0, 7, 23), (1.0, 2, 21), (1.0, 8, 17), (1.0, 6, 25), (1.0, 4, 24), (1.0, 5, 23),
           (2.5, 11, 21), (2.5, 12, 17), (2.5, 13, 25), (2.5, 14, 24), (2.5, 15, 23), (2.5, 23, 21), (2.5, 24, 17), (2.5, 25, 25), (2.5, 16, 24), (2.5, 7, 23), (2.5, 2, 21), (2.5, 8, 17), (2.5, 6, 25), (2.5, 4, 24), (2.5, 5, 23),
           (4.0, 11, 22), (4.0, 12, 21), (4.0, 13, 17), (4.0, 14, 25), (4.0, 15, 24), (4.0, 23, 22), (4.0, 24, 21), (4.0, 25, 17), (4.0, 16, 25), (4.0, 7, 24), (4.0, 2, 22), (4.0, 8, 21), (4.0, 6, 17), (4.0, 4, 25), (4.0, 5, 24),
           (4.0, 11, 22), (4.0, 12, 21), (4.0, 13, 17), (4.0, 14, 25), (4.0, 15, 24), (4.0, 23, 22), (4.0, 24, 21), (4.0, 25, 17), (4.0, 16, 25), (4.0, 7, 24), (4.0, 2, 22), (4.0, 8, 21), (4.0, 6, 17), (4.0, 4, 25), (4.0, 5, 24),
           (4.0, 11, 22), (4.5, 12, 21), (4.0, 13, 17), (4.0, 14, 25), (4.0, 15, 24), (4.0, 23, 22), (4.0, 24, 21), (4.0, 25, 17), (4.0, 16, 25), (4.0, 7, 24), (4.0, 2, 22), (4.0, 8, 21), (4.0, 6, 17), (4.0, 4, 25), (4.0, 5, 24),
           (4.0, 11, 22), (4.0, 12, 21), (4.0, 13, 17), (4.0, 14, 25), (4.0, 15, 24), (4.0, 23, 22), (4.0, 24, 21), (4.0, 25, 17), (4.0, 16, 25), (4.0, 7, 24), (4.0, 2, 22), (4.0, 8, 21), (4.0, 6, 17), (4.0, 4, 25), (4.0, 5, 24),
           (4.0, 11, 22), (4.0, 12, 21), (4.0, 13, 17), (4.0, 14, 25), (4.0, 15, 24), (4.0, 23, 22), (4.0, 24, 21), (4.0, 25, 17), (4.0, 16, 25), (4.0, 7, 24), (4.0, 2, 22), (4.0, 8, 21), (4.0, 6, 17), (4.0, 4, 25), (4.0, 5, 24),
           (2.5, 11, 23), (3.5, 12, 22), (2.5, 13, 21), (2.5, 14, 17), (2.5, 15, 25), (2.5, 23, 23), (2.5, 24, 22), (2.5, 25, 21), (2.5, 16, 17), (2.5, 7, 25), (2.5, 2, 23), (2.5, 8, 22), (2.5, 6, 21), (2.5, 4, 17), (2.5, 5, 25),
           (2.0, 11, 23), (2.0, 12, 22), (2.0, 13, 21), (2.0, 14, 17), (2.0, 15, 25), (2.0, 23, 23), (2.0, 24, 22), (2.0, 25, 21), (2.0, 16, 17), (2.0, 7, 25), (2.0, 2, 23), (2.0, 8, 22), (2.0, 6, 21), (2.0, 4, 17), (2.0, 5, 25),
           (4.5, 11, 23), (4.5, 12, 22), (4.5, 13, 21), (4.5, 14, 17), (4.5, 15, 25), (4.5, 23, 23), (4.5, 24, 22), (4.5, 25, 21), (4.5, 16, 17), (4.5, 7, 25), (4.5, 2, 23), (4.5, 8, 22), (4.5, 6, 21), (4.5, 4, 17), (4.5, 5, 25),
           (3.5, 11, 23), (3.5, 12, 22), (3.5, 13, 21), (3.5, 14, 17), (3.5, 15, 25), (3.5, 23, 23), (3.5, 24, 22), (3.5, 25, 21), (3.5, 16, 17), (3.5, 7, 25), (3.5, 2, 23), (3.5, 8, 22), (3.5, 6, 21), (3.5, 4, 17), (3.5, 5, 25),
           (1.0, 11, 23), (1.0, 12, 22), (1.0, 13, 21), (1.0, 14, 17), (1.0, 15, 25), (1.0, 23, 23), (1.0, 24, 22), (1.0, 25, 21), (1.0, 16, 17), (1.0, 7, 25), (1.0, 2, 23), (1.0, 8, 22), (1.0, 6, 21), (1.0, 4, 17), (1.0, 5, 25),
           (4.5, 11, 24), (4.5, 12, 23), (4.5, 13, 22), (4.5, 14, 21), (4.5, 15, 17), (4.5, 23, 24), (4.5, 24, 23), (4.5, 25, 22), (4.5, 16, 21), (4.5, 7, 17), (4.5, 2, 24), (4.5, 8, 23), (4.5, 6, 22), (4.5, 4, 21), (4.5, 5, 17),
           (5.0, 11, 24), (5.0, 12, 23), (5.0, 13, 22), (5.0, 14, 21), (5.0, 15, 17), (5.0, 23, 24), (5.0, 24, 23), (5.0, 25, 22), (5.0, 16, 21), (5.0, 7, 17), (5.0, 2, 24), (5.0, 8, 23), (5.0, 6, 22), (5.0, 4, 21), (5.0, 5, 17),
           (3.5, 11, 24), (4.5, 12, 23), (3.5, 13, 22), (3.5, 14, 21), (3.5, 15, 17), (3.5, 23, 24), (3.5, 24, 23), (3.5, 25, 22), (3.5, 16, 21), (3.5, 7, 17), (3.5, 2, 24), (3.5, 8, 23), (3.5, 6, 22), (3.5, 4, 21), (3.5, 5, 17),
           (5.0, 11, 24), (5.0, 12, 23), (5.0, 13, 22), (5.0, 14, 21), (5.0, 15, 17), (5.0, 23, 24), (5.0, 24, 23), (5.0, 25, 22), (5.0, 16, 21), (5.0, 7, 17), (5.0, 2, 24), (5.0, 8, 23), (5.0, 6, 22), (5.0, 4, 21), (5.0, 5, 17),
           (5.0, 11, 24), (5.0, 12, 23), (5.0, 13, 22), (5.0, 14, 21), (5.0, 15, 17), (5.0, 23, 24), (5.0, 24, 23), (5.0, 25, 22), (5.0, 16, 21), (5.0, 7, 17), (5.0, 2, 24), (5.0, 8, 23), (5.0, 6, 22), (5.0, 4, 21), (5.0, 5, 17),
           (3.5, 11, 25), (3.5, 12, 24), (3.5, 13, 23), (3.5, 14, 22), (3.5, 15, 21), (3.5, 23, 25), (3.5, 24, 24), (3.5, 25, 23), (3.5, 16, 22), (3.5, 7, 21), (3.5, 2, 25), (3.5, 8, 24), (3.5, 6, 23), (3.5, 4, 22), (3.5, 5, 21),
           (4.5, 11, 25), (4.5, 12, 24), (4.5, 13, 23), (4.5, 14, 22), (4.5, 15, 21), (4.5, 23, 25), (4.5, 24, 24), (4.5, 25, 23), (4.5, 16, 22), (4.5, 7, 21), (4.5, 2, 25), (4.5, 8, 24), (4.5, 6, 23), (4.5, 4, 22), (4.5, 5, 21),
           (5.0, 11, 25), (5.0, 12, 24), (5.0, 13, 23), (5.0, 14, 22), (5.0, 15, 21), (5.0, 23, 25), (5.0, 24, 24), (5.0, 25, 23), (5.0, 16, 22), (5.0, 7, 21), (5.0, 2, 25), (5.0, 8, 24), (5.0, 6, 23), (5.0, 4, 22), (5.0, 5, 21),
           (4.0, 11, 25), (4.0, 12, 24), (4.0, 13, 23), (4.0, 14, 22), (4.0, 15, 21), (4.0, 23, 25), (4.0, 24, 24), (4.0, 25, 23), (4.0, 16, 22), (4.0, 7, 21), (4.0, 2, 25), (4.0, 8, 24), (4.0, 6, 23), (4.0, 4, 22), (4.0, 5, 21),
           (4.0, 11, 25), (4.0, 12, 24), (4.0, 13, 23), (4.0, 14, 22), (4.0, 15, 21), (4.0, 23, 25), (4.0, 24, 24), (4.0, 25, 23), (4.0, 16, 22), (4.0, 7, 21), (4.0, 2, 25), (4.0, 8, 24), (4.0, 6, 23), (4.0, 4, 22), (4.0, 5, 21),
		   (3.5, 11, 17), (3.5, 12, 25), (3.5, 13, 24), (3.5, 14, 23), (3.5, 15, 22), (3.5, 23, 17), (3.5, 24, 25), (3.5, 25, 24), (3.5, 16, 23), (3.5, 7, 22), (3.5, 2, 17), (3.5, 8, 25), (3.5, 6, 24), (3.5, 4, 23), (3.5, 5, 22),
           (2.5, 11, 17), (3.5, 12, 25), (2.5, 13, 24), (2.5, 14, 23), (2.5, 15, 22), (2.5, 23, 17), (2.5, 24, 25), (2.5, 25, 24), (2.5, 16, 23), (2.5, 7, 22), (2.5, 2, 17), (2.5, 8, 25), (2.5, 6, 24), (2.5, 4, 23), (2.5, 5, 22),
           (5.0, 11, 17), (5.0, 12, 25), (5.0, 13, 24), (5.0, 14, 23), (5.0, 15, 22), (5.0, 23, 17), (5.0, 24, 25), (5.0, 25, 24), (5.0, 16, 23), (5.0, 7, 22), (5.0, 2, 17), (5.0, 8, 25), (5.0, 6, 24), (5.0, 4, 23), (5.0, 5, 22),
           (4.0, 11, 17), (4.0, 12, 25), (4.0, 13, 24), (4.0, 14, 23), (4.0, 15, 22), (4.0, 23, 17), (4.0, 24, 25), (4.0, 25, 24), (4.0, 16, 23), (4.0, 7, 22), (4.0, 2, 17), (4.0, 8, 25), (4.0, 6, 24), (4.0, 4, 23), (4.0, 5, 22),
           (4.5, 11, 17), (4.5, 12, 25), (4.5, 13, 24), (4.5, 14, 23), (4.5, 15, 22), (4.5, 23, 17), (4.5, 24, 25), (4.5, 25, 24), (4.5, 16, 23), (4.5, 7, 22), (4.5, 2, 17), (4.5, 8, 25), (4.5, 6, 24), (4.5, 4, 23), (4.5, 5, 22),
		   (3.5, 11, 12), (3.5, 12, 14), (3.5, 13, 1), (3.5, 14, 3), (3.5, 15, 7), (3.5, 23, 12), (3.5, 24, 14), (3.5, 25, 1), (3.5, 16, 3), (3.5, 7, 7), (3.5, 2, 12), (3.5, 8, 14), (3.5, 6, 1), (3.5, 4, 3), (3.5, 5, 7),
		   (3.0, 11, 12), (3.0, 12, 14), (3.0, 13, 1), (3.0, 14, 3), (3.0, 15, 7), (3.0, 23, 12), (3.0, 24, 14), (3.0, 25, 1), (3.0, 16, 3), (3.0, 7, 7), (3.0, 2, 12), (3.0, 8, 14), (3.0, 6, 1), (3.0, 4, 3), (3.0, 5, 7),
		   (5.0, 11, 12), (5.0, 12, 14), (5.0, 13, 1), (5.0, 14, 3), (5.0, 15, 7), (5.0, 23, 12), (5.0, 24, 14), (5.0, 25, 1), (5.0, 16, 3), (5.0, 7, 7), (5.0, 2, 12), (5.0, 8, 14), (5.0, 6, 1), (5.0, 4, 3), (5.0, 5, 7),
		   (1.0, 11, 12), (1.0, 12, 14), (1.0, 13, 1), (1.0, 14, 3), (1.0, 15, 7), (1.0, 23, 12), (1.0, 24, 14), (1.0, 25, 1), (1.0, 16, 3), (1.0, 7, 7), (1.0, 2, 12), (1.0, 8, 14), (1.0, 6, 1), (1.0, 4, 3), (1.0, 5, 7),
		   (2.5, 11, 12), (2.5, 12, 14), (2.5, 13, 1), (2.5, 14, 3), (2.5, 15, 7), (2.5, 23, 12), (2.5, 24, 14), (2.5, 25, 1), (2.5, 16, 3), (2.5, 7, 7), (2.5, 2, 12), (2.5, 8, 14), (2.5, 6, 1), (2.5, 4, 3), (2.5, 5, 7),
		   (4.0, 11, 15), (4.0, 12, 12), (4.0, 13, 14), (4.0, 14, 1), (4.0, 15, 3), (4.0, 23, 15), (4.0, 24, 12), (4.0, 25, 14), (4.0, 16, 1), (4.0, 7, 3), (4.0, 2, 15), (4.0, 8, 12), (4.0, 6, 14), (4.0, 4, 1), (4.0, 5, 3),
		   (4.0, 11, 15), (4.0, 12, 12), (4.0, 13, 14), (4.0, 14, 1), (4.0, 15, 3), (4.0, 23, 15), (4.0, 24, 12), (4.0, 25, 14), (4.0, 16, 1), (4.0, 7, 3), (4.0, 2, 15), (4.0, 8, 12), (4.0, 6, 14), (4.0, 4, 1), (4.0, 5, 3),
		   (4.0, 11, 15), (4.0, 12, 12), (4.0, 13, 14), (4.0, 14, 1), (4.0, 15, 3), (4.0, 23, 15), (4.0, 24, 12), (4.0, 25, 14), (4.0, 16, 1), (4.0, 7, 3), (4.0, 2, 15), (4.0, 8, 12), (4.0, 6, 14), (4.0, 4, 1), (4.0, 5, 3),
		   (4.0, 11, 15), (4.0, 12, 12), (4.0, 13, 14), (4.0, 14, 1), (4.0, 15, 3), (4.0, 23, 15), (4.0, 24, 12), (4.0, 25, 14), (4.0, 16, 1), (4.0, 7, 3), (4.0, 2, 15), (4.0, 8, 12), (4.0, 6, 14), (4.0, 4, 1), (4.0, 5, 3),
		   (4.0, 11, 15), (4.0, 12, 12), (4.0, 13, 14), (4.0, 14, 1), (4.0, 15, 3), (4.0, 23, 15), (4.0, 24, 12), (4.0, 25, 14), (4.0, 16, 1), (4.0, 7, 3), (4.0, 2, 15), (4.0, 8, 12), (4.0, 6, 14), (4.0, 4, 1), (4.0, 5, 3),
		   (2.5, 11, 7), (2.5, 12, 15), (2.5, 13, 12), (2.5, 14, 14), (2.5, 15, 1), (2.5, 23, 7), (2.5, 24, 15), (2.5, 25, 12), (2.5, 16, 14), (2.5, 7, 1), (2.5, 2, 7), (2.5, 8, 15), (2.5, 6, 12), (2.5, 4, 14), (2.5, 5, 1),
		   (2.0, 11, 7), (2.0, 12, 15), (2.0, 13, 12), (2.0, 14, 14), (2.0, 15, 1), (2.0, 23, 7), (2.0, 24, 15), (2.0, 25, 12), (2.0, 16, 14), (2.0, 7, 1), (2.0, 2, 7), (2.0, 8, 15), (2.0, 6, 12), (2.0, 4, 14), (2.0, 5, 1),
		   (4.5, 11, 7), (4.5, 12, 15), (4.5, 13, 12), (4.5, 14, 14), (4.5, 15, 1), (4.5, 23, 7), (4.5, 24, 15), (4.5, 25, 12), (4.5, 16, 14), (4.5, 7, 1), (4.5, 2, 7), (4.5, 8, 15), (4.5, 6, 12), (4.5, 4, 14), (4.5, 5, 1),
		   (3.5, 11, 7), (3.5, 12, 15), (3.5, 13, 12), (3.5, 14, 14), (3.5, 15, 1), (3.5, 23, 7), (3.5, 24, 15), (3.5, 25, 12), (3.5, 16, 14), (3.5, 7, 1), (3.5, 2, 7), (3.5, 8, 15), (3.5, 6, 12), (3.5, 4, 14), (3.5, 5, 1),
		   (1.0, 11, 7), (1.0, 12, 15), (1.0, 13, 12), (1.0, 14, 14), (1.0, 15, 1), (1.0, 23, 7), (1.0, 24, 15), (1.0, 25, 12), (1.0, 16, 14), (1.0, 7, 1), (1.0, 2, 7), (1.0, 8, 15), (1.0, 6, 12), (1.0, 4, 14), (1.0, 5, 1),
		   (4.5, 11, 3), (4.5, 12, 7), (4.5, 13, 15), (4.5, 14, 12), (4.5, 15, 14), (4.5, 23, 3), (4.5, 24, 7), (4.5, 25, 15), (4.5, 16, 12), (4.5, 7, 14), (4.5, 2, 3), (4.5, 8, 7), (4.5, 6, 15), (4.5, 4, 12), (4.5, 5, 14),
		   (5.0, 11, 3), (5.0, 12, 7), (5.0, 13, 15), (5.0, 14, 12), (5.0, 15, 14), (5.0, 23, 3), (5.0, 24, 7), (5.0, 25, 15), (5.0, 16, 12), (5.0, 7, 14), (5.0, 2, 3), (5.0, 8, 7), (5.0, 6, 15), (5.0, 4, 12), (5.0, 5, 14),
		   (3.5, 11, 3), (3.5, 12, 7), (3.5, 13, 15), (3.5, 14, 12), (3.5, 15, 14), (3.5, 23, 3), (3.5, 24, 7), (3.5, 25, 15), (3.5, 16, 12), (3.5, 7, 14), (3.5, 2, 3), (3.5, 8, 7), (3.5, 6, 15), (3.5, 4, 12), (3.5, 5, 14),
		   (5.0, 11, 3), (5.0, 12, 7), (5.0, 13, 15), (5.0, 14, 12), (5.0, 15, 14), (5.0, 23, 3), (5.0, 24, 7), (5.0, 25, 15), (5.0, 16, 12), (5.0, 7, 14), (5.0, 2, 3), (5.0, 8, 7), (5.0, 6, 15), (5.0, 4, 12), (5.0, 5, 14),
		   (5.0, 11, 3), (5.0, 12, 7), (5.0, 13, 15), (5.0, 14, 12), (5.0, 15, 14), (5.0, 23, 3), (5.0, 24, 7), (5.0, 25, 15), (5.0, 16, 12), (5.0, 7, 14), (5.0, 2, 3), (5.0, 8, 7), (5.0, 6, 15), (5.0, 4, 12), (5.0, 5, 14),
		   (3.5, 11, 1), (3.5, 12, 3), (3.5, 13, 7), (3.5, 14, 15), (3.5, 15, 12), (3.5, 23, 1), (3.5, 24, 3), (3.5, 25, 7), (3.5, 16, 15), (3.5, 7, 12), (3.5, 2, 1), (3.5, 8, 3), (3.5, 6, 7), (3.5, 4, 15), (3.5, 5, 12),
		   (4.5, 11, 1), (4.5, 12, 3), (4.5, 13, 7), (4.5, 14, 15), (4.5, 15, 12), (4.5, 23, 1), (4.5, 24, 3), (4.5, 25, 7), (4.5, 16, 15), (4.5, 7, 12), (4.5, 2, 1), (4.5, 8, 3), (4.5, 6, 7), (4.5, 4, 15), (4.5, 5, 12),
		   (5.0, 11, 1), (5.0, 12, 3), (5.0, 13, 7), (5.0, 14, 15), (5.0, 15, 12), (5.0, 23, 1), (5.0, 24, 3), (5.0, 25, 7), (5.0, 16, 15), (5.0, 7, 12), (5.0, 2, 1), (5.0, 8, 3), (5.0, 6, 7), (5.0, 4, 15), (5.0, 5, 12),
		   (4.0, 11, 1), (4.0, 12, 3), (4.0, 13, 7), (4.0, 14, 15), (4.0, 15, 12), (4.0, 23, 1), (4.0, 24, 3), (4.0, 25, 7), (4.0, 16, 15), (4.0, 7, 12), (4.0, 2, 1), (4.0, 8, 3), (4.0, 6, 7), (4.0, 4, 15), (4.0, 5, 12),
		   (4.0, 11, 1), (4.0, 12, 3), (4.0, 13, 7), (4.0, 14, 15), (4.0, 15, 12), (4.0, 23, 1), (4.0, 24, 3), (4.0, 25, 7), (4.0, 16, 15), (4.0, 7, 12), (4.0, 2, 1), (4.0, 8, 3), (4.0, 6, 7), (4.0, 4, 15), (4.0, 5, 12),
		   (3.5, 11, 14), (3.5, 12, 1), (3.5, 13, 3), (3.5, 14, 7), (3.5, 15, 15), (3.5, 23, 14), (3.5, 24, 1), (3.5, 25, 3), (3.5, 16, 7), (3.5, 7, 15), (3.5, 2, 14), (3.5, 8, 1), (3.5, 6, 3), (3.5, 4, 7), (3.5, 5, 15),
		   (2.5, 11, 14), (2.5, 12, 1), (2.5, 13, 3), (2.5, 14, 7), (2.5, 15, 15), (2.5, 23, 14), (2.5, 24, 1), (2.5, 25, 3), (2.5, 16, 7), (2.5, 7, 15), (2.5, 2, 14), (2.5, 8, 1), (2.5, 6, 3), (2.5, 4, 7), (2.5, 5, 15),
		   (5.0, 11, 14), (5.0, 12, 1), (5.0, 13, 3), (5.0, 14, 7), (5.0, 15, 15), (5.0, 23, 14), (5.0, 24, 1), (5.0, 25, 3), (5.0, 16, 7), (5.0, 7, 15), (5.0, 2, 14), (5.0, 8, 1), (5.0, 6, 3), (5.0, 4, 7), (5.0, 5, 15),
		   (4.0, 11, 14), (4.0, 12, 1), (4.0, 13, 3), (4.0, 14, 7), (4.0, 15, 15), (4.0, 23, 14), (4.0, 24, 1), (4.0, 25, 3), (4.0, 16, 7), (4.0, 7, 15), (4.0, 2, 14), (4.0, 8, 1), (4.0, 6, 3), (4.0, 4, 7), (4.0, 5, 15),
		   (4.5, 11, 14), (4.5, 12, 1), (4.5, 13, 3), (4.5, 14, 7), (4.5, 15, 15), (4.5, 23, 14), (4.5, 24, 1), (4.5, 25, 3), (4.5, 16, 7), (4.5, 7, 15), (4.5, 2, 14), (4.5, 8, 1), (4.5, 6, 3), (4.5, 4, 7), (4.5, 5, 15);
		   
GO