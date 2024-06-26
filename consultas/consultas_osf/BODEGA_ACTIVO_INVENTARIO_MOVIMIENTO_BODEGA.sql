select 'Bodega', oouib.*, rowid
  from open.or_ope_uni_item_bala oouib
 where oouib.items_id = 10011187
   and oouib.operating_unit_id = 3615
union all
select 'Inventario', oouib.*, rowid
  from open.ldc_inv_ouib oouib
 where oouib.items_id = 10011187
   and oouib.operating_unit_id = 3615
union all
select 'Activo', oouib.*, rowid
  from open.ldc_act_ouib oouib
 where oouib.items_id = 10011187
   and oouib.operating_unit_id = 3615;
select oouib.*, rowid
  from open.or_uni_item_bala_mov oouib
 where oouib.items_id = 10011187
   and oouib.operating_unit_id = 3615
 order by uni_item_bala_mov_id desc;
