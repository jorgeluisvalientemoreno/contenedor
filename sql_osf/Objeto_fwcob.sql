select a.object_id Codigo,
       'ge_object_' || a.object_id || '.sql' Nombre_Objeto,
       a.name_ Servicio,
       a.description Descripcion,
       a.object_type_id || ' - ' || got.description Tipo_Objeto,
       a.module_id || ' - ' || gm.description Modulo
  from open.ge_object a
  left join open.ge_object_type got
    on got.object_type_id = a.object_type_id
  left join open.ge_module gm
    on gm.module_id = a.module_id
 where 1 = 1
   and upper(a.name_) LIKE upper('%LDC_PKGESTIONCASURP%')
--and upper(a.description) LIKE upper('%Valida actividad de suspension por reforma desde%')
