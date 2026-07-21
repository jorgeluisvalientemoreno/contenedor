select a.*, rowid
  from ge_entity a
 where a.name_ like upper('%ADDRESS_TYP%');
select a.*, rowid
  from ge_entity_attributes a
 where 1 = 1
   and a.entity_id = (select a1.entity_id
                        from ge_entity a1
                       where a1.name_ = upper('MO_PACKAGES'));
--BLACK_LIST_PRODUCT
select (select a.entity_id || ' - ' || a.name_ || ' - display_name: ' ||
               a.display_name || ' - description: ' || a.description
          from open.ge_entity a
         where a.entity_id = b.entity_id) Entidad,
       (select a.module_id from ge_entity a where a.entity_id = b.entity_id) Modulo,
       (select b.attribute_type_id || ' - ' || gat.description
          from open.ge_attributes_type gat
         where gat.attribute_type_id = b.attribute_type_id) Tipo_Atributo,
       b.length Dimension,
       b.technical_name Nombre_Tecnico,
       b.display_name Nombre_Despliegue,
       b.comment_ Comentario,
       b.tag_element Nombre_TAG,
       a.module_id Modulo
  from open.ge_entity_attributes b
 inner join ge_entity a
    on a.entity_id = b.entity_id
   and a.name_ = 'VW_EMPRESA'
 where 1 = 1
   and upper(b.technical_name) like upper('%ACTIVE%')
/*and b.entity_id in (select a.entity_id
  from ge_entity a
 where
--a.module_id = 21
--and 
 a.name_ = upper('GE_CONTRATISTA'))*/
--and b.attribute_type_id = 2
--and b.length = 1
 ORDER BY B.SECUENCE_;

select b.*, rowid
  from ge_entity_reference b
 where b.parent_entity_id in
       (select a.entity_id from ge_entity a where a.name_ = 'MO_PROCESS')
   and b.child_entity_id in
       (select a.entity_id from ge_entity a where a.name_ = 'SUSCRIPC')
 ORDER BY B.Reference_Seq;

select b.*, rowid
  from GE_ATTRIBUTE_REFERENCE b
 where b.parent_attribute_id in
       (select b1.entity_attribute_id
          from ge_entity_attributes b1
         where b1.entity_id in
               (select a1.entity_id
                  from ge_entity a1
                 where a1.name_ = 'MO_PROCESS'))
   and b.child_attribute_id in
       (select b2.entity_attribute_id
          from ge_entity_attributes b2
         where b2.entity_id in
               (select a2.entity_id
                  from ge_entity a2
                 where a2.name_ = 'MO_PROCESS'));

SELECT col.column_name
  FROM all_tab_columns col, all_col_comments com
 WHERE col.table_name = com.table_name
   AND col.column_name = com.column_name
      --AND col.table_name = 'SISTEMA'
   and col.COLUMN_NAME = 'ID_TIPO_CONTRATO '
 ORDER BY col.table_name, col.column_id;
