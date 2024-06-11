SELECT C.*, M.SUSPENSION_TYPE_ID
FROM OPEN.PR_CERTIFICATE C,OPEN.LDC_MARCA_PRODUCTO M
WHERE M.ID_PRODUCTO=C.PRODUCT_ID
  AND C.ESTIMATED_END_DATE>SYSDATE;

update ldc_plazos_cert 
   set plazo_min_revision=to_date('31/08/2016','dd/mm/yyyy'),
       plazo_maximo=to_date('31/01/2017','dd/mm/yyyy'),
       plazo_min_suspension=to_date('21/01/2017','dd/mm/yyyy')
where id_producto=1079843;

