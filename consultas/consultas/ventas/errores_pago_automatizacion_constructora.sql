select err.ldc_log_comm_id  Log_id, 
       m.product_id  Producto, 
       p.package_type_id  Tipo_Solicitud, 
       err.package_id  Solicitud, 
       err.register_date  Fecha_Registro, 
       err.error_code  Codigo_Error, 
       err.error_message Mensaje_Error
from open.ldc_log_comm_aut_cont  err
inner join open.mo_packages  p on p.package_id = err.package_id
inner join open.mo_motive  m on p.package_id = m.package_id