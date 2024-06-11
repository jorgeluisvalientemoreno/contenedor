SELECT nuano, numes, s.items_id, s.operating_unit_id,s.balance,
       nvl((select sum(decode(movement_type,'D',-1,'I',1,0)*amount)
        from open.or_uni_item_bala_mov m
        where m.operating_unit_id=s.operating_unit_id
          and m.items_id=s.items_id
          and move_date>=to_date('01/'||numes||'/'||nuano,'dd/mm/yyyy')
          and move_date <case 
                           when numes=12 then 
                             to_date('01/01/'||(nuano+1),'dd/mm/yyyy')
                             else 
                              to_date('01/'||(numes+1)||'/'||nuano,'dd/mm/yyyy') end
          ),0) cantidad , (select b.balance from open.or_ope_uni_item_bala b where b.operating_unit_id=s.operating_unit_id and b.items_id=s.items_id),
          s.total_costs, 
         nvl((select sum(decode(movement_type,'D',-1,'I',1,0)*total_value)
        from open.or_uni_item_bala_mov m
        where m.operating_unit_id=s.operating_unit_id
          and m.items_id=s.items_id
          and move_date>=to_date('01/'||numes||'/'||nuano,'dd/mm/yyyy')
          and move_date <case 
                           when numes=12 then 
                             to_date('01/01/'||(nuano+1),'dd/mm/yyyy')
                             else 
                              to_date('01/'||(numes+1)||'/'||nuano,'dd/mm/yyyy') end
          ),0) valor,
          (select b.total_costs from open.or_ope_uni_item_bala b where b.operating_unit_id=s.operating_unit_id and b.items_id=s.items_id)
FROM OPEN.ldc_osf_salbitemp   s
WHERE items_id=10004070
  and operating_unit_id=799
  and nuano>=2015
  order by nuano, numes;
  

