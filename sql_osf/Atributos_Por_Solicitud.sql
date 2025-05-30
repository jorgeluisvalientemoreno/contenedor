select distinct a.package_type_id Tipo_Solicitud,
                a.process_sequence Secuencia,
                a.required Requerido,
                a.display_name Nombre,
                a.tag_name Tag,
                a.attri_technical_name Nombre_XML,
                a.included_xml Incluido_XML,
                gea.attribute_type_id || ' - ' || gat.description Tipo_Dato,
                a.init_expression_id Regla_Inicializacion,
                (select ge.entity_id || ' - ' || ge.name_
                   from ge_entity ge
                  where ge.entity_id = a.entity_id) Entidad,
                (select gea.entity_attribute_id || ' - ' || gea.display_name
                   from ge_entity_attributes gea
                  where gea.entity_attribute_id = a.entity_attribute_id) Atributo_Entidad,
                a.mirror_enti_attrib || ' - ' || ae.display_name Atributo_espejo_nombre,
                a.mirror_enti_attrib || ' - ' || ae.technical_name Atributo_espejo_tecnico,
                ae.entity_id || ' - ' || ee.name_ Entidad_espejo
  from open.ps_package_attribs a
  left join open.gr_config_expression c
    on c.config_expression_id(+) = a.init_expression_id
  left join ge_entity_attributes ae
    on ae.entity_attribute_id = a.mirror_enti_attrib
  left join ge_entity ee
    on ee.entity_id = ae.entity_id
  left join OPEN.GE_ENTITY_ATTRIBUTES gea
    on gea.entity_id = a.entity_id
   and gea.entity_attribute_id = a.entity_attribute_id
  left join open.GE_ATTRIBUTES_TYPE gat
    on gat.attribute_type_id = gea.attribute_type_id
 where package_type_id = &solicitud
      --and a.required = 'Y'
      --and a.tag_name = 'SUSCIDDI'
   and a.included_xml = 'Y'
 order by a.process_sequence
