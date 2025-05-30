with flujo as(
select t.unit_type_id flujo_id
from OPEN.PS_PACKAGE_UNITTYPE WT, OPEN.WF_UNIT_TYPE T
where package_type_id in (271)
  AND WT.UNIT_TYPE_ID=T.UNIT_TYPE_ID
),
tipomotivo as(
select pm.motive_type_id codigo 
from OPEN.PS_PRD_MOTIV_PACKAGE mp, OPEN.PS_PRODUCT_MOTIVE pm
where PACKAGE_TYPE_ID in (271)  
 and mp.product_motive_id=pm.product_motive_id
 ),
flujos as(
SELECT 'PRINCIPAL', U.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM WF_UNIT U
INNER JOIN WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID AND U2.UNIT_TYPE_ID in (select flujo_id from flujo )

union all
SELECT 'SECUNDARIOS', U.*, U3.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM WF_UNIT U
INNER JOIN WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID --AND upper(U2.description) like '%T%TULO%'
INNER JOIN WF_UNIT U3 ON u2.unit_type_id=u3.unit_type_id 
WHERE U3.PROCESS_ID=(SELECT UNIT_ID
                                           FROM WF_UNIT
                                          WHERE UNIT_TYPE_ID in (select flujo_id from flujo))


union all
SELECT 'TERCIARIO', A.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM WF_UNIT U
INNER JOIN WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID AND U2.UNIT_TYPE_ID in (select flujo_id from flujo )
INNER JOIN WF_UNIT_TYPE UT ON UT.UNIT_TYPE_ID=U.UNIT_TYPE_ID
INNER JOIN ps_process_comptype C on c.stage_tag_name=UT.TAG_NAME
INNER JOIN WF_UNIT B ON B.UNIT_TYPE_ID=C.UNIT_TYPE_ID
INNER JOIN WF_UNIT A ON B.UNIT_ID=A.PROCESS_ID
WHERE C.MOTIVE_TYPE_ID IN (select codigo from tipomotivo))
select *
from flujos
ORDER BY 1, ORDEN, geometria
;

