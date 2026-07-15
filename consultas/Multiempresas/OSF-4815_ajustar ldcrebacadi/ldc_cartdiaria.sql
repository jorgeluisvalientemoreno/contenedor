select *
  from ldc_cartdiaria  c
  where dia >= '9/09/2025'
c.tipo_producto = 7014
and c.departamento = 2

/*update ldc_cartdiaria  set dia = trunc(sysdate) where dia = '30/09/2025'*/
