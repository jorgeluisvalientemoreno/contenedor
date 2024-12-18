CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_RET_FECHA_ATEN_ANUL" (nuPackageId mo_packages.package_id%type) RETURN date IS
/**************************************************************************
  Autor       : Alvaro Zapata
  Fecha       : 08-10-2013
  Descripcion : retorna la fecha de atención de la solicitud de anulación basada en la solicitud padre

  Parametros Entrada
     nuPackageId   solicitud padre

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/

 dtFecha date;

BEGIN

  -- Fecha inicial del ano
SELECT P.ATTENTION_DATE
INTO dtFecha
FROM   MO_PACK_ANNUL_DETAIL MA INNER JOIN MO_PACKAGES P
ON     MA.ANNUL_PACKAGE_ID = P.PACKAGE_ID
WHERE  P.MOTIVE_STATUS_ID         = 14
AND    MA.PACKAGE_ID               = nuPackageId;


 RETURN dtFecha;

EXCEPTION
 WHEN OTHERS THEN
  RETURN dtFecha;
END ldc_Ret_Fecha_Aten_Anul;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_RET_FECHA_ATEN_ANUL', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_RET_FECHA_ATEN_ANUL TO REXEREPORTES;
/
