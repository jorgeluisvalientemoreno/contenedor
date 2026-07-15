--atributos_por_empresas
select ae.empresa,
       e.nombre,
       e.nit,
       ae.atributo,
       ae.valor,
       e.direccion,
       e.telefono_emisor,
       e.fax_emisor
from atributos_empresa ae
 inner join multiempresa.empresa e  on  e.codigo = ae.empresa
order by empresa, atributo


 -- where ae.atributo = 'LINEA_GRATUITA'
