--ordenes_pendientes_x_liquidar_x_unidades
select c.id_contratista,
       c.id_tipo_contrato,
       oo.defined_contract_id,
       oou.operating_unit_id,
       oou.name  desc_unidad_operativa,
       lcu.tipo_ofertado,
       lof.id_zona_oper,
       ab.geograp_location_id,
       oi.items_id,
       nvl(SUM(oi.legal_item_amount),0)  suma_item
  from  open.or_order oo
       inner join open.or_operating_unit oou  on oou.operating_unit_id  = oo.operating_unit_id
       inner join open.or_order_activity ooa  on ooa.order_id = oo.order_id
       inner join ge_contrato  c  on c.id_contrato = oo.defined_contract_id
       left join ldc_const_unoprl lcu  on lcu.unidad_operativa = oo.operating_unit_id
       left join  ab_address  ab  on ab.address_id = ooa.address_id
       left join  ldc_zona_loc_ofer_cart lof on lof.localidad  = ab.GEOGRAP_LOCATION_ID
       left join  or_order_items oi on oi.order_id = oo.order_id
       left join  open.ge_causal ca  on ca.causal_id = oo.causal_id
   where lcu.tipo_ofertado    = 1
 and oou.operating_unit_id  in (4205)
 and oo.order_status_id     = 8
 and oo.is_pending_liq      = 'Y'
 and ca.class_causal_id     = 1
 and c.status               = 'AB'
 and oi.value               > 0
 and c.id_tipo_contrato     = 890
 --and oi.items_id            in (100005914,100005930,100005932,100005935)
 
 --and c.id_tipo_contrato     = 890
  group by c.id_contratista,
           c.id_tipo_contrato,
           oou.operating_unit_id,
           oou.name,
           lcu.tipo_ofertado,
           lof.id_zona_oper,
           oo.defined_contract_id,
           lof.id_zona_oper,
           ab.geograp_location_id,
           oi.items_id
order by oou.operating_unit_id desc, oi.items_id,  lof.id_zona_oper
/*,4251,4272,4277,4280,4283*/
--3533,3534,3535,3607,4130,4205,4207,4208,4209,4210,4309,4310
--/*4250,*/4259,4485
