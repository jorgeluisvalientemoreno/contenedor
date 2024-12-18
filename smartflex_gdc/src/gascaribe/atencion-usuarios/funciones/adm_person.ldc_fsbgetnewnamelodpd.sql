CREATE OR REPLACE FUNCTION "ADM_PERSON"."LDC_FSBGETNEWNAMELODPD" (inuPackage  in  number,
                                                    inucontrato in  number) return varchar2 is
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : ldc_fsbGetNewNameLODPD
  Descripcion    : Funci?n para consultar el nuevo nombre y apellido
                   en la tabla ldc_datos_actualizar
  Autor          : Jose Edward Hinestroza
  Fecha          : 24/02/2015

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor                Modificacion
  =========       =========             ====================
  24/02/2015      jhinestroza           Creaci?n
  ******************************************************************/
  osbNombreApellido  varchar2(2000);

  CURSOR curGetData(nuPackage number, nuContrato number) IS
         SELECT a.new_name||' '||a.new_lastname "nombres"
           FROM ldc_datos_actualizar a
          WHERE a.package_id = nuPackage
            AND a.idcontrato = nuContrato
            AND a.old_name is not null
            AND a.old_lastname is not null;
  BEGIN
  ut_trace.trace('Inicio ldc_fsbGetNewNameLODPD', 10);

  OPEN curGetData(inuPackage, inucontrato);
  FETCH curGetData INTO osbNombreApellido;
  CLOSE curGetData;

  IF osbNombreApellido is null THEN
    osbNombreApellido := '';
    RETURN osbNombreApellido;
  END IF;

  ut_trace.trace('Fin ldc_fsbGetNewNameLODPD', 10);

  RETURN osbNombreApellido;

  EXCEPTION
  WHEN NO_DATA_FOUND THEN
    RETURN '';
  WHEN OTHERS THEN
    RETURN '';
END ldc_fsbGetNewNameLODPD;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_FSBGETNEWNAMELODPD', 'ADM_PERSON');
END;
/
