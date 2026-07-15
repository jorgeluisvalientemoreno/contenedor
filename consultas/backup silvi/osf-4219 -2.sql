select *
from ge_detalle_acta
where id_acta in (  250592);

select *
from ge_acta
where id_acta in (  250592); 


select *
from or_order o, ab_address a , ge_geogra_location ge
where o.external_address_id = a.address_id
and ge.geograp_location_id= a.geograp_location_id
and order_id = 224443722 ;


alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS disable ; 

update ab_address
set geograp_location_id = 9104
where address_id in (514268, 427873) ;

alter trigger PERSONALIZACIONES.trgbidurAB_ADDRESS enable ; 


select * from ge_contrato
where id_contratista = 2790;

select * from contratista
inner join ge_contratista c  on id_contratista = contratista
inner join ge_subscriber g  on g.subscriber_id = c.subscriber_id
where  empresa='GDGU' AND id_contratista = 2790;

SELECT * FROM ab_address a , ge_geogra_location ge  where ge.geograp_location_id= a.geograp_location_id and a.address_id = 514268 


select * from contratista
where contratista= 2790; 
