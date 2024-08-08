select certificados_oia_id  id, 
       id_contrato  Contrato, 
       id_producto  Producto, 
       tipo_inspeccion  Tipo, 
       Certificado, 
       id_organismo_oia  Unidad_Operativa, 
       status_certificado   Estado, 
       Fecha_Registro, 
       Organismo_id  Organismo, 
       vaciointerno, 
       fecha_reg_osf  
from open.ldc_certificados_oia  o
where o.id_producto in (1110264)
order by fecha_registro desc;