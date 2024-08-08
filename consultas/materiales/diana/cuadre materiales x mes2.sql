with base as(
SELECT b.*,decode(numes,12,1,numes+1) mes_sig, decode(numes,12,nuano+1,nuano) ano_sig,
decode(numes,1,12,numes-1) mes_ante, decode(numes,1,nuano-1,nuano) ano_ante
FROM OPEN.ldc_osf_salbitemp b
where nuano>=2016
 and operating_unit_id=1927
 and items_id=10001844
 order by nuano, numes)
select base.*,(select b2.balance 
                    from OPEN.ldc_osf_salbitemp b2 where b2.items_id=base.items_id and b2.operating_unit_id=base.operating_unit_id and b2.nuano=base.ano_ante and b2.numes=base.mes_ante) cant_mes_ant,nvl((select sum(decode(m.movement_type,'D',-1,'I',1,0)*m.amount) 
                 from open.or_uni_item_bala_mov m 
                where m.operating_unit_id=base.operating_unit_id 
                  and m.items_id=base.items_id 
                  and m.move_Date>=to_date('01/'||base.numes||'/'||base.nuano,'dd/mm/yyyy')
                  and move_date<to_date('01/'||base.mes_sig||'/'||base.ano_sig,'dd/mm/yyyy')),0) movimientos 
from base
order by nuano, numes
