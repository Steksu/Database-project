
CREATE TABLE adresy (
    id_adresu               INTEGER NOT NULL,
    ulica                   VARCHAR2(50 CHAR),
    nr_lokalu               VARCHAR2(50 CHAR) NOT NULL,
    kod_adres_kod_pocztowy VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE adresy ADD CONSTRAINT adresy_pk PRIMARY KEY ( id_adresu );

CREATE TABLE badania (
    id_badania                   INTEGER NOT NULL,
    nazwa_badania                VARCHAR2(70 CHAR) NOT NULL,
    opis_badania                 VARCHAR2(150 CHAR) NOT NULL,
    wyniki_badan_id_wyniki_badan INTEGER
);

ALTER TABLE badania ADD CONSTRAINT badania_pk PRIMARY KEY ( id_badania );

CREATE TABLE dokumentacja_medyczna (
    id_dokumentacja_medyczna INTEGER NOT NULL,
    pacjenci_id_pacjenta     INTEGER NOT NULL
);

ALTER TABLE dokumentacja_medyczna ADD CONSTRAINT dokumentacja_medyczna_pk PRIMARY KEY ( id_dokumentacja_medyczna );

CREATE TABLE kod_adres (
    kod_pocztowy VARCHAR2(50 CHAR) NOT NULL,
    miasto       VARCHAR2(50 CHAR) NOT NULL,
    wojewodztwo  VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE kod_adres ADD CONSTRAINT kod_pocztowy_pk PRIMARY KEY ( kod_pocztowy );

CREATE TABLE leki (
    id_leki    INTEGER NOT NULL,
    nazwa_leku VARCHAR2(50) NOT NULL
);

ALTER TABLE leki ADD CONSTRAINT leki_pk PRIMARY KEY ( id_leki );

CREATE TABLE pacjenci (
    id_pacjenta                INTEGER NOT NULL,
    imie                       VARCHAR2(50 CHAR) NOT NULL,
    nazwisko                   VARCHAR2(70 CHAR) NOT NULL,
    data_urodzenia             DATE NOT NULL,
    pesel                      VARCHAR2(50 CHAR) NOT NULL,
    numer_telefonu             VARCHAR2(50 CHAR) NOT NULL,
    uprawnienia_id_uprawnienia INTEGER NOT NULL,
    adresy_id_adresu           INTEGER NOT NULL
);

ALTER TABLE pacjenci ADD CONSTRAINT pacjenci_pk PRIMARY KEY ( id_pacjenta );

CREATE TABLE pracownicy (
    id_pracownika           INTEGER NOT NULL,
    imie                    VARCHAR2(50 CHAR) NOT NULL,
    nazwisko                VARCHAR2(70 CHAR) NOT NULL,
    telefon                 VARCHAR2(40 CHAR) NOT NULL,
    rola_pracownika_id_rola INTEGER NOT NULL,
    adresy_id_adresu        INTEGER NOT NULL
);

ALTER TABLE pracownicy ADD CONSTRAINT pracownicy_pk PRIMARY KEY ( id_pracownika );

CREATE TABLE recepty (
    id_recepty               INTEGER NOT NULL,
    data_wystawienia         DATE NOT NULL,
    opis_recepty             VARCHAR2(150 CHAR),
    pracownicy_id_pracownika INTEGER NOT NULL
);

ALTER TABLE recepty ADD CONSTRAINT recepty_pk PRIMARY KEY ( id_recepty );

CREATE TABLE recepty_leki (
    recepty_id_recepty INTEGER NOT NULL,
    leki_id_leki       INTEGER NOT NULL
);

CREATE TABLE rejestracja (
    id_wizyty                  INTEGER NOT NULL,
    data_wizyty                DATE NOT NULL,
    godzina_rozpoczecia        TIMESTAMP NOT NULL,
    godzina_zakonczenia        TIMESTAMP,
    opis_wizyty                VARCHAR2(150 CHAR),
    status_wizyty              VARCHAR2(50 CHAR) NOT NULL,
    skierowania_id_skierowania INTEGER,
    recepty_id_recepty         INTEGER,
    badania_id_badania         INTEGER,
    pracownicy_id_pracownika   INTEGER NOT NULL,
    pacjenci_id_pacjenta       INTEGER NOT NULL
);

ALTER TABLE rejestracja ADD CONSTRAINT rejestracja_pk PRIMARY KEY ( id_wizyty );

CREATE TABLE rola_pracownika (
    id_rola_pracownika INTEGER NOT NULL,
    stanowisko         VARCHAR2(50 CHAR) NOT NULL,
    specjalizacja      VARCHAR2(50 CHAR)
);

ALTER TABLE rola_pracownika ADD CONSTRAINT rola_pracownika_pk PRIMARY KEY ( id_rola_pracownika );

CREATE TABLE skierowania (
    id_skierowania      INTEGER NOT NULL,
    data_wystawienia    DATE NOT NULL,
    numer_skierowania   INTEGER NOT NULL,
    opis_skierowania    VARCHAR2(150 CHAR),
    miejsce_skierowania VARCHAR2(70 CHAR) NOT NULL
);

ALTER TABLE skierowania ADD CONSTRAINT skierowania_pk PRIMARY KEY ( id_skierowania );

CREATE TABLE uprawnienia (
    id_uprawnienia    INTEGER NOT NULL,
    nazwa_uprawnienia VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE uprawnienia ADD CONSTRAINT uprawnienia_pk PRIMARY KEY ( id_uprawnienia );

CREATE TABLE uprawnienia_pracownicy (
    pracownicy_id_pracownika   INTEGER NOT NULL,
    uprawnienia_id_uprawnienia INTEGER NOT NULL
);

CREATE TABLE wyniki_badan (
    id_wyniki_badan INTEGER NOT NULL,
    opis_wyniku     VARCHAR2(100 CHAR) NOT NULL
);

ALTER TABLE wyniki_badan ADD CONSTRAINT wyniki_badan_pk PRIMARY KEY ( id_wyniki_badan );

ALTER TABLE adresy
    ADD CONSTRAINT adresy_kod_adres_fk FOREIGN KEY ( kod_adres_kod_pocztowy )
        REFERENCES kod_adres ( kod_pocztowy );

ALTER TABLE badania
    ADD CONSTRAINT badania_wyniki_badan_fk FOREIGN KEY ( wyniki_badan_id_wyniki_badan )
        REFERENCES wyniki_badan ( id_wyniki_badan );

ALTER TABLE dokumentacja_medyczna
    ADD CONSTRAINT dok_med_pacjenci_fk FOREIGN KEY ( pacjenci_id_pacjenta )
        REFERENCES pacjenci ( id_pacjenta );

ALTER TABLE pacjenci
    ADD CONSTRAINT pacjenci_adresy_fk FOREIGN KEY ( adresy_id_adresu )
        REFERENCES adresy ( id_adresu );

ALTER TABLE pacjenci
    ADD CONSTRAINT pacjenci_uprawnienia_fk FOREIGN KEY ( uprawnienia_id_uprawnienia )
        REFERENCES uprawnienia ( id_uprawnienia );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_adresy_fk FOREIGN KEY ( adresy_id_adresu )
        REFERENCES adresy ( id_adresu );

ALTER TABLE pracownicy
    ADD CONSTRAINT pracownicy_rola_pracownika_fk FOREIGN KEY ( rola_pracownika_id_rola )
        REFERENCES rola_pracownika ( id_rola_pracownika );

ALTER TABLE recepty_leki
    ADD CONSTRAINT recepty_leki_leki_fk FOREIGN KEY ( leki_id_leki )
        REFERENCES leki ( id_leki );

ALTER TABLE recepty_leki
    ADD CONSTRAINT recepty_leki_recepty_fk FOREIGN KEY ( recepty_id_recepty )
        REFERENCES recepty ( id_recepty );

ALTER TABLE recepty
    ADD CONSTRAINT recepty_pracownicy_fk FOREIGN KEY ( pracownicy_id_pracownika )
        REFERENCES pracownicy ( id_pracownika );

ALTER TABLE rejestracja
    ADD CONSTRAINT rejestracja_badania_fk FOREIGN KEY ( badania_id_badania )
        REFERENCES badania ( id_badania );

ALTER TABLE rejestracja
    ADD CONSTRAINT rejestracja_pacjenci_fk FOREIGN KEY ( pacjenci_id_pacjenta )
        REFERENCES pacjenci ( id_pacjenta );

ALTER TABLE rejestracja
    ADD CONSTRAINT rejestracja_pracownicy_fk FOREIGN KEY ( pracownicy_id_pracownika )
        REFERENCES pracownicy ( id_pracownika );

ALTER TABLE rejestracja
    ADD CONSTRAINT rejestracja_recepty_fk FOREIGN KEY ( recepty_id_recepty )
        REFERENCES recepty ( id_recepty );

ALTER TABLE rejestracja
    ADD CONSTRAINT rejestracja_skierowania_fk FOREIGN KEY ( skierowania_id_skierowania )
        REFERENCES skierowania ( id_skierowania );

ALTER TABLE uprawnienia_pracownicy
    ADD CONSTRAINT upr_prac_pracownicy_fk FOREIGN KEY ( pracownicy_id_pracownika )
        REFERENCES pracownicy ( id_pracownika );

ALTER TABLE uprawnienia_pracownicy
    ADD CONSTRAINT upr_prac_uprawnienia_fk FOREIGN KEY ( uprawnienia_id_uprawnienia )
        REFERENCES uprawnienia ( id_uprawnienia );


ALTER SESSION set NLS_DATE_FORMAT = 'DD-MM-YYYY';
ALTER SESSION SET NLS_TIMESTAMP_FORMAT = 'HH24:MI';

INSERT INTO uprawnienia (id_uprawnienia, nazwa_uprawnienia)
VALUES (1, 'Przeglądanie wyników badań');

INSERT INTO uprawnienia (id_uprawnienia, nazwa_uprawnienia)
VALUES (2, 'Wystawianie recepty');

INSERT INTO uprawnienia (id_uprawnienia, nazwa_uprawnienia)
VALUES (3, 'Edycja wizyty');

INSERT INTO uprawnienia (id_uprawnienia, nazwa_uprawnienia)
VALUES (4, 'Przeglądanie dokumentacji medycznej');

INSERT INTO uprawnienia (id_uprawnienia, nazwa_uprawnienia)
VALUES (5, 'Edytowanie dokumentacji medycznej');

INSERT INTO kod_adres (kod_pocztowy, miasto, wojewodztwo)
VALUES ('00-000', 'Warszawa', 'Mazowieckie');

INSERT INTO kod_adres (kod_pocztowy, miasto, wojewodztwo)
VALUES ('11-111', 'Kraków', 'Małopolskie');

INSERT INTO kod_adres (kod_pocztowy, miasto, wojewodztwo)
VALUES ('22-222', 'Poznań', 'Wielkopolskie');

INSERT INTO kod_adres (kod_pocztowy, miasto, wojewodztwo)
VALUES ('33-333', 'Gdańsk', 'Pomorskie');

INSERT INTO kod_adres (kod_pocztowy, miasto, wojewodztwo)
VALUES ('44-444', 'Wrocław', 'Dolnośląskie');

INSERT INTO adresy (id_adresu, ulica, nr_lokalu, kod_adres_kod_pocztowy)
VALUES (1, 'ul. Krakowska', '101a', '00-000');

INSERT INTO adresy (id_adresu, ulica, nr_lokalu, kod_adres_kod_pocztowy)
VALUES (2, 'ul. Warszawska', '232', '11-111');

INSERT INTO adresy (id_adresu, ulica, nr_lokalu, kod_adres_kod_pocztowy)
VALUES (3, 'ul. Poznańska', '365', '22-222');

INSERT INTO adresy (id_adresu, ulica, nr_lokalu, kod_adres_kod_pocztowy)
VALUES (4, 'ul. Gdańska', '443', '33-333');

INSERT INTO adresy (id_adresu, ulica, nr_lokalu, kod_adres_kod_pocztowy)
VALUES (5, 'ul. Wrocławska', '522', '44-444');

INSERT INTO pacjenci (id_pacjenta, imie, nazwisko, data_urodzenia, pesel, numer_telefonu, uprawnienia_id_uprawnienia, adresy_id_adresu)
VALUES (1, 'Jan', 'Kowalski', '11–01–1999', '12345678901', '123-456-789', 1, 1);

INSERT INTO pacjenci (id_pacjenta, imie, nazwisko, data_urodzenia, pesel, numer_telefonu, uprawnienia_id_uprawnienia, adresy_id_adresu)
VALUES (2, 'Anna', 'Nowak', '02–02–2000', '23456789012', '234-567-890', 1, 2);

INSERT INTO pacjenci (id_pacjenta, imie, nazwisko, data_urodzenia, pesel, numer_telefonu, uprawnienia_id_uprawnienia, adresy_id_adresu)
VALUES (3, 'Piotr', 'Wiśniewski', '03–03–2001', '34567890123', '345-678-901', 1, 3);

INSERT INTO pacjenci (id_pacjenta, imie, nazwisko, data_urodzenia, pesel, numer_telefonu, uprawnienia_id_uprawnienia, adresy_id_adresu)
VALUES (4, 'Katarzyna', 'Dąbrowska', '11–04–2002', '45678901234', '456-789-012', 1, 4);

INSERT INTO pacjenci (id_pacjenta, imie, nazwisko, data_urodzenia, pesel, numer_telefonu, uprawnienia_id_uprawnienia, adresy_id_adresu)
VALUES (5, 'Marcin', 'Kwiatkowski', '08–06–2003', '56789012345', '567-890-123', 1, 5);

INSERT INTO dokumentacja_medyczna (id_dokumentacja_medyczna, pacjenci_id_pacjenta)
VALUES (1, 1);

INSERT INTO dokumentacja_medyczna (id_dokumentacja_medyczna, pacjenci_id_pacjenta)
VALUES (2, 2);

INSERT INTO dokumentacja_medyczna (id_dokumentacja_medyczna, pacjenci_id_pacjenta)
VALUES (3, 3);

INSERT INTO dokumentacja_medyczna (id_dokumentacja_medyczna, pacjenci_id_pacjenta)
VALUES (4, 4);

INSERT INTO dokumentacja_medyczna (id_dokumentacja_medyczna, pacjenci_id_pacjenta)
VALUES (5, 5);

INSERT INTO rola_pracownika (id_Rola_pracownika, stanowisko, specjalizacja)
VALUES (1, 'Lekarz', 'Dermatolog');

INSERT INTO rola_pracownika (id_Rola_pracownika, stanowisko, specjalizacja)
VALUES (2, 'Pielęgniarka', NULL);

INSERT INTO rola_pracownika (id_Rola_pracownika, stanowisko, specjalizacja)
VALUES (3, 'Recepcjonista', NULL);

INSERT INTO rola_pracownika (id_Rola_pracownika, stanowisko, specjalizacja)
VALUES (4, 'Lekarz', 'Kardiolog');

INSERT INTO rola_pracownika (id_Rola_pracownika, stanowisko, specjalizacja)
VALUES (5, 'Lekarz', 'Okulista');

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, telefon, rola_pracownika_id_rola, adresy_id_adresu)
VALUES (1, 'Jan', 'Kowalski', '123-456-789', 1, 1);

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, telefon, rola_pracownika_id_rola, adresy_id_adresu)
VALUES (2, 'Anna', 'Nowak', '234-567-890', 2, 2);

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, telefon, rola_pracownika_id_rola, adresy_id_adresu)
VALUES (3, 'Piotr', 'Wiśniewski', '345-678-901', 3, 3);

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, telefon, rola_pracownika_id_rola, adresy_id_adresu)
VALUES (4, 'Henryk', 'Knot', '234-567-890', 4, 4);

