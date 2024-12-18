CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETVASUPTITR" (NUOPERUNIT OR_OPE_UNI_TASK_TYPE.OPERATING_UNIT_ID%TYPE,
										  NUTT OR_OPE_UNI_TASK_TYPE.TASK_TYPE_ID%TYPE) RETURN NUMBER IS
/**************************************************************************
  Autor       : ESANTIAGO
  Fecha       : 2019-11-14
  Descripcion : validar si la unidad operativa este asociada al tipo de trabajo.

  Parametros Entrada
    nuano A?o
    numes Mes

  Valor de salida
    sbmen  mensaje
    error  codigo del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
 NUVAL NUMBER:=0;
BEGIN

 SELECT 1 INTO NUVAL
 FROM  OR_OPE_UNI_TASK_TYPE OP
 WHERE op.OPERATING_UNIT_ID= NUOPERUNIT
 AND OP.TASK_TYPE_ID= NUTT ;

 RETURN NUVAL;
EXCEPTION
 WHEN OTHERS THEN
  RETURN 0;
END LDC_FNUGETVASUPTITR;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETVASUPTITR', 'ADM_PERSON');
END;
/