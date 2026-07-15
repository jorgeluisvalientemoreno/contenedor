}/* select *
 from open.LDC_SOLIANECO
 WHERE SOLICITUD = 186190086
 order by fecha_registro desc;
 
 select  * from open.pagos 
 where pagosusc = 67100656
 order by pagofegr  desc ;
 

 select *
 from open.cargos 
 where cargnuse = 52392202
 and cargsign = '%DE%' 
order by cargfecr desc ;*/

select sesunuse ,sesususc ,sesufere , sesusafa , sesucicl 
from open.servsusc 
where sesususc  = 17222656;

/* select cargnuse, cargsign , cargvalo, cargfecr
 from open.cargos 
 where cargnuse =52393724
 --and cargsign = 'ST' 
order by cargfecr desc ;*/

 
select *
from open.saldfavo
where safasesu = 17248594
order by  safafecr desc ; 

select *
from open.movisafa 
where mosfsesu = 17248594 
and MOSFFECR > = trunc(sysdate) ;


select suscsafa 
from open.suscripc 
where susccodi =  17222656 ; 
