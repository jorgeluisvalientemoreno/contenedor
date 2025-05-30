select mta.*, gea.attribute_type_id || ' - ' || gat.description Tipo_Dato -- package_type_id, 'ATRIB_MOTIVE: '||display_name display_name
  from OPEN.PS_PROD_MOTI_ATTRIB mta
 inner join open.PS_PRD_MOTIV_PACKAGE p
    on p.product_motive_id = mta.product_motive_id
  left join OPEN.GE_ENTITY_ATTRIBUTES gea
    on gea.entity_id = mta.entity_id
   and gea.entity_attribute_id = mta.entity_attribute_id
  left join open.GE_ATTRIBUTES_TYPE gat
    on gat.attribute_type_id = gea.attribute_type_id
 where package_type_id = &solicitud
 and mta.included_xml = 'Y' 
--where init_expression_id is not null
--121400640
