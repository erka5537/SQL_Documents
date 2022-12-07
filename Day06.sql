-- JOINS

CREATE TABLE sirketler  (
sirket_id int,  
sirket_isim varchar(20)
);
INSERT INTO sirketler VALUES(100, 'Toyota');
INSERT INTO sirketler VALUES(101, 'Honda');
INSERT INTO sirketler VALUES(102, 'Ford');
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler  (
siparis_id int,  sirket_id int,  siparis_tarihi date
);
INSERT INTO siparisler VALUES(11, 101, '2020-04-17');
INSERT INTO siparisler VALUES(22, 102, ' 2020-04-18');
INSERT INTO siparisler VALUES(33, 103, ' 2020-04-19');
INSERT INTO siparisler VALUES(44, 104, ' 2020-04-20');
INSERT INTO siparisler VALUES(55,  105, ' 2020-04-21');

/*
	NOT 1:
	1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
	2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
	3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali

	NOT 2 :
	1) Left Join’de ilk tablodaki tum record’lar gosterilir.
	2) Ilk tablodaki datalara 2.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir ancak
	ortak olmayan datalar icin o kisimlar bos kalir
	3) Ilk yazdiginiz Tablonun tamamini aldigi icin hangi tabloyu istedigimize karar verip once onu yazmaliyiz
	
	NOT 3:
	1)Right Join’de ikinci tablodaki tum record’lar gosterilir.
	2)Ikinci tablodaki datalara 1.tablodan gelen ek datalar varsa bu ek datalar ortak datalar icin gosterilir
	ancak ortak olmayan datalar icin o kisimlar bos kalir
	
	NOT 4:
	1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
	2) Bir tabloda olup otekinde olmayan data’lar bos kalir
*/
-- Example :
-- Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve
-- siparis_tarihleri ile yeni bir tablo olusturun
select * from sirketler
select * from siparisler

--INNER JOİN
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler inner join siparisler
on sirketler.sirket_id=siparisler.sirket_id

--LEFT JOİN
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler left join siparisler
on sirketler.sirket_id=siparisler.sirket_id

--RIGHT JOİN
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler right join siparisler
on sirketler.sirket_id=siparisler.sirket_id

-- FULL JOİN
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler full join siparisler
on sirketler.sirket_id=siparisler.sirket_id

--SELF JOIN
CREATE TABLE personel
(
id int,
isim varchar(20),
title varchar(60),
yonetici_id int
);
INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4);
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

select * from personel
-- Example:
-- Her personelin yanina yonetici ismini 
-- yazdiran bir tablo olusturun

SELECT p1.isim AS personel_ismi, p2.isim AS yonetici_ismi
FROM personel p1 INNER JOIN personel p2
ON p1.yonetici_id = p2.id;


-- 								LIKE Condition
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/

CREATE TABLE musteriler
(
id int UNIQUE,
isim varchar(50) NOT NULL,
gelir int
);
INSERT INTO musteriler (id, isim, gelir) VALUES (1001, 'Ali', 62000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1002, 'Ayse', 57500);
INSERT INTO musteriler (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1004, 'Fatma', 42000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler (id, isim, gelir) VALUES (1006, 'ahmet', 82000);

-- Note: % => 0 veya birden fazla karakter belirtir
-- LIKE kullanmında büyük küçük harf gözetmeksizin sonuç almak istersek ilike kullanırız
-- LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız

--Example 1:
-- Ismi A harfi ile baslayan musterilerin tum 
-- bilgilerini yazdiran QUERY yazin
select * from musteriler where isim ilike 'A%'
select * from musteriler where isim ~~ 'A%'

--Example 2:
-- Ismi e harfi ile biten musterilerin isimlerini 
-- ve gelir’lerini yazdiran QUERY yazin
select * from musteriler where isim ~~ '%e'

--Example 3:
--Isminin icinde er olan musterilerin isimlerini
-- ve gelir’lerini yazdiran QUERY yazin
select * from musteriler where isim ~~ '%er%'

-- 2) _=> sadece bir karakteri gosterir.

--Example 4: Ismi 5 harfli olup son 4 harfi atma olan 
-- musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '_atma'

--Example 5:
-- Ikinci harfi a olan musterilerin tum 
-- bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '_a%'

--Example 6:
-- Ucuncu harfi s olan musterilerin tum 
-- bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '__s%'

-- LIKE Condition
/*
	3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
*/

CREATE TABLE kelimeler  (
id int UNIQUE,
kelime varchar(50) NOT NULL,  Harf_sayisi int
);
INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1008, 'hct', 3);
INSERT INTO kelimeler VALUES (1005, 'adem', 4);
INSERT INTO kelimeler VALUES (1006, 'selim', 5);
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);

--Example 7:
--  Ilk harfi h,son harfi t olup 2.harfi 
-- a veya i olan 3 harfli kelimelerin tum 
-- bilgilerini yazdiran QUERY yazin

select * from kelimeler where kelime ~ 'h[ai]t'

--Example 8:
-- Ilk harfi h,son harfi t olup 2.harfi 
-- a ile k arasinda olan 3 harfli kelimelerin 
-- tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* 'h[a-k]t'

--Example 9:
-- a veya s ile baslayan kelimelerin 
-- tum bilgilerini yazdiran QUERY yazin

select * from kelimeler where kelime ~* '^[a-s]'

--Example 10:
-- m veya f ile biten kelimelerin tum 
-- bilgilerini yazdiran QUERY yazin
SELECT * FROM kelimeler WHERE kelime ~ '[mf]$';

/*
							LIKE Condition
LIKE: Sorgulama yaparken belirli patternleri(KAlıp ifadelerle sorgu) kullanabilmezi sağlar
ILIKE: Sorgulama yaparken büyük/küçük harfe duyarsız olarak eşleştirir.
LIKE = ~~
ILIKE = ~~*
NOT LIKE = !~~
NOT ILIKE = !~~*
NOT REGEXP_LIKE = !~*
NOT REGEXP_LIKE = !~
*/

/*
UPPER – LOWER - INITCAP
Tablolari yazdirirken buyuk harf, kucuk harf veya ilk harfleri buyuk digerleri
kucuk harf yazdirmak icin kullaniriz
*/

-- Kelimeler tablosundaki kelime sütunundaki verileri önce hepsini büyük harf, sonra küçük harf ve ilk harfleri
-- büyük olucak şekilde yazdıralım
SELECT UPPER(kelime) as kelime from kelimeler
select lower (kelime) as kelime from kelimeler
select initcap(kelime) as kelime from kelimeler -- INITCAP istediğimiz sütundaki verilerin ilk harfini büyük yazar

-- Musteriler tablosundan bütün isimleri büyük harf yapınız
select upper(isim) from musteriler

/*
Eğer birden fazla sütundaki verileri büyük küçük harf yapmak istersek
select lower(title), upper(isim) from personel şekilde yapabiliriz
*/