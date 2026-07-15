select * from LD_SUBSIDY ; 
select * from LD_UBICATION;
select * from LD_MAX_RECOVERY;
select * from LD_SUBSIDY_DETAIL;

select * 
from open.LD_SUBSIDY l
left join open.LD_UBICATION  u on l.subsidy_id = u.subsidy_id
left join open.LD_SUBSIDY_DETAIL d on d.ubication_id =  u.ubication_id   
where --l.subsidy_id in (382,383,384)
 promotion_id in (469,470)  and l.final_date >sysdate  and sucacate= 1 and sucacodi = 2 and geogra_location_id=37  



select * from LD_deal where description like '%MANAURE%' -- CONVENIOS SOBRE LOS CUALES SE CREAN LOS SUBSIDIOS 


select * from open.cc_promotion c where c.promotion_id in (417,418,419,469,470)  ; -- actualizar las ´promociones asociadas al subsidio

