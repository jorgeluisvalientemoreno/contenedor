select * from contrato where empresa ='GDGU'  ;

select * from ciclo_facturacion where empresa ='GDGU'  ; 

select * 
from suscripc 
where susccicl in ( select ciclo from ciclo_facturacion where empresa ='GDGU')   ;

select * from ge_subscriber where subscriber_id  = 3442218 ; 

select * from servsusc where sesususc = 4500327 ; 
select  * from diferido where difesusc = 4500327 ; 

select s.*  , l.locanomb 
from gasgg.suscripc s 
inner join gasgg.localida  l on l.locacodi =  suscloca 
where suscnice = '8888888802400' ;

select *  from gasgg.diferido   where difesusc = 1000327 and difesape >0;
select * from gasgg.factura where factsusc  = 1000327
and factfege >= add_months(sysdate , -24);


select sesususc , sesueste, etsedesc , sesunuse , sesuserv  , tp.servdesc, SESUESFI , esfidesc 
from gasgg.servsusc 
inner join gasgg.servicio tp on tp.servcodi = sesuserv
inner join  gasgg.esteserv on sesueste = etsecodi 
inner join gasgg.estafina on sesuesfi = esficodi 
where sesususc  = 1000327 ; 

select * from GASGG.servsusc 
;
select * 
from gasgg.factura 
where factsusc  = 1000327
and exists ( select *  from gasgg.cuencobr where cucocodi = factcuco and cucosape >0  and cucosusc = factsusc )  

minus 

select * 
from gasgg.factura 
where factsusc  = 1000327
and factfege >= add_months(sysdate , -24)

;   





 

