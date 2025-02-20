select * 
from open.ld_subsidy l
left join open.ld_ubication  u on l.subsidy_id = u.subsidy_id
left join open.ld_subsidy_detail d on d.ubication_id =  u.ubication_id   
where  promotion_id in (/*453, 454, 455, 88, 458, 482, 483, 485, */469, 470) and l.final_date >sysdate  and sucacate= 1 and sucacodi = 1 and geogra_location_id = 37;


SELECT
        decode(221718566,l.package_id,1,0)
        --INTO nuCode
        FROM ld_asig_subsidy l
        WHERE l.ubication_id= 37
        AND l.package_id = 221718566
        AND state_subsidy <> pkg_bcld_parameter.fnuobtienevalornumerico('SUB_REVERSED_STATE');
        
        sELECT
        *--decode(inuPackage,l.package_id,1,0)
     --   INTO nuCode
        FROM ld_asig_subsidy l
        WHERE l.ubication_id= 37;
        
        select * 
        from ld_parameter  p
        where p.parameter_id = 'SUB_REVERSED_STATE'
