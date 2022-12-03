CREATE TABLE ogrenciler
(
ogrenci_no char(7), --Uzunluğunu bildiğimiz stringler için CHAR kullanılır
isim varchar(20), -- Uzunluğunu bilmediğimiz stringler için VARCHAR kullanırız
soyisim varchar(25),
not_ort real, -- Ondalıklı sayılar için kullanılır (double gibi)
kayit_tarihi date);

--Varolan bir tablodan yeni bir tablo oluşturma
create table NOTLAR
as
select isim,not_ort from NOTLAR;

select * from ogrenciler;

--Tablo içine veri ekleme
--INSERT

insert into notlar values('Hasan',75.5);
insert into notlar values('Ali',85.5);
insert into notlar values('Murat',46.5);
insert into notlar values('Nazım',64.5);

select * from notlar;

Create table talebeler
(
isim varchar(10),
notlar real
);
insert into talebeler values('Hasan',75.5);
insert into talebeler values('Ali',85.5);
insert into talebeler values('Murat',46.5);
insert into talebeler values('Nazım',64.5);

select isim from notlar;

--CONSTRAINT
--UNIQUE

CREATE TABLE ogrenciler2
(
ogrenci_no char(7) unique,
isim varchar(20) not null,
soyisim varchar(25),
not_ort real,
kayit_tarihi date);
select * from ogrenciler2;

insert into ogrenciler2 values('1234567','erkam','kılınç',78.7,now());
insert into ogrenciler2 values('7654321','azer','bülbül',78.7,now());
insert into ogrenciler2 (ogrenci_no,soyisim,not_ort) values('7894561','korkmaz',67.44); -- NOT NULL kısıtlaması olduğu için bu veri eklenemez

-- PRIMARY KEY ataması

CREATE TABLE ogrenciler8
(
ogrenci_no char(7) primary key,
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarihi date);
select * from ogrenciler8;

-- Primary Key ataması 2. yol

CREATE TABLE ogrenciler9
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarihi date,
constraint ogr primary key (ogrenci_no)
);

CREATE TABLE ogrenciler10
(
ogrenci_no char(7),
isim varchar(20),
soyisim varchar(25),
not_ort real,
kayit_tarihi date,
primary key (ogrenci_no)
);

-- PRIMARY KEY ataması
/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
CREATE TABLE tedarikciler3
(
tedarikci_id char(7) primary key,
tedarikci_ismi varchar(20),
iletisim_isim varchar(25)
);

CREATE TABLE urunler
(
tedarikci_id char(7),
urun varchar(20),
foreign key (tedarikci_id) references tedarikciler3(tedarikci_id)
);

select * from tedarikciler3;
select * from urunler;

/*
“calisanlar” isimli bir Tablo olusturun. 
Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari 
olsun. “id” yi Primary Key yapin, “isim” i Unique, 
“maas” i Not Null yapın.

“adresler” isminde baska bir tablo olusturun.
Icinde “adres_id”, “sokak”, “cadde” ve “sehir” 
fieldlari olsun. “adres_id” field‘i ile Foreign 
Key oluşturun.
*/

CREATE TABLE calisanlar
(
idler char(5) primary key,
isim varchar(20) unique,
maas int not null,
ise_baslama date
);

CREATE TABLE adresler
(
adres_id varchar(30),
sokak varchar(30),
cadde varchar(30),
sehir varchar(30),
FOREIGN KEY (adres_id) REFERENCES calisanlar(idler)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz' ,12000, '2018-04-14');
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10010', Mehmet Yılmaz, 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); -- NOT NULL CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
--INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); -- UNIQUE CONS. Kabul etmez
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14');
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14');
--INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( '10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --PRIMARY KEY
--INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --PRIMARY KEY

INSERT INTO adresler VALUES('10003','Mutlu Sok', '40.Cad.','IST');
INSERT INTO adresler VALUES('10003','Can Sok', '50.Cad.','Ankara');
INSERT INTO adresler VALUES('10002','Ağa Sok', '30.Cad.','Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES('10012','Ağa Sok', '30.Cad.','Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Antep');
INSERT INTO adresler VALUES(NULL,'Ağa Sok', '30.Cad.','Maraş');

select * from calisanlar;
select * from adresler;

--CHECK CONSTRAINT
CREATE TABLE calisanlar1
(
idler char(5) primary key,
isim varchar(20) unique,
maas int not null check (maas>10000),
ise_baslama date
);

INSERT INTO calisanlar1 VALUES('10002', 'Mehmet Yılmaz', 19000, '2018-04-14');

-- DQL -- WHERE KULLANIMI

select * calisanlar;
select isim from calisanlar;

-- calisanlar tablosundan maaşı 5bin den büyük olan isimleri listeleyiniz
select isim,maas from calisanlar where maas>5000;

--calisanlar tablosundan ismi veli han olan veriyi listeleyiniz
select * from calisanlar where isim='Veli Han';

-- calisanlar tablosundan maaşı 5bin olan verileri listeleyiniz
select * from calisanlar where maas=5000;

--DML -- DELETE KOMUTU
delete from calisanlar -- Eğer parent table başka bir child tablo ile ilişkili ise önce child table silinmelidir
delete from adresler;
select * from adresler;

--Adresler tablosundan şehri antep olan verileri silelim
delete from adresler where sehir = 'Antep';

CREATE TABLE ogrenciler76
(
id int,
isim VARCHAR(50),
veli_isim VARCHAR(50),
yazili_notu int
);

INSERT INTO ogrenciler76 VALUES(123, 'Ali Can', 'Hasan',75);
INSERT INTO ogrenciler76 VALUES(124, 'Merve Gul', 'Ayse',85);
INSERT INTO ogrenciler76 VALUES(125, 'Kemal Yasa', 'Hasan',85);
INSERT INTO ogrenciler76 VALUES(126, 'Nesibe Yilmaz', 'Ayse',95);
INSERT INTO ogrenciler76 VALUES(127, 'Mustafa Bak', 'Can',99);
INSERT INTO ogrenciler76 VALUES(127, 'Mustafa Bak', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.

Delete from ogrenciler76 where isim ='Nesibe Yilmaz' or isim='Mustafa Bak';