declare
cursor cuDatos is
select /*+ index (o1 PK_OR_OPE_UNI_ITEM_BALA) index (o2 PK_LDC_ACT_OUIB) index (o3 PK_LDC_INV_OUIB)*/
 b.operating_unit_id CODIGO_UNIDAD_OPERATIVA,
 open.daor_operating_unit.fsbgetname(b.operating_unit_id, null) DESCRIPCION_UNIDAD_OPERATIVA,
 b.items_id CODIGO_ITEM,
 open.dage_items.fsbgetdescription(b.items_id, null) DESCRIPCION_ITEM,
 b.balance CANTIDAD_EXISTENTE_BODEGA,
-- 
 (select o3.balance
    from open.ldc_INV_ouib o3
   where o3.items_id = b.items_id
     and b.operating_unit_id = o3.operating_unit_id) CANTIDAD_EXISTENTE_INVENTARIO,
  (select nvl(o3.balance,1)
    from open.ldc_act_ouib o3
   where o3.items_id = b.items_id
     and b.operating_unit_id = o3.operating_unit_id) CANTIDAD_EXISTENTE_ACTIVO,
 b.total_costs COSTO_BODEGA,
 (select o3.total_costs
    from open.ldc_INV_ouib o3
   where o3.items_id = b.items_id
     and b.operating_unit_id = o3.operating_unit_id) COSTO_INVENTARIO,
  (select o3.total_costs
    from open.ldc_act_ouib o3
   where o3.items_id = b.items_id
     and b.operating_unit_id = o3.operating_unit_id) COSTO_ACTIVO

  from open.OR_OPE_UNI_ITEM_BALA b
 where (nvl((select balance from open.ldc_inv_ouib o3 where o3.operating_unit_id= b.operating_unit_id and items_id=b.items_id),0)+
      nvl((select balance from open.ldc_act_ouib o3 where o3.operating_unit_id= b.operating_unit_id and items_id=b.items_id),0)) !=balance
   --AND B.ITEMS_ID=10004070
   And total_costs=0
  and nvl((select balance from open.ldc_act_ouib o3 where o3.operating_unit_id= b.operating_unit_id and items_id=b.items_id),0)=0
  and operating_unit_id not in (799,2028)
   and items_id not like '4%'
  --and items_id =10004070
  and items_id not in (100003008,100003011 )
  and (select o3.total_costs
    from open.ldc_INV_ouib o3
   where o3.items_id = b.items_id
     and b.operating_unit_id = o3.operating_unit_id)=0
  and (nvl((select balance from open.ldc_inv_ouib o3 where o3.operating_unit_id= b.operating_unit_id and items_id=b.items_id),0)+
      nvl((select balance from open.ldc_act_ouib o3 where o3.operating_unit_id= b.operating_unit_id and items_id=b.items_id),0))<balance;
begin
  for reg in cuDatos loop
      update  open.ldc_inv_ouib o3
          set balance= reg.CANTIDAD_EXISTENTE_BODEGA
        where o3.operating_unit_id= reg.CODIGO_UNIDAD_OPERATIVA 
          and items_id=reg.CODIGO_ITEM;
  end loop;
exception
  when others then
    dbms_output.put_line('Error: '||sqlerrm);
end;
/