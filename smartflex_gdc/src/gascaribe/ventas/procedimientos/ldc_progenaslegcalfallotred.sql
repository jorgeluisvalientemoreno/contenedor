create or replace PROCEDURE ldc_progenaslegcalfallotred(nupasolicitud NUMBER) IS
  /************************************************************************************************
  Propiedad Intelectual de HORBATH TECHNOLOGIES
  
  Funcion     :  ldcfncretornaordensol
  Descripcion :  Devuelve si la solicitud ya tiene orden asociada.
  Ticket    :  200-2180
  Autor       : Elkin Alvarez
  Fecha       : 22-11-2018
  
  DD-MM-YYYY    <Autor>.              Modificaci?n
  -----------  -------------------    -------------------------------------
  15-08-2013   Jorge Valiente         OSF-1390: Reemplazar API OPEN llamado OS_LEGALIZEORDERS por el API PERSONALIZACIONES.API_LEGALIZEORDERS    
  23-01-2024   Diana.Montes           OSF-2240: Se realiza ajustes de validación técnica y 
                                      modificación del cursor CuComent para reemplazar por 
                                      espacio los caracteres que tenga el comentario y se 
                                      encuentren en el parametro CAR_REP_OBS_LEGO
  29/07/2024  Jorge Valiente          OSF-3300: Adicionar codigo de solicitud y motivo a la crecaion de la orden y aplicar homologaciones
  **********************************************************************************************/
  nuorderid  or_order.order_id%TYPE;
  nuActivity OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE;

  sbmensaje      VARCHAR2(10000);
  nupaunidadoper or_operating_unit.operating_unit_id%TYPE;
  nucausalfallo  ge_causal.causal_id%TYPE;
  nupersona      ge_person.person_id%TYPE;
  sbvacomment    or_order_comment.order_comment%TYPE DEFAULT 'PRUEBA LEGALIZACION INCUMPLIDA.';
  nucategoria    mo_motive.category_id%TYPE;
  nuactividad    ge_items.items_id%TYPE;
  numotivo       mo_motive.motive_id%TYPE;
  nudireinst     ab_address.address_id%TYPE;
  nufunccodi     funciona.funccodi%TYPE;
  nmorderid      or_order_activity.order_activity_id%TYPE;

  nuUnidadAtla  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_UNIDAD_OPER_OT_RED_ATLA');
  nuUnidadMagd  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_UNIDAD_OPER_OT_RED_MAGD');
  nuUnidadCesar NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_UNIDAD_OPER_OT_RED_CES');

  nuPersoLegAtla  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_PERSLEG_ATLA');
  nuPersoLegMagd  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_PERSLEG_MAGD');
  nuPersoLegCesar NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_PERSLEG_CESAR');
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;
  csbSP_NAME    CONSTANT VARCHAR2(100) := $$PLSQL_UNIT || '.';
  csbMetodo VARCHAR2(70) := csbSP_NAME || 'ldc_progenaslegcalfallotred';
  nuError   NUMBER;
  sbError   VARCHAR2(2000);

  CURSOR cugetUnidad IS
    SELECT DECODE(L.GEO_LOCA_FATHER_ID,
                  2,
                  nuUnidadCesar,
                  3,
                  nuUnidadAtla,
                  4,
                  nuUnidadMagd) UNIDAD,
           DECODE(L.GEO_LOCA_FATHER_ID,
                  2,
                  nuPersoLegCesar,
                  3,
                  nuPersoLegAtla,
                  4,
                  nuPersoLegMagd) persona
      FROM AB_ADDRESS D, GE_GEOGRA_LOCATION l
     WHERE l.GEOGRAP_LOCATION_ID = D.GEOGRAP_LOCATION_ID
       AND D.ADDRESS_ID = nudireinst;

  sbusuario VARCHAR2(100);

  -- cursores
  CURSOR cuCategoriaM IS
    SELECT m.category_id categoria, m.motive_id motivo
      FROM mo_motive m
     WHERE m.package_id = nupasolicitud;

  CURSOR cuDireccionObs IS
    SELECT v.direccion_sol, v.comment_lega_fal
      FROM ldc_datos_sol_red_cus_fal v
     WHERE v.nro_solicitud = nupasolicitud;

  CURSOR cuUsuario(inupersona ge_person.person_id%TYPE) IS
    SELECT us.mask sbusuario
      FROM sa_user us, ge_person pe
     WHERE us.user_id = pe.user_id
       AND pe.person_id = inupersona;

  CURSOR cuFuncionario(inusuario SA_USER.MASK%TYPE) IS
    SELECT f.funccodi
      FROM funciona f
     WHERE f.funcusba = inusuario;

  CURSOR cuOrderId IS
    SELECT w.order_activity_id
      FROM or_order_activity w
     WHERE w.order_id = nuorderid;

  --Parametro para los caracteres especiales a ser reemplazdos en el observacion
  CURSOR cuParametroCadena is
    SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('CAR_REP_OBS_LEGO'),
                         '[^,]+',
                         1,
                         LEVEL) as Column_Value
      FROM dual
    CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena('CAR_REP_OBS_LEGO'),
                             '[^,]+',
                             1,
                             LEVEL) IS NOT NULL;
  rfcuParametroCadena cuParametroCadena%rowtype;

