select c.* , m.package_id ,  m.package_type_id , m.motive_status_id ,m.request_date , sesucicl 
from open.cargos c 
inner join mo_packages m on 'PP-'||m.package_id= cargdoso and m.package_type_id = 100229
left join servsusc on sesunuse = cargnuse 
where cargcuco = -1
and cargfecr >='01/05/2024' and sesucicl = 4502;

select * from cargos where cargpefa= 113739 and cargcuco = -1 and cargfecr>='06/09/2024';

select * from cargos where cargpefa = 113739 and cargnuse = 52903324;
