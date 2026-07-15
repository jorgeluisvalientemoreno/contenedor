select cucofact 
from open.cuencobr l 
where l.cucocodi = 3017705636;

2098422573

select cargcuco
       difecodi,
       difesusc,
       difenuse ,
       difeconc,
       concdesc,
       difesape,
       difevatd,
       difeinte,
       difenucu,
       difecupa  facturadas,
       (difenucu - difecupa) as Pendientes,
       difefein,
       difeprog,
       difepldi  
from cargos c
inner join diferido on difenuse = cargnuse
inner join concepto t on  difeconc  = t.conccodi
where difecodi = substr(cargdoso, 4, 20)
and cargcaca = 51
and cargcuco in (3017705636,3017705653,3016050305,3016050306,3016050307,3016050286)
and cargvalo > 0
and difesape > 0
--and difeconc in (130)
--and  difepldi in (130)
--and difeprog ='GCNED'
order by cargfecr desc;


Select *
from cargos 
where cargnuse in (17144911,50948675,52000510,52001557)
order by cargfecr desc
where cargcuco = 3017706183
