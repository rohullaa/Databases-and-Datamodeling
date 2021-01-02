--Oppgave 1:
select filmcharacter, count(filmcharacter)
from filmcharacter
group by filmcharacter
having count(filmcharacter) > 2000
order by count(filmcharacter) desc;

--Oppgave 2a:

select f.title, f.prodyear
from film as f inner join
      (select *
      from filmparticipation as fp inner join person as p
      on fp.personid = p.personid
      where fp.parttype = 'director') as fpp
on f.filmid = fpp.filmid
where fpp.lastname like 'Kubrick' and fpp.firstname like 'Stanley';
--eller:
select f.title, f.prodyear
from film as f inner join filmparticipation as fp  on f.filmid = fp.filmid
inner join person as p on fp.personid = p.personid
where p.lastname like 'Kubrick' and p.firstname like 'Stanley' and fp.parttype = 'director';

--Oppgave 2b:
select f.title, f.prodyear
from film as f natural join filmparticipation as fp natural join person as p
where f.filmid = fp.filmid and fp.personid = p.personid and
p.lastname like 'Kubrick' and p.firstname like 'Stanley' and fp.parttype = 'director'

--Oppgave 2c:
select f.title, f.prodyear
from film as f, filmparticipation as fp, person as p
where f.filmid = fp.filmid and fp.personid = p.personid and
p.lastname like 'Kubrick' and p.firstname like 'Stanley' and fp.parttype = 'director'

--oppgave 3:
select personid, firstname || ' ' || lastname as name, title, country
from person natural join filmparticipation natural join filmcharacter natural join film natural join filmcountry
where firstname = 'Ingrid' and filmcharacter = 'Ingrid';

--oppgave 4
select f.filmid, f.title, count(fg.genre)
from film as f left outer join filmgenre as fg
on f.filmid = fg.filmid
where f.title like '%Antoine %'
group by f.filmid, f.title;

--oppgave 5
select title,parttype,count(parttype)
from film natural join filmparticipation natural join filmitem
where title like '%Lord of the Rings%' and filmtype like 'C'
group by title,parttype;

--oppgave 6:
select title, prodyear
from film
where prodyear in (select min(prodyear) from film);



--oppgave 7:
select title, prodyear
from film natural join filmgenre
where genre = 'Film-Noir'

INTERSECT

select title,prodyear
from film natural join filmgenre
where genre = 'Comedy';

--oppgave 8:
select title, prodyear
from film
where prodyear in (select min(prodyear) from film)

UNION

select title, prodyear
from film natural join filmgenre
where genre = 'Film-Noir'
INTERSECT
select title,prodyear
from film natural join filmgenre
where genre = 'Comedy';

--oppgave 9:
select f.title, f.prodyear
from film as f natural join filmparticipation as fp natural join person as p
where f.filmid = fp.filmid and fp.personid = p.personid and
p.lastname like 'Kubrick' and p.firstname like 'Stanley' and fp.parttype = 'director'

INTERSECT

select f.title, f.prodyear
from film as f natural join filmparticipation as fp natural join person as p
where f.filmid = fp.filmid and fp.personid = p.personid and
p.lastname like 'Kubrick' and p.firstname like 'Stanley' and fp.parttype = 'cast';

--oppgave10:
select s.maintitle
from series as s inner join filmrating as fr
on s.seriesid = fr.filmid
where fr.votes > 1000 and fr.rank in (select max(fr.rank) from filmrating as fr where fr.votes > 1000);


--oppgave11:
select country, count(country)
from filmcountry
group by country
having count(country) = 1;

--oppgave12:
select firstname || ' ' || lastname as name, count(partid) as antall_filmer
from (select filmcharacter from filmcharacter group by filmcharacter having count(filmcharacter) = 1) as u_fc
natural join filmcharacter
natural join filmparticipation natural join person
group by personid,name
having count(partid) > 199;




--oppgave13:
select firstname || ' ' || lastname as name
from filmrating natural join filmparticipation natural join person
where votes > 60000 and rank >= 8 and parttype = 'director'

EXCEPT
select firstname || ' ' || lastname as name
from filmrating natural join filmparticipation natural join person
where votes > 60000 and rank < 8 and parttype = 'director'
