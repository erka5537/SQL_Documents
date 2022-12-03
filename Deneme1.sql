--Database oluşturma
--syntax'de büyük küçük harf farkmaz 
create database techproed;

--DDL -  DATA DEFINITION LANG.
-- CREATE - TABLO OLUŞTURMA
CREATE TABLE ogrenciler
(
ogrenci_no char(7), --Uzunluğunu bildiğimiz stringler için CHAR kullanılır
isim varchar(20), -- Uzunluğunu bilmediğimiz stringler için VARCHAR kullanırız
soyisim varchar(25),
not_ort real, -- Ondalıklı sayılar için kullanılır (double gibi)
kayit_tarihi date
);

-- Var olan tablodan yeni bir tablo oluşturma 
create table ogrenci_notlari
as --Benzer tablodaki başlıklarla ve data tipleriyle yeni bir tablo oluşturmak için normal tablo oluştururkenki parantezler yerine AS kullanıp SELECT komutuyla almak istediğimiz verileri alırız
select isim,soyisim,not_ort from ogrenciler;

-- DML - DATA MANIPULATİON LANG.
-- INSERT (Database'e veri ekleme)

Insert into ogrenciler Values ('8526473', 'Erkam','KILINÇ',91.55, '2017-10-06');
Insert into ogrenciler Values ('8526473', 'Erkam','KILINÇ',87.43, now());

--Bir tabloya parçalı veri, eklemek istersek
Insert into ogrenciler (isim,soyisim) values ('Erol','Evren');

--DGL - DATA QUERY LANG.
-- SELECT

select * from ogrenciler; --Buradaki * sembolü herşey anlamındadır