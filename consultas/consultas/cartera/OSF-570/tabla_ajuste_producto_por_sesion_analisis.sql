select sesion, 
       usuario, 
       fecha, 
       producto, 
       observacion, 
       sesion_analisis, 
       orden_susp_anular, 
       motivo
from open.ldc_ajusta_suspcone
where sesion_analisis = 957315220