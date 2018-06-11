--1
SELECT DISTINCT nazwa FROM KLIENCI
     WHERE NOT EXISTS (SELECT * FROM FAKTURY
       WHERE FAKTURY.KLIENT = KLIENCI.REF)
	   order by nazwa asc; 
--2
select top 3 k.nazwa, f.brutto, k.miasto  from KLIENCI as k
inner join FAKTURY as f on k.REF = f.KLIENT
order by f.BRUTTO desc
--3
select  k.nazwa, f.brutto,  f.dzien, m.nazwa  from KLIENCI as k
inner join FAKTURY as f on k.REF = f.KLIENT
inner join MIASTA as m on m.NAZWA = k.MIASTO
where month(f.dzien) = 9
and k.GRUPAKLIENTA like 'HURT' or k.GRUPAKLIENTA like 'DETAL'

--4
select nazwa, miasto, GRUPAKLIENTA  from KLIENCI
where nazwa like 'a%' or nazwa like '%A %'
--5
select  k.nazwa, f.brutto, k.miasto  from KLIENCI as k
inner join FAKTURY as f on k.REF = f.KLIENT
where sum(f.BRUTTO) > 25000
AND DATEPART(DAY,f.DZIEN) = 9
order by f.BRUTTO desc

select DOMYSLNYRABAT from GRUPY_KLIENTÓW where NAZWAGRUPY  like 'HURTOWNICTY'

 create procedure zad6
 as 
 select symbol, dzien, brutto, if(rabat=(select DOMYSLNYRABAT from GRUPY_KLIENTÓW where NAZWAGRUPY  like 'HURTOWNICTY'),
 'zgodny', 'niezgodny' ) from faktury
 
 exec zad6









