select ar.package_area_id,
       ar.package_type_id,
       tp.description,
       ar.causal_type_id,
       tc.description,
       ar.causal_id,
       cc.description,
       ar.causing_area_id,
        ao.name_,
       ar.management_area_id , CC.CAUSAL_TYPE_ID 
from PS_PACKAGE_AREAS ar
 inner join PS_PACKAGE_TYPE  tp  on tp.package_type_id = ar.package_type_id
 inner join CC_CAUSAL_TYPE tc  on tc.causal_type_id = ar.causal_type_id
 inner join CC_CAUSAL  cc  on  cc.causal_id = ar.causal_id AND cc.ACTIVE = 'Y'
 left outer join GE_ORGANIZAT_AREA  ao  on  ao.organizat_area_id = ar.causing_area_id
 where 1=1
  and ar.package_type_id in (545,100030)
  and ar.causing_area_id = 48;
 

 INSERT INTO PS_PACKAGE_AREAS 
 SELECT SEQ_PS_PACKAGE_AREA_180963.NEXTVAL,
  AR.PACKAGE_TYPE_ID, 
  AR.CAUSAL_TYPE_ID, 
  AR.CAUSAL_ID, 
  '5153' as CAUSING_AREA_ID, 
  '5153' as MANAGEMENT_AREA_ID 
 FROM OPEN.PS_PACKAGE_AREAS AR
 INNER JOIN OPEN.CC_CAUSAL  CC  ON  CC.CAUSAL_ID = AR.CAUSAL_ID  --AND CC.ACTIVE = 'Y'
 WHERE package_type_idin (545,100030)
 AND AR.CAUSING_AREA_ID = 48

 
