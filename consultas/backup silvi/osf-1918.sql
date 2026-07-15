select p.* 
from pagos p, servsusc s 
where p.pagosusc = sesususc 
and sesunuse in (52167425,
52518051,
51870252,
1505851,
50045523,
51645194)
and p.pagofepa>='08/04/2024';
select sesususc ,c.* from cupon c ,servsusc  where cuposusc = sesususc and cupoflpa ='N' and sesunuse  = 1505851 order by cupofech desc 
;