BEGIN
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  -- Consultamos el campo categoria y motivo
  OPEN cuCategoriaM;
  FETCH cuCategoriaM
    INTO nucategoria, numotivo;
  CLOSE cuCategoriaM;
  if numotivo is null then
    sbmensaje := 'La solicitud : ' || to_char(nupasolicitud) ||
                 ' no tiene motivo asociado.';
    Pkg_Error.SetErrorMessage(isbMsgErrr => sbmensaje);
  end if;

  -- Obtenemos datos de direccion de instalacion y observacion de legalizacion
  OPEN cuDireccionObs;
  FETCH cuDireccionObs
    INTO nudireinst, sbvacomment;
  CLOSE cuDireccionObs;
  if sbvacomment is null then
    sbmensaje  := 'NO SE DILIGENCIO OBSERVBACION DE LEGALIZACION';
    nudireinst := 1;
  else
    FOR rfcuParametroCadena in cuParametroCadena loop
      sbvacomment := replace(sbvacomment,
                             rfcuParametroCadena.Column_Value,
                             ' ');
    END LOOP;
  
  end if;

  -- 0btenemos de acuerdo a la categoria, la actividad de la orden
  IF nucategoria = 1 THEN
    nuactividad := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_ACT_RED_RESIDENCIAL');
  ELSIF nucategoria = 2 THEN
    nuactividad := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_ACT_RED_COMERCIAL');
  ELSIF nucategoria = 3 THEN
    nuactividad := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_ACT_RED_INDUSTRIAL');
  END IF;
  -- Generamos la orden de trabajo
  nuerror   := 0;
  sbmensaje := NULL;
  nuorderid := NULL;

  api_createorder(nuactividad,
                  nupasolicitud,
                  numotivo,
                  NULL,
                  NULL,
                  nudireinst,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  SYSDATE,
                  NULL,
                  'SE GENERA ORDEN POR DOCUMENTACION INCOMPLETA.',
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  NULL,
                  0,
                  NULL,
                  NULL,
                  null,
                  NULL,
                  nuorderid,
                  nuActivity,
                  nuerror,
                  sbmensaje);

  IF nuerror <> 0 THEN
    Pkg_Error.SetErrorMessage(nuerror, sbmensaje);
  ELSE
    --  Asignamos la orden generada
    nuerror   := 0;
    sbmensaje := NULL;
    nupersona := NULL;
  
    --se obtiene unidad operativa
    OPEN cugetUnidad;
    FETCH cugetUnidad
      INTO nupaunidadoper, nupersona;
    IF cugetUnidad%NOTFOUND THEN
      nupaunidadoper := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_UNIDAD_OPER_OT_RED_ATLA');
      nupersona      := nuPersoLegAtla;
    END IF;
    CLOSE cugetUnidad;
  
    api_assign_order(nuorderid, nupaunidadoper, nuerror, sbmensaje);
    IF nuerror <> 0 THEN
      Pkg_Error.SetErrorMessage(nuerror, sbmensaje);
    ELSE
      -- Legalizamos la orden de trabajo con causal de fallo
      nucausalfallo := pkg_bcld_parameter.fnuobtienevalornumerico('PARAM_CAUSAL_FALL_OT_RED');
      -- Obtenemos la persona
      OPEN cuUsuario(nupersona);
      FETCH cuUsuario
        INTO sbusuario;
      CLOSE cuUsuario;
      if sbusuario is null then
        nupersona := NULL;
      end if;
    
      nuerror   := 0;
      sbmensaje := NULL;
    
      -- Obtenemos el funcionario 
      OPEN cuFuncionario(sbusuario);
      FETCH cuFuncionario
        INTO nufunccodi;
      CLOSE cuFuncionario;
      if nufunccodi is null then
        nufunccodi := -1;
      end if;
    
      -- Obtenemos order_activity_id
      OPEN cuOrderId;
      FETCH cuOrderId
        INTO nmorderid;
      CLOSE cuOrderId;
      if nmorderid is null then
        nmorderid := NULL;
      end if;
    
      API_LEGALIZEORDERS(nuorderid || '|' || nucausalfallo || '|' ||
                         nupersona || '|' || 'FUNC_APRUEBA_ORDEN = ' ||
                         nufunccodi ||
                         ';AREA_ORGA_APRUEB_ORDEN=NULL;CARG_APRUEBA_ORDEN=NULL;VOBO_FUNCIONARIO=NULL' || '|' ||
                         nmorderid || '>' || 0 || ';;;;|' || '' || '||' ||
                         '1277;' || sbvacomment,
                         SYSDATE,
                         SYSDATE,
                         NULL,
                         nuerror,
                         sbmensaje);
    
      IF nuerror <> 0 THEN
        Pkg_Error.SetErrorMessage(nuerror, sbmensaje);
      END IF;
    END IF;
  END IF;
  pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
EXCEPTION
  when PKG_ERROR.CONTROLLED_ERROR then
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    RAISE pkg_Error.Controlled_Error;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;
END ldc_progenaslegcalfallotred;
/
grant execute on ldc_progenaslegcalfallotred to SYSTEM_OBJ_PRIVS_ROLE;
/