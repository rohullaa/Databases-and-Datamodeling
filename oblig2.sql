#oppgave 2a
select * from timelistelinje where timelistenr = 3;

#oppgave 2b
select count(*) from timeliste;

#opp2c
select * from timeliste where status != 'utbetalt';

#opp2d
select count(*) as antall,count(pause) as antallmedpause from timelistelinje;

#opp2e
select * from timelistelinje where pause is null;

#opp3_a
select sum(varighet)/60.0 as total_antall_timer
from timeliste as t,varighet as v
where t.timelistenr = v.timelistenr and status != 'utbetalt';

#opp3_b
select distinct t.timelistenr, t.beskrivelse
from  timeliste as t INNER JOIN timelistelinje as tl
ON(t.timelistenr = tl.timelistenr) where tl.beskrivelse like '%Test%' or tl.beskrivelse like '%test%';

#opp3_c
select 200.0*sum(varighet)/60.0 as utbetalt_penger
from timeliste as t,varighet as v
where t.timelistenr = v.timelistenr and status = 'utbetalt';


#opp4a
/*
Grunnen til at de to spørringene ikke gir samme likt svar er pga. ulike join som blir brukt.

For den første spørringen så har det blitt brukt NATURAL JOIN. Denne join-typen slår sammen to tabeller basert på
navn på attributtene og datatypen. For dette eksemplet så har både timelistelinje og timeliste lik beskrivelse "Innføring" og lik timelistenr 2.
Derfor får vi bare EN linje.

For andre spørringen blir det brukt INNER JOIN. Denne join-typen er litt annerledes siden det blir brukt ON-operatoren her.
Den slår sammen to tabeller av det som er spesifisert på ON.
*/

#opp4b
/*
Grunnen til at vi får samme svar er fordi NATURAL JOIN fungerer slik. Den slår sammen tabeller som har likt attributt
og datatype. I denne oppgaven så har vi like timelistenr, og ingen andre like kolonner. Så slår den sammen alle linjer med lik timelistenr.
For INNER-JOIN så blir det her spesifisert for hvilke rader tabellene skal slå seg sammen. Derfor får vi likt svar.
*/
