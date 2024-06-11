--Tablas subsidios 
select * from open.LD_SUBSIDY ; 
select * from open.LD_UBICATION;
select * from open.LD_MAX_RECOVERY;
select * from open.LD_SUBSIDY_DETAIL;

select * from open.LD_SUBSIDY l
left join open.LD_UBICATION  u on l.subsidy_id = u.subsidy_id
left join open.LD_SUBSIDY_DETAIL d on d.ubication_id =  u.ubication_id   
where promotion_id = 417 ; 


select * from LD_deal where description like '%MANAURE%' --tabla de convenios sobre los que se crean los subsidios ( fechas de vigencias de cc_promotion, ld_subsidy contenidas en las de esta tabla)