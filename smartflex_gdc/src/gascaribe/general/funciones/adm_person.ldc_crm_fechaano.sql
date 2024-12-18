CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_CRM_FECHAANO" (nuAno NUMBER,nuTipo NUMBER) RETURN date IS
/**************************************************************************
  Autor       : Diego Fernando Rodriguez
  Fecha       : 2013-07-30
  Descripcion : Obtiene la fecha inicial o final de un ano

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
  if (nuTipo = 1) then
       dtFecha :=  to_date('01-01-'||nuAno||' 00:00:00','DD-MM-YYYY hh24:mi:ss');
  -- Fecha final del ano
  elsif (nuTipo = 2) then
       dtFecha := to_date('31-12-'||nuAno||' 23:59:59','DD-MM-YYYY hh24:mi:ss');
  end if;

 RETURN dtFecha;

EXCEPTION
 WHEN OTHERS THEN
  RETURN dtFecha;
END ldc_crm_fechaano;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CRM_FECHAANO', 'ADM_PERSON');
END;
/