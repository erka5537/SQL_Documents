create table personel(
id int,
isim varchar(20),
soyisim varchar(20),
email varchar(30) unique,
tarih date,
is_unvanı varchar(20),
maas int
);
select * from personel
insert into personel values (123456789, 'Ali', 'Can', 'alican@gmail.com', '10-APR-10','isci', 5000);
insert into personel values (123456789, 'Veli', 'Cem', 'velicem@gmail.com', '10-JAN-12','isci', 5500);
insert into personel values (123456789, 'Ayse', 'Gul', 'aysegul@gmail.com', '01-MAY-14','muhasebeci', 4500);
insert into personel values (123456789, 'Fatma', 'Yasa', 'fatmayasa@gmail.com', '10-APR-09','mühendis', 7500);


--b) Tablodan maasi 5000’den az veya unvani isci olanlarin isimlerini listeleyin
select isim from personel where maas<5000 or is_unvanı='isci'

--c) Iscilerin tum bilgilerini listeleyin
select * from personel where is_unvanı='isci'
--d) Soyadi Can,Cem veya Gul olanlarin unvanlarini ve maaslarini listeleyin
select isim from personel where soyisim in('Can', 'Cem', 'Gul')


--e) Maasi 5000’den cok olanlarin email ve is baslama tarihlerini listeleyin
select email, tarih from personel where maas>5000


--f) Maasi 5000’den cok veya 7000’den az olanlarin tum bilgilerini listeleyin
select * from personel where maas>5000 or maas<7000