INSERT INTO pracownicy (id_pracownika, imie, nazwisko, telefon, rola_pracownika_id_rola, adresy_id_adresu)
VALUES (5, 'Grażyna', 'Garncarz', '345-678-901', 5, 5);

INSERT INTO leki (id_leki, nazwa_leku)
VALUES (1, 'Paracetamol');

INSERT INTO leki (id_leki, nazwa_leku)
VALUES (2, 'Ibuprofen');

INSERT INTO leki (id_leki, nazwa_leku)
VALUES (3, 'Aspiryna');

INSERT INTO leki (id_leki, nazwa_leku)
VALUES (4, 'Apap');

INSERT INTO leki (id_leki, nazwa_leku)
VALUES (5, 'Acetaminophen');


INSERT INTO recepty (id_recepty, data_wystawienia, opis_recepty, pracownicy_id_pracownika)
VALUES (1, '11–01–2022', 'Recepta na lek przeciwbólowy', 5);

INSERT INTO recepty (id_recepty, data_wystawienia, opis_recepty, pracownicy_id_pracownika)
VALUES (2, '02–02–2022', 'Recepta na lek przeciwalergiczny', 1);

INSERT INTO recepty (id_recepty, data_wystawienia, opis_recepty, pracownicy_id_pracownika)
VALUES (3, '03–03–2022', 'Recepta na lek przeciwzapalny', 4);

