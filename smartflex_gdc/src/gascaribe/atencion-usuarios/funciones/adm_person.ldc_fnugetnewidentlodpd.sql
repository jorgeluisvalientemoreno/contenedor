CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FNUGETNEWIDENTLODPD" (inuPackage  in number,
                                                     inucontrato in number) return number is
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : ldc_fnuGetNewIdentLODPD
  Descripcion    : Funci?n para consultar la nueva identificacion en
                   la tabla ldc_datos_actualizar
  Autor          : Jose Edward Hinestroza
  Fecha          : 24/02/2015

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  24/02/2015      jhinestroza           Creaci?n
  ******************************************************************/
  onuIdentificacion number;

  CURSOR curGetData(nuPackage number, nuContrato number) IS
   SELECT a.new_ident "newId"
     FROM ldc_datos_actualizar a
    WHERE a.package_id = nuPackage
      AND a.idcontrato = nuContrato
      AND a.old_ident IS NOT NULL;

  BEGIN
  ut_trace.trace('Inicio ldc_fnuGetNewIdentLODPD', 10);

  OPEN curGetData(inuPackage, inucontrato);
  FETCH curGetData INTO onuIdentificacion;
  CLOSE curGetData;

  IF (onuIdentificacion IS NULL) THEN
    RETURN onuIdentificacion;
  END IF;

  ut_trace.trace('Fin ldc_fnuGetNewIdentLODPD', 10);

  RETURN onuIdentificacion;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN 0;
  WHEN OTHERS THEN
    Dbms_output.put_line('Error ' || SQLERRM);
    RETURN 0;

END ldc_fnuGetNewIdentLODPD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FNUGETNEWIDENTLODPD', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON LDC_FNUGETNEWIDENTLODPD TO REPORTES;
/