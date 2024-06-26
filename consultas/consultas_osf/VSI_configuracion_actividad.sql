select t1.* from open.PS_ENGINEERING_ACTIV@osfpl t1 where t1.items_id= 100010241
minus
select t.* from PS_ENGINEERING_ACTIV t;
select * from open.LDC_CONF_ENGI_ACTI@Osfpl LCEA where LCEA.ITEMS_ID = 100010241
minus
select * from LDC_CONF_ENGI_ACTI LCEA where LCEA.ITEMS_ID = 100010241;
