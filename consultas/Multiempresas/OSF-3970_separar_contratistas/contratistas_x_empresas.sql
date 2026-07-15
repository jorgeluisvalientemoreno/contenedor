--contratistas_x_empresas
select mc.empresa,
       count(c.id_contratista) contratistas_osf,
       count(mc.contratista) contratistas_multiempresas
from ge_contratista  c
left outer join multiempresa.contratista  mc  on mc.contratista = c.id_contratista
group by mc.empresa
