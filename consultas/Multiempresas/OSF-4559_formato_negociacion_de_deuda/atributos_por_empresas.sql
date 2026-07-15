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
  where ae.atributo = 'LINEA_GRATUITA'
order by empresa, atributo
