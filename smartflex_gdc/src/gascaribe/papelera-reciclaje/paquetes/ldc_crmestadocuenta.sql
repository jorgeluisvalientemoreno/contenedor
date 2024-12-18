CREATE OR REPLACE package  LDC_CRMEstadoCuenta is
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_CRMEstadoCuenta
    Descripcion    : Paquete para establecer datos necesarios para el formato
                     de Paz y Salvo definido para el RNP12.
    Autor          : Jorge Valiente
    Fecha          : 28-01-2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    24/09/2024        jsoto             OSF-3315: Se aplican estandares y pautas de desarrollo al paquete
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuCustomer
  Descripcion    : Funcion para la direccion del producto de GAS.
  Autor          : Jorge Valiente
  Fecha          : 28/01/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrcRfCustomer(orfcursor Out constants_per.tyRefCursor); --ab_address.address%type;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuCustomer
  Descripcion    : Funcion para los datos del contacto.
  Autor          : Jorge Valiente
  Fecha          : 28/01/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrcRfContact(orfcursor Out constants_per.tyRefCursor);

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuDiaActual
  Descripcion    : Funcion para obtener el dia actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuDiaActual return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuMesActual
  Descripcion    : Funcion para obtener el Mes actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuMesActual return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuMesActual
  Descripcion    : Funcion para obtener el A?o actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuAnnoActual return number;

