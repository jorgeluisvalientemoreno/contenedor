select distinct address_id 
from pr_product pr
where subscription_id in (17148291,
1149854,
6229916
);

select address_id , a.geograp_location_id , g.description , g.geo_loca_father_id , ge.description
from ab_address a
inner join ge_geogra_location g on a.geograp_location_id = g.geograp_location_id -- ciudad = localidad
inner join ge_geogra_location ge on   ge.geograp_location_id= g.geo_loca_father_id --departamento
where address_id in ( 133006,293639,346112)

select * from ge_geogra_location ge where ge.geograp_location_id  in (1,5,210, 55)
