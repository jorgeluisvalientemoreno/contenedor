select ex.name NOMBRE_EJECUTABLE,
        e.name_ TABLA,
        1 PESTANAS,
        sum(CASE WHEN D.LIST_OF_VALUES IS NULL THEN 0 ELSE 1 END ) cant_LISTA_VALORES,
        sum(CASE WHEN at.INIT_EXPRESSION_ID IS NULL THEN 0 ELSE 1 END ) cant_reglas_inicializacion,
        sum(CASE WHEN at.VALID_EXPRESSION_ID IS NULL THEN 0 ELSE 1 END ) cant_reglas_validacion,
        count(1) atributos,
        (select count(*) from dba_triggers where TABLE_NAME = e.name_) cant_trigger
  from open.gi_attrib_disp_data  d,
       open.ge_entity_attributes at,
       open.ge_entity            e,
       open.sa_executable        ex
 where d.executable_id = ex.executable_id
   and (name = 'LDISP')
   and d.entity_attribute_id = at.entity_attribute_id
   and d.entity_id = e.entity_id
group by ex.name, e.name_;
