create or replace FUNCTION              "ADM_PERSON".LDC_CRM_FECHADIA (sbCadenaFecha Varchar2) RETURN date IS
/**************************************************************************
  Autor       : Diego Fernando Rodriguez
  Fecha       : 2013-07-30
  Descripcion : retorna un tipo fecha con horas del final del dia

  Parametros Entrada
     nuAno   ano a evaluar
     nuTipo  Tipo de fecha 1 la inicial 2 la final del ano

  Valor de Retorno
    nudias  dias de mora

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/

 dtFecha date;

BEGIN

  -- Fecha inicial del ano
   dtFecha :=  to_date(sbCadenaFecha||' 23:59:59','DD-MM-YYYY hh24:mi:ss');


 RETURN dtFecha;

EXCEPTION
 WHEN OTHERS THEN
  RETURN dtFecha;
END ldc_crm_fechaDia;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CRM_FECHADIA', 'ADM_PERSON');
END;
/