-- DISTINCT KULLANIMI

CREATE TABLE musteri_urun
(
urun_id int,
musteri_isim varchar(50),
urun_isim varchar(50)
);
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal');
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma');
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut');
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma');
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal');
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi');
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun
--DISTINCT clause, çağrılan terimlerden tekrarlı 
-- olanların sadece birincisini alır.

-- Musteri urun tablosundan urun isimlerini tekrarsız(grup) listeleyiniz
-- 1.Way (Group By)
select urun_isim from musteri_urun
group by urun_isim

-- 2.Way (DISTINCT)
select distinct urun_isim from musteri_urun


-- Tabloda kac farkli meyve vardir ?
select urun_isim, count(urun_isim) from musteri_urun
group by urun_isim

select count(distinct urun_isim) from musteri_urun

-- FETCH NEXT (SAYI) ROW ONLY / OFFSET / LIMIT

--Musteri tablosundan ilk üç kaydı listeleyiniz
select * from musteri_urun order by urun_id 
fetch next 3 row only

--LIMIT
select * from musteri_urun order by urun_id 
limit(3)

--Musteri ürün tablosundan son üç kaydı
select * from musteri_urun
offset (SELECT COUNT(*) FROM musteri_urun)-3 row
fetch next 3 row only
SELECT * FROM musteri_urun 
OFFSET (SELECT COUNT(*) FROM musteri_urun) - 3;

CREATE TABLE maas 
(
id int, 
musteri_isim varchar(50),
maas int 
);
INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

-- EN yüksek maası alan müsteriyi listeleyiniz
SELECT * FROM maas ORDER BY maas DESC limit 1
-- Maas tablosundan en yüksek ikinci maası listeleyiniz
SELECT * FROM maas ORDER BY maas DESC offset 1 limit 1
/*
OFFSET --> Satır atlamak istediğimizde offset komutunu kullanırız
*/
SELECT * FROM maas ORDER BY maas desc
OFFSET 1 
FETCH NEXT 1 ROW ONLY
-- Maas tablosundan en düşük dördüncü maası listeleyiniz
SELECT * FROM maas ORDER BY maas offset 3 limit 2

/*
					ALTER TABLE STATEMENT
					
	ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns
	islemleri icin kullanilir.
	ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.
 */
 
 CREATE TABLE personel
(
id int,
isim varchar(50),
sehir varchar(50),
maas int,
sirket varchar(20),
CONSTRAINT personel_pk PRIMARY KEY (id)
);
INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from işçi

-- 1) ADD default deger ile tabloya bir field ekleme

ALTER TABLE personel
add ulke varchar(20)

ALTER TABLE personel
add zipcode varchar(30)

ALTER TABLE personel
add adres varchar(20) DEFAULT 'Turkiye' --Default yazarsak oluşturduğumuz sütuna belirttiğimiz veriyi tüm satırlara girer

-- 2) DROP tablodan sütun silme

ALTER TABLE personel
drop column zipcode

ALTER TABLE personel
drop ulke, drop adres --iki sütunu birden sildik

-- 3)RENAME COLUMN sutun adi degistirme

Alter table personel
rename column sehir to il

-- 4)RENAME tablonun ismini degistirme
Alter table personel
rename to işçi

-- 5)TYPE/SET(modify) sutunlarin ozelliklerini degistirme
alter table işçi
alter column il type varchar(30),
alter column maas set not null
/*
Eğer numerik data türüne sahip bir sütunun data türüne string bir data türü atamak istersek 
type varchar(30) using(maas::varchar(30)) bu formatı kullanırız
*/
alter table işçi
alter column maas
type varchar(30) using(maas::varchar(30))


/*
	-->	TRANSACTION (BEGIN - SAVEPOINT - ROLLBACK - COMMIT)
	Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin
	COMMIT komutunu calistirmaliyiz.
*/
CREATE TABLE ogrenciler2
(
id serial, -- Serial data türü otomatik olarak 1 den başlayarak sıralı olarak sayı ataması yapar
		   -- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu real       
);
BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5);
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6);
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to y;
COMMIT;

select * from ogrenciler2
delete from ogrenciler2
drop table ogrenciler2

/*
	Transaction kullaniminda SERIAL data turu kullanimi tercih edilmez. Save pointten sonra ekledigimiz
	veride sayac mantigi ile calistigi icin sayacta en son hangi sayida kaldiysa ordan devam eder.
	NOT :PostgreSQL de Transaction kullanımı için «Begin;» komutuyla başlarız sonrasında tekrar
	yanlış bir veriyi düzelmek veya bizim için önemli olan verilerden
	sonra ekleme yapabilmek için "SAVEPOINT savepointismi" komutunu
	kullanırız ve bu savepointe dönebilmek için "ROLLBACK TO savepointismi" komutunu
	kullanırız ve rollback çalıştırıldığında savepoint yazdığımız satırın üstündeki
	verileri tabloda bize verir ve son olarak Transaction'ı sonlandırmak için mutlaka
	"COMMIT" komutu kullanılır.
 */