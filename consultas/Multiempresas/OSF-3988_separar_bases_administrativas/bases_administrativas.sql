--bases_administrativas
select mb.base_administrativa, 
       ba.id_base_administra,
       ba.descripcion,
       mb.empresa
from ge_base_administra  ba
left outer join multiempresa.base_admin  mb  on mb.base_administrativa = ba.id_base_administra

/*update multiempresa.base_admin  mb1 set mb1.empresa = 'GDCA' where mb1.base_administrativa = 2*/
