select a.items_id || ' - ' || gi.description,
       a.operating_unit_id || ' - ' || oou.name Unidad_Operativa,
       a.*
  from open.or_ope_uni_item_bala a
 inner join open.ge_items gi
    on gi.items_id = a.items_id
 inner join open.or_operating_unit oou
    on oou.operating_unit_id = a.operating_unit_id
   and oou.oper_unit_status_id = 1
 where 1 = 1
      --and a.operating_unit_id in (4926, 5138)
      --and a.operating_unit_id
   and a.items_id in (10007054);

select a.*, rowid
  from open.or_ope_uni_item_bala a
 where 1 = 1
   and a.operating_unit_id in (4926, 5138)
   and a.items_id in (10007054);

select a.*, rowid
  from open.ldc_inv_ouib a
 where 1 = 1
      --and a.operating_unit_id in (4926, 5138)
   and a.items_id in (10007054);

select a.*, rowid
  from open.ldc_act_ouib a
 where 1 = 1
      --and a.operating_unit_id in (4926, 5138)
   and a.items_id in (10007054);

select gis.*, rowid
  from open.ge_items_seriado gis
 where 1 = 1
   and gis.items_id = 10007054
--and gis.operating_unit_id in (4926, 5138)
;

select gis.*, rowid
  from open.ge_items_seriado gis
 where 1 = 1
   and gis.items_id = 10007054
   and gis.id_items_estado_inv = 1;
