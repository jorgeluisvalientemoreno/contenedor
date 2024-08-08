select m.uni_item_bala_mov_id, m.item_moveme_caus_id, m.movement_type, m.amount, m.move_date,  d.document_type_id, d.documento_externo, d.operating_unit_id,open.daor_operating_unit.fsbgetname(d.operating_unit_id),  d.destino_oper_uni_id , o.name, causal_id
from open.or_uni_item_bala_mov m, open.ge_items_documento d , open.or_operating_unit o
where m.operating_unit_id=1885 
  and m.items_id=10007713 
  and d.id_items_documento=m.id_items_documento
 -- and m.movement_type in ('I','D')
  and o.operating_unit_id=d.destino_oper_uni_id
  order by 1;
  

select a.operating_unit_id, 
       u.name desc_uni,
       u.es_externa externa, 
       a.items_id,
       i.description desc_item,
       i.item_classif_id clas,a.quota, a.balance, (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,
       a.total_costs, (select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,
       A.TRANSIT_IN,A.TRANSIT_OUT
from OPEN.OR_OPE_UNI_ITEM_BALA a 
inner join open.ge_items i on i.items_id=a.items_id
inner join open.or_operating_unit u on u.operating_unit_id = a.operating_unit_id
where a.operating_unit_id=4588
and a.items_id=10007051
  
select *
from open.ge_items_seriado
where operating_unit_id IN ( 3117 ) 
  and items_id=10000114
  and serie in ('F-8311921-13' ,'U-1730698-2011');
select * from open.ldc_inv_ouib b where operating_unit_id=1886  
  
select a.operating_unit_id,open.daor_operating_unit.fsbgetname(a.operating_unit_id), a.items_id, a.balance, (select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cant_inv,
                   a.total_costs, (select total_costs from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id) cost_inv,
                   A.TRANSIT_IN,A.TRANSIT_OUT
from OPEN.OR_OPE_UNI_ITEM_BALA a 
where a.balance!=nvl((select balance from open.ldc_inv_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id), 0)+
      nvl((select balance from open.ldc_act_ouib b where a.items_id=b.items_id and a.operating_unit_id=b.operating_unit_id),0)
      and items_id not like '4%'
      and items_id not in (100003008 , 100003011)
      and a.operating_unit_id not in (799,77)
      and a.operating_unit_id=2248;
   





/*select m.uni_item_bala_mov_id, m.item_moveme_caus_id, m.movement_type, m.amount, m.move_date,  d.document_type_id, d.documento_externo, d.operating_unit_id,open.daor_operating_unit.fsbgetname(d.operating_unit_id),  d.destino_oper_uni_id , o.name, causal_id
from open.or_uni_item_bala_mov m, open.ge_items_documento d , open.or_operating_unit o
where m.operating_unit_id=3124 
  and m.items_id=10007291
  and d.id_items_documento=m.id_items_documento
 -- and m.movement_type in ('I','D')
  and o.operating_unit_id=d.destino_oper_uni_id
  order by 1;*/
  
  
  
  select u.operating_unit_id,
       u.items_id, sum(decode(movement_type,'D',-1,'I',1)*amount) cantidad, sum(decode(movement_type,'D',-1,'I',1)*total_value) valor,
       u.balance, --(select balance from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_inv, 
       u.total_costs--, (select total_costs from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cost_inv
from (select operating_unit_id, movement_type, items_id,  amount, total_value from open.or_uni_item_bala_mov 
     /*where operating_unit_id=1878
      and items_id=10000170*/
     union all
     select b.cuadhomo, 'I' movement_type, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) items_id, eixbdisu, eixbvlor
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        /*and B.CUADHOMO=1878
        and  nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0)=10000170*/
        ) m, 
       open.or_ope_uni_item_bala u 
where m.operating_unit_id IN (1850,1854,1878,1910,2024,2445,1518,1512,1515,1520,1521,1522,1527,1885,2199,2302,2402)
  and u.operating_unit_id=m.operating_unit_id
  and movement_type!='N'
  and m.items_id=u.items_id
group by u.operating_unit_id,u.items_id, u.balance, u.total_costs;


SELECT nuano, numes, balance, total_costs, (select sum(decode(movement_type,'I',1,'D',-1)*amount) from open.or_uni_item_bala_mov m where m.operating_unit_id=s.operating_unit_id and m.items_id=s.items_id and m.movement_type!='N' and move_date >='01/'||numes||'/'||nuano and move_date<case when numes=12 then '01/01/'||(nuano+1) else '01/'|| (numes+1)||'/'||(nuano) end) cantidad,
(select sum(decode(movement_type,'I',1,'D',-1)*total_value) from open.or_uni_item_bala_mov m where m.operating_unit_id=s.operating_unit_id and m.items_id=s.items_id and m.movement_type!='N' and move_date >='01/'||numes||'/'||nuano and move_date<case when numes=12 then '01/01/'||(nuano+1) else '01/'|| (numes+1)||'/'||(nuano) end) valor
FROM OPEN.ldc_osf_salbitemp s where operating_unit_id=2705
  and items_id=10008397
  order by nuano, numes;
  
SELECT *
FROM OPEN.GE_ITEMS_DOC_REL
WHERE ID_ITEMS_DOC_origen in (542410);


with base as(
select u.operating_unit_id,
       u.items_id, 
       sum(decode(movement_type,'D',-1,'I',1)*amount) cantidad, 
       sum(decode(movement_type,'D',-1,'I',1)*total_value) valor,
       u.balance, 
       (select balance
          from open.ldc_act_ouib b
         where u.items_id = b.items_id
           and u.operating_unit_id = b.operating_unit_id) cant_act,
       (select balance
          from open.ldc_inv_ouib b
         where u.items_id = b.items_id
           and u.operating_unit_id = b.operating_unit_id) cant_inv,
          (select total_costs
          from open.ldc_act_ouib b
         where u.items_id = b.items_id
           and u.operating_unit_id = b.operating_unit_id) cost_act,
       (select total_costs
          from open.ldc_inv_ouib b
         where u.items_id = b.items_id
           and u.operating_unit_id = b.operating_unit_id) cost_inv, 
       u.total_costs,
       u.transit_in,
       u.transit_out
from (select operating_unit_id, movement_type, items_id,  amount, total_value from open.or_uni_item_bala_mov 
     union all
     select b.cuadhomo, 'I' movement_type, nvl(migra.FNUGETITEMOSF_ROLLOUT(eixbitem, a.BASEDATO),0) items_id, eixbdisu, eixbvlor
       FROM MIGRA.LDC_TEMP_EXITEBOD_SGE A, MIGRA.LDC_MIG_CUADCONT B
      WHERE A.EIXBBCUA = B.CUADCODI
        AND A.BASEDATO = B.BASEDATO
        ) m, 
       open.or_ope_uni_item_bala u 
where m.operating_unit_id in (1850,1854,1878,1910,2024,2445,1518,1512,1515,1520,1521,1522,1527,1885,2199,2302,2402)
  and u.operating_unit_id=m.operating_unit_id
  and movement_type!='N'
  and m.items_id=u.items_id
group by u.operating_unit_id,u.items_id, u.balance, u.total_costs, u.transit_in, u.transit_out)
select base.operating_unit_id, u.name nombre_unidad,
       base.items_id, (select description from open.ge_items i where i.items_id=base.items_id) desc_item,
       base.balance cant_bodega_padre,
       base.cantidad cantidad_movimientos,
       base.cant_inv cant_inventario,
       base.cant_act cant_activo,
       base.total_costs costo_bodega_padre,
       base.valor valor_movimientos,
       base.cost_inv costo_inventario,
       base.cost_act costo_activo,
       base.transit_in transito_entrante,
       base.transit_out transito_saliente,
     case when nvl(cant_act,0)+nvl(cant_inv,0)!=nvl(balance,0) then 'S' else 'N' end validar_cantidad,
     case when nvl(cost_act,0)+nvl(cost_inv,0)!=nvl(total_costs,0) then 'S' else 'N' end validar_costo,
     case when nvl(cantidad,0)!=nvl(balance,0) then 'S' else 'N' end validar_mov_cant,
     case when round(nvl(valor,0))!=round(nvl(total_costs,0)) then 'S' else 'N' end validar_mov_cost,
     case when nvl(cant_act,0)<0 then 'S' else 'N' end validar_cant_activo,
     case when nvl(cant_inv,0)<0 then 'S' else 'N' end validar_cant_inventario,
     case when nvl(cost_act,0)<0 then 'S' else 'N' end validar_cost_activo,
     case when nvl(cost_inv,0)<0 then 'S' else 'N' end validar_cost_inv,
     case when nvl(balance,0)=0 and nvl(total_costs,0)!=0 then 'S' else 'N' end valida_costo_cantidad
from base
inner join open.or_operating_unit u on u.operating_unit_id=base.operating_unit_id


select MOVE_DATE, ITEMS_ID ITEM, M.OPERATING_UNIT_ID UNIDAD,
       M.TARGET_OPER_UNIT_ID UND_DEST,(SELECT NAME FROM OPEN.OR_OPERATING_UNIT U WHERE U.OPERATING_UNIT_ID=M.TARGET_OPER_UNIT_ID) NOMBRE,
       D.ID_ITEMS_DOCUMENTO DOCUM,
       MOVEMENT_TYPE TIPO, (SELECT M.ITEM_MOVEME_CAUS_ID||'-'||OC.DESCRIPTION FROM OPEN.OR_ITEM_MOVEME_CAUS OC WHERE OC.ITEM_MOVEME_CAUS_ID=M.ITEM_MOVEME_CAUS_ID) CAUSA,
       AMOUNT CANT,
       D.DOCUMENTO_EXTERNO,
       (SELECT I.MMITNUDO FROM OPEN.LDCI_INTEMMIT I WHERE 'AUTO_'||I.MMITDSAP=D.DOCUMENTO_EXTERNO) RESERVA_ORIGEN,
       NVL((SELECT D2.USER_ID||'-'||S.MASK FROM OPEN.LDCI_INTEMMIT I, OPEN.GE_ITEMS_DOCUMENTO D2, OPEN.SA_USER S WHERE 'AUTO_'||I.MMITDSAP=D.DOCUMENTO_EXTERNO AND TO_CHAR(D2.ID_ITEMS_DOCUMENTO)=MMITNUDO AND S.USER_ID=D2.USER_ID),
           (SELECT D.USER_ID||'-'||S.MASK FROM OPEN.SA_USER S WHERE S.USER_ID=D.USER_ID)) USUARIO,
       (SELECT D2.COMENTARIO FROM OPEN.LDCI_INTEMMIT I, OPEN.GE_ITEMS_DOCUMENTO D2 WHERE 'AUTO_'||I.MMITDSAP=D.DOCUMENTO_EXTERNO AND TO_CHAR(D2.ID_ITEMS_DOCUMENTO)=MMITNUDO ),
       (SELECT D2.FECHA FROM OPEN.LDCI_INTEMMIT I, OPEN.GE_ITEMS_DOCUMENTO D2 WHERE 'AUTO_'||I.MMITDSAP=D.DOCUMENTO_EXTERNO AND TO_CHAR(D2.ID_ITEMS_DOCUMENTO)=MMITNUDO )
from open.or_uni_item_bala_mov m, open.ge_items_documento d
where m.items_id=10004508
  and m.operating_unit_id=1879
--  and m.amount=1
  and m.move_date>='01/01/2019'
  and m.id_items_Documento=d.id_items_documento
  and movement_type!='N'
  order by move_date;


