select a.id_acta , count ( distinct ( ge.id_detalle_acta)) ,   count ( distinct ( ge.id_orden))
from ge_acta a , ge_detalle_acta ge
where estado ='A' and a.id_acta= ge.id_acta  and id_tipo_acta = 1   group by a.id_acta , fecha_creacion  order by fecha_creacion desc
