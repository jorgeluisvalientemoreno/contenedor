select *
from open.ldc_versionobjetos v 
inner join open.ldc_versionentrega c on c.codigo=v.codigo_entrega
where  (upper(objeto) like upper('%LDC_PKVALCAMDVPM%')
      or upper(tipo) like upper('%LDC_PKVALCAMDVPM%'))
 ;
