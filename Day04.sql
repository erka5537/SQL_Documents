-- ALIASES

CREATE TABLE calisanlar9
(
calisan_id char(9),
calisan_isim varchar(50),
calisan_dogdugu_sehir varchar(50) );
INSERT INTO calisanlar9 VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO calisanlar9 VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO calisanlar9 VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar9
-- Eğer iki sütunun verilerini birleştirmek istersek concat sembolü olan || kuulanırız
select calisan_id as id, calisan_isim || ' ' || calisan_dogdugu_sehir as calisan_bilgisi from calisanlar9

--2. Yol
select calisan_id as id, concat(calisan_isim,' \\// ', calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar9

-- IS NULL CONDITION

CREATE TABLE insanlar
(
ssn char(9),
name varchar(50),
adres varchar(50)
);
INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');
INSERT INTO insanlar (ssn, adres) VALUES(456789012, 'Bursa');
INSERT INTO insanlar (ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar
delete  from insanlar

-- Name sütununda null olan değerleri listeleyiniz
select name from insanlar where name is null

-- İnsanlar tablosunda sadece null olmayan değerleri listeleyiniz
select name from insanlar where name is not null

-- İnsanlar tablosunda null değer almış verileri no name olarak değiştirin
update insanlar
set name='no name' where name is null

drop table if exists insanlar

--ORDER BY KOMUTU
/*
Tablolardaki verileri sıralamak için ORDER BY komutu kullanırız
natural BÜYÜKTEN-->küçüğe ya da küçükten-->BÜYÜĞE sıralama yapabiliriz
Default olarak küçükten büyüğe sıralama yapar
Eğer BÜYÜKTEN-->küçüğe sıralamak istersek ORDER BY komutundan sonra DESC komutunu kullanırız
*/

CREATE TABLE insanlar
(
ssn char(9),
isim varchar(50),
soyisim varchar(50), adres
varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar VALUES (344678901, 'Mine','Yasa', 'Ankara');
INSERT INTO insanlar VALUES (345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar

select * from insanlar order by adres;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim='Mine' order by ssn

-- NOT : Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
-- Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar where soyisim='Bulut' order by 2

-- Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn desc

--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim asc, soyisim Desc

-- İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
/*
Eğer sütun uzunluğuna göre sıralamak istersek LENTH komutu kullanırız
ve yine uzunluğu nüyükten küçüğe sıralamak istersek sonuna DESC komutunu ekleriz
*/

select isim,soyisim from insanlar 
order by length(soyisim) DESC

-- Tüm isim ve soyisim değerlerini aynı sutunda 
-- çağırarak her bir sütun değerini uzunluğuna 
-- göre sıralayınız

select isim||' '||soyisim as isim_soyisim from insanlar
order by length(isim||soyisim)

select isim||' '||soyisim as isim_soyisim from insanlar
order by length(isim)+length(soyisim)

select concat (isim,' ',soyisim) as isim_soyisim from insanlar
order by length(isim)+length(soyisim)

select concat (isim,' ',soyisim) as isim_soyisim from insanlar
order by length (concat(isim,soyisim))

--Group By Komutu
--Group By komutu sonuçları bir veya daha fazla 
--sütuna göre gruplamak için SELECT
--komutuyla birlikte kullanılır
CREATE TABLE manav
(
isim varchar(50),
Urun_adi varchar(50),
Urun_miktar int
);

INSERT INTO manav VALUES( 'Ali', 'Elma', 5);
INSERT INTO manav VALUES( 'Ayse', 'Armut', 3);
INSERT INTO manav VALUES( 'Veli', 'Elma', 2);
INSERT INTO manav VALUES( 'Hasan', 'Uzum', 4);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Ayse', 'Elma', 3);
INSERT INTO manav VALUES( 'Veli', 'Uzum', 5);
INSERT INTO manav VALUES( 'Ali', 'Armut', 2);
INSERT INTO manav VALUES( 'Veli', 'Elma', 3);
INSERT INTO manav VALUES( 'Ayse', 'Uzum', 2);

select * from manav

-- Isme gore alinan toplam urunleri listeleyiniz
select isim,sum(urun_miktar) as aldığı_toplam_urun from manav
group by isim;

-- Isme gore alinan toplam urunleri bulun ve bu ürünleri büyükten küçüğe listeleyiniz
select isim,sum(urun_miktar) as aldığı_toplam_urun from manav
group by isim
order by aldığı_toplam_urun desc;

-- Urun ismine gore urunu alan toplam kisi sayisi

select Urun_adi,count(isim) from manav
group by urun_adi