end LDC_CRMEstadoCuenta;
/
CREATE OR REPLACE PACKAGE BODY      LDC_CRMEstadoCuenta IS

  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_CRMGoodStanding
    Descripcion    : Paquete para establecer datos necesarios para el formato
                     de Paz y Salvo definido para el RNP12.
    Autor          : Jorge Valiente
    Fecha          : 28/01/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
  ******************************************************************/

    -- Constantes para el control de la traza
    csbSP_NAME 	CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;


  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : PrcRfCustomer
  Descripcion    : Funcion para la datos del cliente del producto GAS.
  Autor          : Jorge Valiente
  Fecha          : 28/01/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  24/09/2024        jsoto             osf-3315 Se ajusta para usar funciones de para
                                      encriptar o reemplazar por asterisco parte del nombre
                                      y la direccion de los usuarios por proteccion de datos personales
  ******************************************************************/
  Procedure PrcRfCustomer(orfcursor Out constants_per.tyRefCursor) is

   csbMetodo        VARCHAR2(100) := csbSP_NAME||'.PrcRfCustomer';
   sbError          VARCHAR2(4000);
   nuError          NUMBER;

  begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   


    OPEN orfcursor FOR
      SELECT distinct pktblsistema.fsbgetcompanyname(99) NOM_EMPRESA,
                      suscripc.susccodi CONTRATO,
                      FSBGETCADENAENCRIPTADA(add_susc.address_parsed,2)DIRECCION,
                      geo_susc.description MUNICIPIO,
                      FSBGETCADENAENCRIPTADA(client.subscriber_name || ' ' ||
                      client.subs_last_name,1) NOMBRE_CLIENTE,
                      contact.subscriber_name || ' ' ||
                      contact.subs_last_name NOM_SOLICITANTE,
                      contact.identification DOC_SOLICITANTE,
                      mo_packages.request_date    FECHA,
                      mo_motive.prov_initial_date FECHA_INICIAL,
                      mo_motive.prov_final_date   FECHA_FINAL
        FROM mo_motive,
             mo_packages,
             suscripc,
             or_operating_unit,
             ab_address         add_susc,
             ge_geogra_location geo_susc,
             ge_subscriber      client,
             ge_subscriber      contact
       WHERE mo_motive.motive_id = cc_bocertificate.fnuMotiveId
         AND mo_motive.package_id = mo_packages.package_id
         AND mo_motive.subscription_id = suscripc.susccodi
         AND suscripc.susciddi = add_susc.address_id
         AND add_susc.geograp_location_id = geo_susc.geograp_location_id
         AND suscripc.suscclie = client.subscriber_id
         AND mo_packages.contact_id = contact.subscriber_id
         AND mo_packages.pos_oper_unit_id = or_operating_unit.operating_unit_id;
		 
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		raise pkg_error.controlled_error;
    when others then
		pkg_Error.setError;
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		raise pkg_error.controlled_error;
  END PrcRfCustomer;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FRfContact
  Descripcion    : Funcion para los datos del contacto.
  Autor          : Jorge Valiente
  Fecha          : 28/01/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  Procedure PrcRfContact(orfcursor Out constants_per.tyRefCursor) is

  csbMetodo        VARCHAR2(100) := csbSP_NAME||'.PrcRfCustomer';
   sbError          VARCHAR2(4000);
   nuError          NUMBER;

  begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    OPEN orfcursor FOR
      SELECT nvl(decode(REGEXP_COUNT(or_operating_unit.address,
                                     '.*?\' || ','),
                        0,
                        (select sistciud from sistema),
                        or_operating_unit.address),
                 NULL) CIUDAD
        FROM mo_motive, mo_packages, or_operating_unit
       WHERE mo_motive.motive_id = cc_bocertificate.fnuMotiveId
         AND mo_motive.package_id = mo_packages.package_id
         AND mo_packages.pos_oper_unit_id =
             or_operating_unit.operating_unit_id;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);   

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
		raise pkg_error.controlled_error;
    when others then
		pkg_Error.setError;
		pkg_Error.getError(nuError, sbError);
		pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		raise pkg_error.controlled_error;
  END PrcRfContact;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuDiaActual
  Descripcion    : Funcion para obtener el dia actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuDiaActual return number IS

    NuDiaActual number;
    csbMetodo        VARCHAR2(100) := csbSP_NAME||'.FnuDiaActual';
	sbError          VARCHAR2(4000);
	nuError          NUMBER;


    cursor cuDiaActual is
      select to_char(sysdate, 'DD') from dual;

  begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    open cuDiaActual;
    fetch cuDiaActual
      into NuDiaActual;
    close cuDiaActual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);   

    return(NuDiaActual);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      NuDiaActual := 0;
      return(NuDiaActual);
    when others then
      pkg_error.setError;
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      NuDiaActual := 0;
      return(NuDiaActual);
  END FnuDiaActual;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuMesActual
  Descripcion    : Funcion para obtener el Mes actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuMesActual return number IS

    NuMesActual number;
   csbMetodo        VARCHAR2(100) := csbSP_NAME||'.FnuMesActual';
	sbError          VARCHAR2(4000);
	nuError          NUMBER;

    cursor cuMesActual is
      select to_char(sysdate, 'MM') from dual;

  begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    open cuMesActual;
    fetch cuMesActual
      into NuMesActual;
    close cuMesActual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);   

    return(NuMesActual);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      NuMesActual := 0;
      return(NuMesActual);
    when others then
      pkg_error.setError;
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      NuMesActual := 0;
      return(NuMesActual);
  END FnuMesActual;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuMesActual
  Descripcion    : Funcion para obtener el A?o actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuAnnoActual return number IS

    NuAnnoActual number;
    csbMetodo        VARCHAR2(100) := csbSP_NAME||'.FnuAnnoActual';
	sbError          VARCHAR2(4000);
	nuError          NUMBER;

    cursor cuAnnoActual is
      select to_char(sysdate, 'YYYY') from dual;

  begin

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   

    open cuAnnoActual;
    fetch cuAnnoActual
      into NuAnnoActual;
    close cuAnnoActual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);   

    return(NuAnnoActual);

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       NuAnnoActual := 0;
      return(NuAnnoActual);
    when others then
     pkg_error.setError;
	  pkg_Error.getError(nuError, sbError);
	  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
	  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      NuAnnoActual := 0;
      return(NuAnnoActual);
  END FnuAnnoActual;

BEGIN
  null;
END LDC_CRMEstadoCuenta;
/
GRANT EXECUTE on LDC_CRMESTADOCUENTA to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LDC_CRMESTADOCUENTA to REXEOPEN;
GRANT EXECUTE on LDC_CRMESTADOCUENTA to RSELSYS;
/
