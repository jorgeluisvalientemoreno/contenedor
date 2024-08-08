with base as
 (select distinct ps.package_type_id,
                  ps.description,
                  t.unit_type_id flujo_id,
                  (select pm.motive_type_id codigo
                     from OPEN.PS_PRD_MOTIV_PACKAGE mp,
                          OPEN.PS_PRODUCT_MOTIVE    pm
                    where mp.PACKAGE_TYPE_ID = ps.package_type_id
                      and mp.product_motive_id = pm.product_motive_id) motivo
  
    from OPEN.PS_PACKAGE_UNITTYPE WT,
         OPEN.WF_UNIT_TYPE        T,
         open.ps_package_type     ps
   where wt.package_type_id = ps.package_type_id
     AND WT.UNIT_TYPE_ID = T.UNIT_TYPE_ID
     and ps.package_type_id=323
     and exists (select null
            from open.mo_packages p
           where p.package_type_id = ps.package_type_id)),
base2 as(
SELECT base.package_type_id,
       base.description desc_tiso,
       base.flujo_id,
       base.motivo,
       'PRINCIPAL' CODIGO, U.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM open.WF_UNIT U
INNER JOIN open.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID 
INNER JOIN base on base.flujo_id = U2.UNIT_TYPE_ID

union all
SELECT base.package_type_id,
       base.description desc_tiso,
       base.flujo_id,
       base.motivo,
       'SECUNDARIOS' CODIGO, U.*, U3.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM OPEN.WF_UNIT U
INNER JOIN OPEN.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID --AND upper(U2.description) like '%T%TULO%'
INNER JOIN OPEN.WF_UNIT U3 ON u2.unit_type_id=u3.unit_type_id 
INNER JOIN OPEN.WF_UNIT U4 ON U4.UNIT_ID=U3.PROCESS_ID
INNER JOIN BASE ON BASE.FLUJO_ID=U4.UNIT_TYPE_ID
--WHERE U3.PROCESS_ID=(SELECT UNIT_ID FROM WF_UNIT WHERE UNIT_TYPE_ID in (select flujo_id from flujo)                  )
union all
SELECT b.package_type_id,
       b.description desc_tiso,
       b.flujo_id,
       b.motivo,
       'TERCIARIO' CODIGO, A.*, U.DESCRIPTION UNIDAD, U.NODE_TYPE_ID ORDEN, u.geometry geometria
FROM OPEN.WF_UNIT U
INNER JOIN OPEN.WF_UNIT U2 ON U.PROCESS_ID = U2.UNIT_ID --AND U2.UNIT_TYPE_ID in (select flujo_id from flujo )
INNER JOIN BASE B ON FLUJO_ID=U2.UNIT_TYPE_ID
INNER JOIN OPEN.WF_UNIT_TYPE UT ON UT.UNIT_TYPE_ID=U.UNIT_TYPE_ID
INNER JOIN OPEN.ps_process_comptype C on c.stage_tag_name=UT.TAG_NAME
INNER JOIN OPEN.WF_UNIT B ON B.UNIT_TYPE_ID=C.UNIT_TYPE_ID
INNER JOIN OPEN.WF_UNIT A ON B.UNIT_ID=A.PROCESS_ID
WHERE C.MOTIVE_TYPE_ID =B.MOTIVO--IN (select codigo from tipomotivo)
)     
select b.package_type_id,
       b.description desc_tiso,
       b.flujo_id,
       b.motivo,
       b.codigo, 
       b.unit_id,
       b.description,
       b.process_id,
       b.unit_type_id,
       t.description,
       t.category_id,
       (select ca.display_number from OPEN.WF_UNIT_CATEGORY CA where CA.CATEGORY_ID=t.CATEGORY_ID),
       t.is_stage_process,
       b.node_type_id,
       b.action_id,
       b.unidad,
       b.orden,
       b.geometria
from base2  b    
left join open.wf_unit_type t on t.unit_type_id=b.unit_type_id
order by 5, ORDEN, geometria
