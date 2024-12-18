CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNCRETORNAPROCEJECIERR" (nupano NUMBER,nupmes NUMBER,sbprocet VARCHAR2) RETURN NUMBER IS
/**************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2014-02-13
  Descripcion : Validamos si el proceso en el cierre se esta ejecutando

  Parametros Entrada

  Valor de salida
    nupano  Año
    nupmes  Mes
    sbproc  Proceso que se esta ejecutando
 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

***************************************************************************/
nusali NUMBER(2);
BEGIN
 SELECT COUNT(1) INTO nusali
   FROM ldc_osf_estaproc lep
  WHERE lep.ano = nupano
    AND lep.mes = nupmes
    AND TRIM(lep.proceso) = trim(sbprocet);
    RETURN nusali;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNCRETORNAPROCEJECIERR', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_FNCRETORNAPROCEJECIERR TO REXEREPORTES;
/