INSERT INTO recepty (id_recepty, data_wystawienia, opis_recepty, pracownicy_id_pracownika)
VALUES (4, '11–04–2022', 'Recepta na lek przeciwhistaminowy', 4);

INSERT INTO recepty (id_recepty, data_wystawienia, opis_recepty, pracownicy_id_pracownika)
VALUES (5, '08–06–2022', 'Recepta na lek przeciwbakteryjny', 5);

INSERT INTO recepty_leki (recepty_id_recepty, leki_id_leki)
VALUES (1, 1);

INSERT INTO recepty_leki (recepty_id_recepty, leki_id_leki)
VALUES (2, 2);

INSERT INTO recepty_leki (recepty_id_recepty, leki_id_leki)
VALUES (3, 3);

INSERT INTO recepty_leki (recepty_id_recepty, leki_id_leki)
VALUES (4, 4);

INSERT INTO recepty_leki (recepty_id_recepty, leki_id_leki)
VALUES (5, 5);

INSERT INTO skierowania (id_skierowania, data_wystawienia, numer_skierowania, opis_skierowania, miejsce_skierowania)
VALUES (1, '01–01–2022', 101, 'Skierowanie do kardiologa', 'Centrum Medyczne Medyk Rzeszów');

INSERT INTO skierowania (id_skierowania, data_wystawienia, numer_skierowania, opis_skierowania, miejsce_skierowania)
VALUES (2, '02–02–2022', 102, 'Skierowanie do okulisty', 'Profamilia Warszawa');

