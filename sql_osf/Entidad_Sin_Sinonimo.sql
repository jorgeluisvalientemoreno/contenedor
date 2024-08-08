/*
/*with esquema as
 (SELECT regexp_substr( \*'OPEN,PERSONALIZACIONES,ADM_PERSON,INNOVACION'*\'PERSONALIZACIONES',
                       '[^,]+',
                       1,
                       LEVEL) AS bdesquema
    FROM dual
  CONNECT BY regexp_substr( \*'OPEN,PERSONALIZACIONES,ADM_PERSON,INNOVACION'*\'PERSONALIZACIONES',
                           '[^,]+',
                           1,
                           LEVEL) IS NOT NULL)
*/ --*/
--/*
with entidad as
 (SELECT regexp_substr(upper('ldc_aud_bloq_lega_sol'),
 --'GE_GEOGRA_LOCATION,CC_COMMERCIAL_PLAN,PR_PRODUCT,OR_OPERATING_UNIT,OR_ORDER,OR_ORDER_ACTIVITY,MO_PACKAGES,SERVSUSC,AB_ADDRESS,OR_TASK_TYPE_CAUSAL',
                       '[^,]+',
                       1,
                       LEVEL) AS bdentidad
    FROM dual
  CONNECT BY regexp_substr(upper('ldc_aud_bloq_lega_sol'),
  --'GE_GEOGRA_LOCATION,CC_COMMERCIAL_PLAN,PR_PRODUCT,OR_OPERATING_UNIT,OR_ORDER,OR_ORDER_ACTIVITY,MO_PACKAGES,SERVSUSC,AB_ADDRESS,OR_TASK_TYPE_CAUSAL',
                           '[^,]+',
                           1,
                           LEVEL) IS NOT NULL)
--
select rownum, a.*, b.*
  from dba_synonyms a, entidad b
 where a.TABLE_NAME(+) = b.bdentidad
   --and a.owner(+) in ('PERSONALIZACIONES')
 order by rownum --a.TABLE_NAME, a.owner
