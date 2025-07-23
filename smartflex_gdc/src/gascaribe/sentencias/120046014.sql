update ge_statement
   set module_id    = 4,
       description  = 'Consulta el nombre y el NIT de la empresa en la tabla sistema',
       statement    = q'#SELECT SISTEMPR NOMBRE_EMPRESA, SISTNITC NIT
FROM OPEN.SISTEMA#',
       name='LDC_DATA_EMPRESA'
 where statement_id = 120046014;
 commit;
