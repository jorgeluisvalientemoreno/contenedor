select owner, name, type
  from all_dependencies
 where referenced_owner = 'OPEN'
   and referenced_name = 'LDC_PROTECCION_DATOS'