INSERT INTO skierowania (id_skierowania, data_wystawienia, numer_skierowania, opis_skierowania, miejsce_skierowania)
VALUES (3, '03–03–2022', 103, 'Skierowanie do dermatologa', 'NZOZ Sokrates Kraków');

INSERT INTO wyniki_badan (id_wyniki_badan, opis_wyniku)
VALUES (1, 'Niedobór żelaza');
INSERT INTO wyniki_badan (id_wyniki_badan, opis_wyniku)
VALUES (2, 'Wszystkie narządy w normie');

INSERT INTO badania (id_badania, nazwa_badania, opis_badania, wyniki_badan_id_wyniki_badan)
VALUES (1, 'Morfologia', 'Badanie składu krwi', 1);

INSERT INTO badania (id_badania, nazwa_badania, opis_badania, wyniki_badan_id_wyniki_badan)
VALUES (2, 'RTG', 'Badanie rentgenowskie', NULL);

INSERT INTO badania (id_badania, nazwa_badania, opis_badania, wyniki_badan_id_wyniki_badan)
VALUES (3, 'USG', 'Badanie ultrasonograficzne', 2);

INSERT INTO badania (id_badania, nazwa_badania, opis_badania, wyniki_badan_id_wyniki_badan)
VALUES (4, 'Tomografia komputerowa', 'Badanie obrazowe metodą CT', NULL);

