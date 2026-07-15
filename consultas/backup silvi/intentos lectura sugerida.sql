select id_solicitud "Solicitud",
       num_intentos "Num_intentos" ,
       num_producto "Producto",
       num_pericose "Periodo_cons",
       num_lectsuge "Lectura_sugerida",
       flag_procesado "Flag_procesado" ,
       proceso "Proceso",
       fehaproceso "Fecha_proceso"
from open.ldc_ctrllectura
where ldc_ctrllectura.num_producto= 51223094


update  open.ldc_ctrllectura set  num_intentos  = 0  where ldc_ctrllectura.num_producto= 51223094


delete from  ldc_ctrllectura where num_producto= 51223094
