-- DATABASE(Veri Tabanı) Oluşturma
--create database herhangi// büyük küçük harf farkmaz

Create dataBase erkam;

--DDL - DATA DEFINITION LANG.
-- CREATE - TABLO OLUŞTURMA

CREATE TABLE ogrenciler
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real, --Ondalıklı sayılar için kullanılır(Double gibi)
kayit_tarih date	
);

--Varolan tablodan yeni bir tablo oluşturma
CREATE TABLE ogrenci_notlari
AS -- Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak için normal tablo oluştururkenki parantezler yerine AS kullanıp SELECT komutuyla almak istediğimiz verileri alırız
SELECT isim,soyisim,not_ort FROM ogrenciler;

--DML - DATA MANIPULATION LANG.
-- INSERT (Database'e veri ekleme)

INSERT INTO ogrenciler VALUES('1234567', 'Said', 'ILHAN', 85.5, now());
INSERT INTO ogrenciler VALUES('1234567', 'Said', 'ILHAN', 85.5, '2020-12-11');

-- BIR TABLOYA PARÇALI VERİ EKLEMEK İSTERSEK

INSERT INTO ogrenciler (isim, soyisim) VALUES ('Erkam','KILINÇ');

-- DQL - DATA QUERY LANG.
-- SELECT
select * FROM ogrenciler;