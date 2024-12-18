create or replace function personalizaciones.fnu_InteraccionConReclamo(inuSolicitudInteraccion number)
  return number is
  /*****************************************************************
  Propiedad intelectual de GDC.
  
  Unidad         : fnu_InteraccionConReclamo
  Descripcion    : Metodo para vlidar si existe tipo de solicitud y medio de recepcion asociados a una interaccion
  Autor          : Jorge Valiente
  Fecha          : 24-01-2024
  Caso           : OSF-1493
  
  Parametros           Descripcion
  ============         ===================
  
  Historia de Modificaciones
  Fecha         Autor                         Modificacion
  ===============================================================
  ******************************************************************/

  csbSP_NAME CONSTANT VARCHAR2(35) := 'fnu_InteraccionConReclamo';

  sbTIPOSOLICITUD  parametros.valor_cadena%type;
  sbMEDIORECEPCION parametros.valor_cadena%type;

  nuError NUMBER; -- se almacena codigo de error
  sbError VARCHAR2(2000); -- se almacena descripcion del error

  cursor cuExiste is
    SELECT (SELECT decode(to_char(count(1)), '0', 0, 1)
              FROM mo_packages a
             WHERE a.package_id in
                   (SELECT PACKAGE_id
                      FROM mo_packages_asso
                     WHERE package_id_asso = inuSolicitudInteraccion)
               AND a.package_type_id IN
                   (SELECT to_number(regexp_substr(sbTIPOSOLICITUD,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS TipoSolicitud
                      FROM dual
                    CONNECT BY regexp_substr(sbTIPOSOLICITUD,
                                             '[^,]+',
                                             1,
                                             LEVEL) IS NOT NULL)
               AND a.RECEPTION_TYPE_ID IN
                   (SELECT to_number(regexp_substr(sbMEDIORECEPCION,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS MedioRecepcion
                      FROM dual
                    CONNECT BY regexp_substr(sbMEDIORECEPCION,
                                             '[^,]+',
                                             1,
                                             LEVEL) IS NOT NULL)) FLAG_VALIDATE
      FROM dual;

  nuExiste number := 0;

begin

  pkg_traza.trace(csbSP_NAME,
                  pkg_traza.cnuNivelTrzDef,
                  pkg_traza.csbINICIO);

  pkg_traza.trace('Solicitud Interaccion: ' || inuSolicitudInteraccion,
                  pkg_traza.cnuNivelTrzDef);

  sbTIPOSOLICITUD := pkg_parametros.fsbGetValorCadena('TIPO_SOLICITUD_VALIDA_INTERACCION');
  pkg_traza.trace('TIPO_SOLICITUD_VALIDA_INTERACCION: ' || sbTIPOSOLICITUD,
                  pkg_traza.cnuNivelTrzDef);
  if sbTIPOSOLICITUD is null then
    pkg_error.setError;
    return nuExiste;
  end if;

  sbMEDIORECEPCION := pkg_parametros.fsbGetValorCadena('MEDIO_RECEPCION_VALIDA_INTERACCION');
  pkg_traza.trace('MEDIO_RECEPCION_VALIDA_INTERACCION: ' ||
                  sbMEDIORECEPCION,
                  pkg_traza.cnuNivelTrzDef);
  if sbMEDIORECEPCION is null then
    pkg_error.setError;
    return nuExiste;
  end if;

  open cuExiste;
  fetch cuExiste
    into nuExiste;
  close cuExiste;

  pkg_traza.trace('Retorna: ' || nuExiste);

  pkg_traza.trace(csbSP_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  return nuExiste;

EXCEPTION
  WHEN pkg_error.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERC);
    return nuExiste;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbSP_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbFIN_ERR);
    return nuExiste;
  
end;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('FNU_INTERACCIONCONRECLAMO', 'PERSONALIZACIONES');
END;
/