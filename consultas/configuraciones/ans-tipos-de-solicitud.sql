--forma GEANS y CCASI


SELECT C.PACKAGE_TYPE_ID,
       T.DESCRIPTION,
       C.CRITERIOS_ASIG_ID,
       CR.DESCRIPCION,
       CR.TIPO_ASIG_ID,
       TA.DESCRIPCION,
       TA.ENTIDAD_NOMBRE,
       AN.ANS_ID,
       A.DESCRIPTION,
       A.HOURS
FROM OPEN.CC_ASIG_PACK_TYPE C
INNER JOIN PS_PACKAGE_TYPE T ON T.PACKAGE_TYPE_ID=C.PACKAGE_TYPE_ID
LEFT JOIN OPEN.CC_ASIG_ANS AN ON AN.CRITERIOS_ASIG_ID=C.CRITERIOS_ASIG_ID
LEFT JOIN OPEN.CC_CRITERIOS_ASIG CR ON CR.CRITERIOS_ASIG_ID = AN.CRITERIOS_ASIG_ID
LEFT JOIN OPEN.CC_TIPO_ASIG TA ON TA.TIPO_ASIG_ID=CR.TIPO_ASIG_ID
LEFT JOIN OPEN.GE_ANS A ON A.ANS_ID=AN.ANS_ID
;