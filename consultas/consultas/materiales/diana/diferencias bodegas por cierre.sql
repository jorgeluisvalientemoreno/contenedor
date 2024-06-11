with base as
(SELECT nuano, 
        numes, 
        operating_unit_id, 
        items_id, 
        balance cantidad_mes, 
        total_costs costo_mes, 
        nvl((select sum(decode(movement_type,'I',1,'D',-1)*amount) from open.or_uni_item_bala_mov_copia2 m where m.operating_unit_id=s.operating_unit_id and m.items_id=s.items_id and m.movement_type!='N' and move_date >='01/'||numes||'/'||nuano and move_date<case when numes=12 then '01/01/'||(nuano+1) else '01/'|| (numes+1)||'/'||(nuano) end),0) cantidad,
        nvl((select sum(decode(movement_type,'I',1,'D',-1)*total_value) from open.or_uni_item_bala_mov_copia2 m where m.operating_unit_id=s.operating_unit_id and m.items_id=s.items_id and m.movement_type!='N' and move_date >='01/'||numes||'/'||nuano and move_date<case when numes=12 then '01/01/'||(nuano+1) else '01/'|| (numes+1)||'/'||(nuano) end),0) valor
FROM OPEN.ldc_osf_salbitemp s 
where operating_unit_id=1927
  and items_id=	10005189

  and nuano>=2017
  and ((nuano=2017 and numes>=7) or nuano>2017)
  order by nuano, numes),
base2 as(  
select base.*, 
       s.nuano ano_ante, 
       s.numes mes_ante, 
       case when s.nuano=2017 and s.numes = 6 then 0 else s.balance end  cant_mes_ante, 
       case when s.nuano=2017 and s.numes = 6 then 0 else s.total_costs end costo_mes_ante
from base, open.ldc_osf_salbitemp s
where base.operating_unit_id=s.operating_unit_id
  and base.items_id=s.items_id
  and ((base.nuano=s.nuano and base.numes=s.numes+1 and s.numes!=12)  or
      (base.nuano=s.nuano+1 and s.numes=12 and base.numes=1 )
  ))
select base2.*,
       case when ano_ante=2017 and mes_ante = 6 then 0 else (base2.cant_mes_ante+cantidad)-cantidad_mes end diferencia_cantidad,
       case when ano_ante=2017 and mes_ante = 6 then 0 else (base2.costo_mes_ante+valor)-costo_mes end diferencia_valor
from base2
--where (base2.cant_mes_ante+cantidad)!=cantidad_mes
   --or (base2.costo_mes_ante+valor)!=costo_mes
order by nuano, numes;