INSERT INTO badania (id_badania, nazwa_badania, opis_badania, wyniki_badan_id_wyniki_badan)
VALUES (5, 'MRI', 'Badanie rezonansem magnetycznym', NULL);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (1, 1);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (2, 1);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (3, 1);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (4, 1);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (5, 1);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (1, 4);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (2, 4);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (3, 4);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (4, 4);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (5, 4);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (1, 5);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (2, 5);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (3, 5);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (4, 5);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (5, 5);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (4, 2);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (1, 2);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (5, 2);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (3, 3);

INSERT INTO uprawnienia_pracownicy (uprawnienia_id_uprawnienia, pracownicy_id_pracownika)
VALUES (4, 3);

INSERT INTO rejestracja (id_wizyty, data_wizyty, godzina_rozpoczecia, godzina_zakonczenia, opis_wizyty, status_wizyty, skierowania_id_skierowania, recepty_id_recepty, badania_id_badania, pracownicy_id_pracownika, pacjenci_id_pacjenta)
VALUES (1, '01–01–2022', '9:00', '10:00', 'Wizyta lekarska', 'Odbyta', 1, NULL, 2, 4, 1);

INSERT INTO rejestracja (id_wizyty, data_wizyty, godzina_rozpoczecia, godzina_zakonczenia, opis_wizyty, status_wizyty, skierowania_id_skierowania, recepty_id_recepty, badania_id_badania, pracownicy_id_pracownika, pacjenci_id_pacjenta)
VALUES (2, '02–02–2022', '11:00', '12:00', 'Badanie USG', 'Odbyta', NULL, NULL, 3, 2, 2);

INSERT INTO rejestracja (id_wizyty, data_wizyty, godzina_rozpoczecia, godzina_zakonczenia, opis_wizyty, status_wizyty, skierowania_id_skierowania, recepty_id_recepty, badania_id_badania, pracownicy_id_pracownika, pacjenci_id_pacjenta)
VALUES (3, '03–03–2022', '10:00', '11:00', 'Wizyta lekarska', 'Odbyta', 2, 3, NULL, 4, 3);



