--Se valida movimiento de bodega y el ítem seriado.
select distinct (select gi.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = a.items_id) Item,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = a.operating_unit_id) unidad_operativa,
       a.quota,
       a.balance,
       a.total_costs,
       a.occacional_quota,
       a.transit_in,
       a.transit_out,
       b.balance Balance_Inventario,
       b.transit_in Transito_In_Inventario,
       b.transit_out Transito_Out_Inventario,
       c.balance Balance_Inventario,
       c.transit_in Transito_In_Inventario,
       c.transit_out Transito_Out_Inventario
  from open.or_ope_uni_item_bala a
  inner join open.ldc_inv_ouib b
    on b.items_id = a.items_id
  inner join open.ldc_act_ouib c
    on c.items_id = a.items_id
  inner join open.ge_items_seriado gis
    on gis.items_id = a.items_id
  -- and gis.serie = 'MB-1414'
 where 
 a.operating_unit_id in (799) and 
 a.items_id in (4001211,4295313);

--Activo
select *
  from open.ldc_act_ouib a
 where /*a.operating_unit_id = 3041
   and */
 a.items_id in (4001211, 4295313);

--Se valida movimiento de bodega y el ítem seriado.
select (select gi.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = a.items_id) Item,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = a.operating_unit_id) unidad_operativa,
       a.quota,
       a.balance,
       a.total_costs,
       a.occacional_quota,
       a.transit_in,
       a.transit_out
  from open.or_ope_uni_item_bala a
 where /*a.operating_unit_id = 3041
   and */
 a.items_id in (4001211, 4295313);

--Inventario 
select a.*
  from open.ldc_inv_ouib a
 where a.operating_unit_id = 799;
 
select gi.description , oouib.*-- oouib.transit_in--nvl(sum(oouib.transit_in), 0)
  from open.or_ope_uni_item_bala oouib
  inner join open.ge_items gi on gi.items_id= oouib.items_id
  --inner join open.ge_items_seriado gis on gis.items_id= oouib.items_id
 where oouib.operating_unit_id = 799
 and oouib.transit_in > 0;




--Activo
select *
  from open.ldc_act_ouib a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

--Item seriado
select * from open.ge_items_seriado gis where gis.serie in ('MB-1414','MA-2718')
