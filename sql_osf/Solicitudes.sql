--LDCCCRCS

select * from LDC_SUI_CAUS_EQU where tipo_solicitud in (545,50,52);
select * from LDC_SUI_CAUS_EQU where tipo_solicitud in (100337);
90112759 - (CAUSAL_REGISTRO);
SELECT CAUSAL_ID "C�digo",DESCRIPTION "Descripci�n" FROM CC_CAUSAL;
90112762 - (TIPO_SOLICITUD);
SELECT  PACKAGE_TYPE_ID "CODIGO" , DESCRIPTION "DESCRIPCION"  FROM LDC_SUI_VISTA_TIPSOSSPD ORDER BY PACKAGE_TYPE_ID ASC ;
90112891 - (GRUPO_CAUSAL);
SELECT  CODIGO "ID" , DESCRIPCION "DESCRIPTION"  FROM LDC_SUI_GRUPCAUS ORDER BY CODIGO ASC ;
90112892 - (CAUSAL_SSPD);
SELECT  COD_CAUSAL_SSPD "ID" , DESCRIPCION_CAUSAL "DESCRIPTION"  FROM LDC_SUI_CAUSSPD ORDER BY COD_CAUSAL_SSPD ASC

SELECT  CODIGO "ID" , DESCRIPCION "DESCRIPTION"  FROM LDC_SUI_GRUPCAUS ORDER BY CODIGO ASC ;
SELECT  COD_CAUSAL_SSPD "ID" , DESCRIPCION_CAUSAL "DESCRIPTION"  FROM LDC_SUI_CAUSSPD ORDER BY COD_CAUSAL_SSPD ASC ;
SELECT  PACKAGE_TYPE_ID "CODIGO" , DESCRIPTION "DESCRIPCION"  FROM LDC_SUI_VISTA_TIPSOSSPD ORDER BY PACKAGE_TYPE_ID ASC ;
SELECT CAUSAL_ID "C�digo",DESCRIPTION "Descripci�n" FROM CC_CAUSAL;
SELECT * --  CAUSAL_ID "C�digo",DESCRIPTION "Descripci�n"
FROM CC_CAUSAL where causal_id in(
42,45,46,1,4,5,6,7,8,9,10,336,337,338,339,340,341,342,343,345,354,356,358,359,360,361,-1,371,357,372);

--- LDCTTCLRE

SELECT * FROM LDC_SUI_TIPSOL ;
select * from LDC_SUI_TIPRES;
SELECT max(idrespu) FROM ldc_sui_respuesta;   --181
SELECT * FROM ldc_sui_respuesta where tipo_solicitud in (545,50,52);
SELECT * FROM ldc_sui_respuesta where tipo_solicitud in (100338,100337 ,100335 );
SELECT  CODIGO "ID" , DESCRIPCION "DESCRIPTION" , CODIGO_RESP_OSF "TIPO RESPUESTA OSF"  FROM LDC_SUI_TIPRES ORDER BY CODIGO ASC ;
SELECT * FROM LDC_SUI_TITRCALE WHERE respuesta = 183;