CREATE TABLE ogrenciler3
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler3 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler3 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler3 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler3 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler3 VALUES(127, 'Mustafa Bak', 'Ali', 99);

select * from ogrenciler3
-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

Delete from ogrenciler3 where isim = 'Nesibe Yilmaz' or isim='Mustafa Bak';

-- Veli ismi Hasan olan datayı silelim
delete from ogrenciler3 where veli_isim = 'Hasan';

 -- TRUNCATE --
 -- Bir tablodaki tüm verileri geri alamayacağımız şekilde siler. Şartlı silme yapmaz
 
 Truncate table ogrenciler3
 
 drop table if exists talebeler --eğer tablo varsa tabloyu siler
 
 -- ON DELETE ESCAPE
 CREATE TABLE talebeler
(
id CHAR(3) primary key,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

CREATE TABLE notlar(
talebe_id char(3),
ders_adi varchar(30),
yazili_notu int,
CONSTRAINT notlar_fk FOREIGN KEY (talebe_id) REFERENCES talebeler(id)
on delete cascade
);

INSERT INTO talebeler VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO talebeler VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO talebeler VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO talebeler VALUES(126, 'Nesibe Yılmaz', 'Ayse',95);
INSERT INTO talebeler VALUES(127, 'Mustafa Bak', 'Can',99);

INSERT INTO notlar VALUES ('123','kimya',75);
INSERT INTO notlar VALUES ('124', 'fizik',65);
INSERT INTO notlar VALUES ('125', 'tarih',90);
INSERT INTO notlar VALUES ('126', 'Matematik',90);

select * from talebeler
select * from notlar

-- Notlar tablosundan talebe id' 'si 123 olan datayı silelim

delete from notlar where talebe_id='123';

delete from talebeler where id='126';

/*
    Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile
parent tablo dan da veri silebiliriz. Yanlız ON DELETE CASCADE komutu kullanımında parent tablodan sildiğimiz
data child tablo dan da silinir
*/

-----------------------------------------------------

-- IN CONDITION
drop table if exists musteriler

CREATE TABLE musteriler (
urun_id int,
musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO musteriler VALUES (10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES (10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES (20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES (30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES (20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES (10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES (40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES (20, 'Eddie', 'Apple');

select * from musteriler

-- Musteriler tablosundan urun ismi orange, apple ve apricot olan tüm verileri listeleyiniz

select * from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';

-- IN CONDITION
select * from musteriler where urun_isim IN ('Orange','Apple','Apricot');

-- NOT IN --> Yazdığımız verilerin dışındakileri getirir

select * from musteriler where urun_isim not IN ('Orange','Apple','Apricot');

-- BETWEEN CONDITION

--Musteriler tablosundan id'si 20 ile 40 arasında olan verileri listeleyiniz
select * from musteriler where urun_id>=20 and urun_id<=40;

select * from musteriler where urun_id between 20 and 40;
select * from musteriler where urun_id not between 20 and 40;

-----------------------------------------------------

-- SUBQUERIES --> Sorgu içinde sorgu
CREATE TABLE calisanlar2
(
id int,
isim VARCHAR(50),
sehir VARCHAR(50),
maas int,
isyeri VARCHAR(20)
);

CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20),
calisan_sayisi int
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);

select * from calisanlar2;
select * from markalar;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini 
-- ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.

select isim,maas,isyeri from calisanlar2
where isyeri in(select marka_isim from markalar where calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin 
-- isim, maaş ve şehirlerini listeleyiniz
select isim,maas,sehir from calisanlar2 
where isyeri in (select marka_isim from markalar where marka_id>101);

-- AGGREGATE METHOD
select max(maas) from calisanlar;
select sum(maas) from calisanlar;
select avg(maas) from calisanlar;
select round(avg(maas),2) from calisanlar;
select min(maas) from calisanlar;
select count(maas) from calisanlar;

-- AGGREGATE METHOD
-- Calisanlar toplasundan maksimum maası listeleyelim
SELECT max(maas) AS maksimum_maas FROM calisanlar2;
/*
    Eğer bir sutuna geçici olarak bir isim vermek istersek AS komutunu yazdıktan sonra
vermek istediğimiz ismi yazarız
*/

-- Calisanlar tablosundan en düşük maaşı listeleyiniz
select min(maas) as en_düsük_maas from calisanlar2

-- Calisanlar tablosundaki maaş'ların toplamını listeleyiniz
select sum(maas) as toplam_maas from calisanlar2

-- Calisanlar tablosundaki maaş'ların ortalamasını listeleyiniz
select avg(maas) as maas_ortalamasi from calisanlar2
select round(avg(maas),2) from calisanlar2;

-- Calisanlar tablosundaki maaş'ların sayısını listeleyiniz
select count(maas) from calisanlar2;
select count(*) from calisanlar2;

/*
Eğer count(*) kullanırsak tablodaki tüm satırların sayısını verir
Sutun adı kullanırsak o sutundaki sayıları verir
*/

-- AGGREGATE METHODLARDA SUBQUERY
-- Her markanin id’sini, ismini ve toplam kaç 
-- şehirde bulunduğunu listeleyen bir SORGU yaziniz

select * from calisanlar2;
select * from markalar;

select marka_id,marka_isim, 
(select count (sehir) from calisanlar2 where marka_isim=isyeri)
from markalar;

----------------------------------------------------------------

-- Her markanin ismini, calisan sayisini ve o 
-- markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi,
(select sum(maas) from calisanlar2 where isyeri=marka_isim)
from markalar

----------------------------------------------------------------

-- Her markanin ismini, calisan sayisini ve 
-- o markaya ait calisanlarin maksimum ve minumum 
-- maaşini listeleyen bir Sorgu yaziniz.

select marka_isim, calisan_sayisi,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as enyuksekmaas,
(select min(maas) from calisanlar2 where isyeri=marka_isim)as endusukmaas
from markalar

-- VIEW Kullanımı
/*
Yaptığımız sorguları hafızaya alır ve tekrar bizden istenen sorgulama yerine
view'e atadığımız ismi select komutuyla çağırırız
*/
create view maxminmaas
as
select marka_isim, calisan_sayisi,
(select max(maas) from calisanlar2 where isyeri=marka_isim) as enyuksekmaas,
(select min(maas) from calisanlar2 where isyeri=marka_isim)as endusukmaas
from markalar;

select * from maxminmaas;

------------------------------------------------------------

-- 							EXISTS CONDITION
/*
EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer
olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin içerisinde
bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar
*/

CREATE TABLE mart
(   
urun_id int,    
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO mart VALUES (10, 'Mark', 'Honda');
INSERT INTO mart VALUES (20, 'John', 'Toyota');
INSERT INTO mart VALUES (30, 'Amy', 'Ford');
INSERT INTO mart VALUES (20, 'Mark', 'Toyota');
INSERT INTO mart VALUES (10, 'Adam', 'Honda');
INSERT INTO mart VALUES (40, 'John', 'Hyundai');
INSERT INTO mart VALUES (20, 'Eddie', 'Toyota');

CREATE TABLE nisan 
(   
urun_id int ,
musteri_isim varchar(50), urun_isim varchar(50)
);
INSERT INTO nisan VALUES (10, 'Hasan', 'Honda');
INSERT INTO nisan VALUES (10, 'Kemal', 'Honda');
INSERT INTO nisan VALUES (20, 'Ayse', 'Toyota');
INSERT INTO nisan VALUES (50, 'Yasar', 'Volvo');
INSERT INTO nisan VALUES (20, 'Mine', 'Toyota');

/*
MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin
URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan
MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
*/
 
SELECT urun_id,musteri_isim FROM mart
WHERE exists (select urun_id FROM nisan WHERE mart.urun_id=nisan.urun_id)

--Her iki ayda birden satılan ürünlerin 
--URUN_ISIM'lerini ve bu ürünleri NİSAN ayında 
--satın alan MUSTERI_ISIM'lerini 
--listeleyen bir sorgu yazınız.

select urun_isim,musteri_isim from nisan
where exists (select urun_isim from mart where mart.urun_isim=nisan.urun_isim)

--DML--> UPDATE

CREATE TABLE tedarikciler -- parent
(
vergi_no int PRIMARY KEY,
firma_ismi VARCHAR(50),
irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES (101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES (102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES (103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES (104, 'Apple', 'Adam Eve');

CREATE TABLE urunler -- child
(
ted_vergino int,
urun_id int,
urun_isim VARCHAR(50),
musteri_isim VARCHAR(50),
CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino)
REFERENCES tedarikciler(vergi_no)
on delete cascade
);
INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler
select * from urunler

-- vergi_no’su 102 olan tedarikcinin firma ismini 
--'Vestel' olarak güncelleyeniz.

/*
UPDATE tablo_adi
SET sutun_ismi = 'istenen veri' WHERE sutun_ismi = 'istenen veri'
 */
 
update tedarikciler
set firma_ismi = 'Vestel' where vergi_no=102;

-- vergi_no’su 101 olan tedarikçinin firma ismini 
--'casper' ve irtibat_ismi’ni 'Ali Veli' 
--olarak güncelleyiniz.
UPDATE tedarikciler 
SET irtibat_ismi = 'Ali Veli' WHERE vergi_no=101;

-- urunler tablosundaki 'Phone' değerlerini 
--'Telefon' olarak güncelleyiniz.

Update urunler
set urun_isim = 'Telefon' where urun_isim = 'Phone'

-- urunler tablosundaki urun_id değeri 1004'ten 
--büyük olanların urun_id’sini 1 arttırın.
UPDATE urunler 
SET urun_id = urun_id+1 WHERE urun_id > 1004;

-- urunler tablosundaki tüm ürünlerin urun_id 
--değerini ted_vergino sutun değerleri ile 
--toplayarak güncelleyiniz.

UPDATE urunler SET urun_id = urun_id + ted_vergino;

/*
* urunler tablosundan Ali Bak’in aldigi urunun 
ismini, tedarikci tablosunda irtibat_ismi
'Adam Eve' olan firmanın ismi (firma_ismi) 
ile degistiriniz.
*/
UPDATE urunler
SET urun_isim = (select firma_ismi from tedarikciler WHERE irtibat_ismi = 'Adam Eve')
WHERE musteri_isim='Ali Bak';

-- Urunler tablosunda laptop satin alan 
-- musterilerinismini, firma_ismi Apple’in 
-- irtibat_isim'i ile degistirin.

update urunler
set musteri_isim = (select irtibat_ismi from tedarikciler where firma_ismi = 'Apple')
where urun_isim = 'Laptop'