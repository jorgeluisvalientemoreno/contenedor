select a.instance_attrib_id Secuancia,
       a.instance_id Instancia,
       a.attribute_id Atributo,
       a.attribute_id || ' - ' || ga.name_attribute Atributo_Desc,
       a.value Valor,
       a.attrib_layer,
       a.is_duplicable Duplicado,
       a.in_out Flag_Entrada_Salida,
       a.statement_id Sentencia,
       a.statement_id || ' - ' || gs.description Sentencia_Desc,
       a.mandatory Obligatorio
  from OPEN.WF_INSTANCE_ATTRIB a
  left join open.ge_statement gs
    on gs.statement_id = a.statement_id
  left join open.ge_attributes ga
    on ga.attribute_id = a.attribute_id
 where a.instance_id = 1436799089
 order by a.attribute_id;
