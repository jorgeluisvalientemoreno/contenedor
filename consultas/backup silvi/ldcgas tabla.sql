SELECT *
FROM LDC_REP_AREA_TI_PA_CA
WHERE PACKAGE_TYPE_ID in (268)


update LDC_REP_AREA_TI_PA_CA
set catecodi =1
where organizat_area_id = 2011
and package_type_id=271 




SELECT c.* , a.name_
FROM open.LDC_REP_AREA_TI_PA_CA c
inner join open.ge_organizat_area a on c .organizat_area_id= a.organizat_area_id
where PACKAGE_TYPE_ID in (268)

-- a.organizat_area_id= 2011 


select *
from MO_ADMIN_ACTIVITY
where external_id = 232936548
; 
select *
from MO_ACTIVITY_LOG
where admin_activity_id = 200250
; 

select *
from WF_UNIT_TYPE
where unit_type_id = 100247;
