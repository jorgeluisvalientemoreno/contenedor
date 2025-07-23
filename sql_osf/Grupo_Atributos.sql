select gasa.attribute_set_id || ' - ' || gas.description Grupo,
       gasa.attribute_id || ' - ' || ga.name_attribute Atributo,
       gasa.initial_expression Regla_Incializacion,
       gasa.valid_expression Regla_Validacion,
       gasa.capture_order Orden,
       gasa.mandatory Obligatorio,
       gasa.statement_id Sentencia
  from OPEN.GE_ATTRIB_SET_ATTRIB gasa
 inner join OPEN.GE_ATTRIBUTES_SET gas
    on gas.attribute_set_id = gasa.attribute_set_id
 inner join OPEN.GE_ATTRIBUTES ga
    on ga.attribute_id = gasa.attribute_id
 where 1 = 1
   and gasa.attribute_set_id = 13040
   and gasa.attribute_id in
       (select a.attribute_id
          from open.ge_attributes a
         where a.name_attribute like '%COMER%'
            or a.comment_ like '%COMER%'
            or a.display_name like '%COMER%')
