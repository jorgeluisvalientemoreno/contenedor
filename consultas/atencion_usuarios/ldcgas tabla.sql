SELECT *
FROM LDC_REP_AREA_TI_PA_CA
WHERE PACKAGE_TYPE_ID in (271)


update LDC_REP_AREA_TI_PA_CA
set catecodi =1
where organizat_area_id = 2011
and package_type_id=271 
