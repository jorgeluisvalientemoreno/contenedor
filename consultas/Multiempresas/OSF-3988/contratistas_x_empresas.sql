--contratistas_x_empresas
select c.id_contratista,
       c.nombre_contratista,
       mc.empresa
from ge_contratista  c
left outer join multiempresa.contratista  mc  on mc.contratista = c.id_contratista
where 1 = 1
and   c.id_contratista = 4809
 and   exists (select null
                   from multiempresa.contratista  mc2  where mc2.contratista = c.id_contratista)
order by c.id_contratista desc;

/*update multiempresa.contratista  mc set mc.empresa = NULL where mc.contratista = 4809*/
