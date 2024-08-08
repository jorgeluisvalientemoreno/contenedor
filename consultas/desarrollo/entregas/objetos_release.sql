select c.nombre_entrega, c.descripcion, c.codigo_caso, v.objeto
from open.ldc_versionobjetos v 
inner join open.ldc_versionentrega c on c.codigo=v.codigo_entrega and c.nombre_entrega like '%7.07.046_rp%'

 
