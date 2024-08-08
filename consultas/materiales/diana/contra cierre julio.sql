select u.operating_unit_id,
       u.items_id,
       sum(decode(movement_type,'D',-1,'I',1)*amount) cantidad,
       sum(decode(movement_type,'D',-1,'I',1)*total_value) valor,
       u.balance, --(select balance from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_act, (select balance from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cant_inv,
       u.total_costs--, (select total_costs from open.ldc_act_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id)cost_act, (select total_costs from open.ldc_inv_ouib b where u.items_id=b.items_id and u.operating_unit_id=b.operating_unit_id) cost_inv
from (select operating_unit_id, movement_type, items_id,  amount, total_value from open.or_uni_item_bala_mov where movement_type!='N' and move_date>='01/08/2017'
     union all
     select/* 1 , 'I',*/ operating_unit_id, 'I' movement_type,  items_id, balance, total_costs
       FROM OPEN.ldc_osf_salbitemp where nuano=2017 and numes=07
        ) m,
       open.or_ope_uni_item_bala u
where u.operating_unit_id=m.operating_unit_id
  and movement_type!='N'
  and m.items_id=u.items_id
  --and m.items_id=10004070
  having sum(decode(movement_type,'D',-1,'I',1)*amount)=u.balance and round(sum(decode(movement_type,'D',-1,'I',1)*total_value))!=round(u.total_costs)
group by u.operating_unit_id,u.items_id, u.balance, u.total_costs;

 
