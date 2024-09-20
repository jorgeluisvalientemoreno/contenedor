SELECT *
  FROM open.LDC_SEGUROVOLUNTARIO l
 WHERE FILE_NAME_VENTA IS NULL
   AND DIFECODI IS NOT NULL
   and estado_seguro = 'RE'
   and l.difecodi not in (select d.difecodi from open.diferido d where d.difecodi = l.difecodi)
