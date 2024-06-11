select s.operating_unit_id, s.items_id,s.balance,s.total_costs, es_externa,
       u.oper_unit_classif_id,
nvl( (select s2.balance from open.ldc_osf_salbitemp s2 where s2.nuano=2017 and s2.numes=7 and  s2.items_id=s.items_id and s2.operating_unit_id=s.operating_unit_id ),0) +nvl((select sum(decode(movement_type,'D',-1,'I',1)* AMOUNT) FROM OPEN.OR_UNI_ITEM_BALA_MOV_COPIA M WHERE M.OPERATING_UNIT_ID=S.OPERATING_UNIT_ID AND M.ITEMS_ID=S.ITEMS_ID and move_date>='01/08/2017' and move_date<'01/12/2017'),0) AMOUNT,
nvl( (select s2.total_costs from open.ldc_osf_salbitemp s2 where s2.nuano=2017 and s2.numes=7 and  s2.items_id=s.items_id and s2.operating_unit_id=s.operating_unit_id ),0)  +nvl((select sum(decode(movement_type,'D',-1,'I',1)* TOTAL_VALUE) FROM OPEN.OR_UNI_ITEM_BALA_MOV_COPIA M WHERE M.OPERATING_UNIT_ID=S.OPERATING_UNIT_ID AND M.ITEMS_ID=S.ITEMS_ID and move_date>='01/08/2017' and move_date<'01/12/2017' ),0) TOTAL_COSTS

from open.ldc_osf_salbitemp s, open.or_operating_unit u
where nuano=2017
and numes=11
and u.operating_unit_id=s.operating_unit_id
--and es_externa='N'
--and u.operating_unit_id not in (77,799)
--and u.oper_unit_classif_id!=11
--AND U.OPERATING_UNIT_ID=799
;


select *
from open.or_uni_item_bala_mov
where items_id=10004590
  and operating_unit_id=3002
  and move_date>='01/08/2017'
  and move_date<'01/11/2017'
  and movement_type!='N';
select *
from open.or_uni_item_bala_mov_COPIA
where items_id=10004590
  and operating_unit_id=3002
  and move_date>='01/08/2017'
  and move_date<'01/11/2017'
  and movement_type!='N';


select *
  from  open.OR_UNI_ITEM_BALA_MOV m
  where (ID_ITEMS_DOCUMENTO =381184 OR SUPPORT_DOCUMENT='381532')
  and items_id=10004590;
  SELECT *
  FROM OPEN.GE_ITEMS
  WHERE ITEMS_ID=10004590;
