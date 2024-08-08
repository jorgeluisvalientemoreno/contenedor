select cc.subscription_id,
       cc.restriction_id ,
       cc.package_type_id,
       cc.restriction_type_id, 
       cc.restriction_statu_id,
       cc.comment_   
from open.cc_restriction cc
inner join open.servsusc s on cc.subscription_id = s.sesususc


select *
from CC_RESTRICTION
where package_type_id=300;



select *
from OPEN.CC_RESTRICTION_LOG;

select *
from OPEN.MO_RESTRICTION
;

select *
from OPEN.FORMPAGO
;
select *
from MO_RESTRICTION_TYPE;

SELECT *
FROM PS_PACK_TYPE_PARAM;

SELECT *
FROM VW_MO_REST_MO_MOT;
SELECT *
FROM VW_CC_RESTRICTION;
SELECT *
FROM CC_RESTRICTION_STATU
;
select *
from dba_tab_columns
where column_name like '%RESTRICTION%'
