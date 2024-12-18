CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_CRMPAZYSALVO IS
  /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : LDC_CRMGoodStanding
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
  ******************************************************************/

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : Fsbaddress
  Descripcion    : Funcion para obtener el nombe del municipio que firma del Servicio de Gas.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION Fsbaddress return or_operating_unit.Address%TYPE;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuGasService
  Descripcion    : Funcion para obtener el codigo del Servicio de Gas.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGasService return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuClientCode
  Descripcion    : Funcion para obtener el codigo del cliente de la solicitud.
  Autor          : Jorge Valiente
  Fecha          : 28-01-2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuCustomerCode return mo_packages.subscriber_id%type;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuContactId
  Descripcion    : Funcion para obtener el codigo del contacto de la solicitud.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContactId return mo_packages.contact_id%type;

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
  Procedure PrcRfCustomer(orfcursor Out constants.tyRefCursor); --ab_address.address%type;

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
  Procedure PrcRfContact(orfcursor Out constants.tyRefCursor);

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
  Descripcion    : Funcion para obtener el Año actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuAnnoActual return number;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuContactCode
  Descripcion    : Funcion para obtener la identificacion del contato.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContactCode return mo_packages.contact_id%type;
    /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuProductId
  Descripcion    : Funcion para obtener el número del servicio suscrito.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  27/08/2012      Sayra Ocoró         Se adiciona filtro por motivo a la consulta
  ******************************************************************/

  FUNCTION FnuProductId return pr_product.product_id%type ;

  /*Función que devuelve la versión del pkg*/
FUNCTION fsbVersion RETURN VARCHAR2;

END LDC_CRMPAZYSALVO;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_CRMPAZYSALVO IS

/*Variable global*/
CSBVERSION                CONSTANT        varchar2(40)  := 'LDC_CRMPazySalvo_2';

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

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : Fsbaddress
  Descripcion    : Funcion para obtener el nombe del municipio que firma del Servicio de Gas.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION Fsbaddress return or_operating_unit.Address%TYPE IS

    SBAddress or_operating_unit.Address%TYPE;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.Fsbaddress', 10);

    select oou.address
      INTO SBAddress
      from or_operating_unit oou
     where oou.operating_unit_id in
           (select oup.operating_unit_id
              from or_oper_unit_persons oup
             where oup.person_id = GE_BOPersonal.fnuGetPersonId)
       and rownum = 1;

    IF SBAddress IS NULL OR SBAddress = '-' THEN
      select SISTCIUD INTO SBAddress from SISTEMA where rownum = 1;
    END IF;

    ut_trace.trace('Fin LDC_CRMPazySalvo.Fsbaddress', 10);

    return(SBAddress);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      select SISTCIUD INTO SBAddress from SISTEMA where rownum = 1;
      return(SBAddress);
    when others then
      select SISTCIUD INTO SBAddress from SISTEMA where rownum = 1;
      return(SBAddress);
  END Fsbaddress;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuGasService
  Descripcion    : Funcion para obtener el codigo del Servicio de Gas.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuGasService return number IS

    NuGasService number;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuCustomerCode', 10);

    NuGasService := nvl(ld_boconstans.cnuGasService, 0);

    ut_trace.trace('Fin LDC_CRMPazySalvo.FnuCustomerCode', 10);

    return(NuGasService);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuGasService := 0;
      return(NuGasService);
    when others then
      Errors.setError;
      NuGasService := 0;
      return(NuGasService);
  END FnuGasService;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuCustomerCode
  Descripcion    : Funcion para obtener el codigo del cliente de la solicitud.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuCustomerCode return mo_packages.subscriber_id%type IS

    NuSubscriberId mo_packages.subscriber_id%type;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuCustomerCode', 10);

    --NuSubscriberId := nvl(damo_packages.fnugetsubscriber_id(ge_boinstancecontrol.fsbGetFieldValue('MO_PACKAGES',
    --                                                                                              'PACKAGE_ID'),
    --                                                        null),
    --                      0);

    NuSubscriberId := nvl(damo_packages.fnugetsubscriber_id(cc_bocertificate.fnupackagesid,
                                                            null),
                          0);

    ut_trace.trace('Fin LDC_CRMPazySalvo.FnuCustomerCode', 10);

    return(NuSubscriberId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuSubscriberId := 0;
      return(NuSubscriberId);
    when others then
      Errors.setError;
      NuSubscriberId := 0;
      return(NuSubscriberId);
  END FnuCustomerCode;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuContactId
  Descripcion    : Funcion para obtener el codigo del contacto de la solicitud.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContactId return mo_packages.contact_id%type IS

    NuContactId mo_packages.subscriber_id%type;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuContactId', 10);

    --NuContactId := nvl(damo_packages.fnugetcontact_id(ge_boinstancecontrol.fsbGetFieldValue('MO_PACKAGES',
    --                                                                                        'PACKAGE_ID'),
    --                                                  null),
    --                   0);

    NuContactId := nvl(damo_packages.Fnugetcontact_Id(cc_bocertificate.fnupackagesid,
                                                      null),
                       0);

    ut_trace.trace('Fin  LDC_CRMPazySalvo.FnuContactId', 10);

    return(NuContactId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuContactId := 0;
      return(NuContactId);
    when others then
      Errors.setError;
      NuContactId := 0;
      return(NuContactId);
  END FnuContactId;

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
  ******************************************************************/
  Procedure PrcRfCustomer(orfcursor Out constants.tyRefCursor) is

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.PrcRfCustomer', 10);

    OPEN orfcursor FOR
      select nvl(c.address, 0) Direccion,
             nvl(dage_geogra_location.fsbgetdescription(c.geograp_location_id,
                                                        null),
                 0) Municipio,
             s.susccodi Contrato,
             sc.subscriber_name || ' ' || sc.subs_last_name NombreCliente
        from servsusc      sv,
             suscripc      s,
             ge_subscriber sc,
             pr_product    b,
             ab_address    c
       where sv.sesususc = s.susccodi
         and s.suscclie = sc.subscriber_id
         and sc.subscriber_id = s.suscclie
         and s.susccodi = ldc_crmpazysalvo.FnuCustomerCode
         and sv.sesunuse = product_id
         and sv.sesuserv = ld_boconstans.cnuGasService
         AND b.address_id = c.address_id;

    ut_trace.trace('Fin LDC_CRMPazySalvo.PrcRfCustomer', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
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
  Procedure PrcRfContact(orfcursor Out constants.tyRefCursor) is

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.PrcRfContact', 10);

    OPEN orfcursor FOR
      select sc.subscriber_name || ' ' || sc.subs_last_name NombreContacto
        from ge_subscriber sc
       where sc.subscriber_id = ldc_crmpazysalvo.FnuContactId;

    ut_trace.trace('Fin LDC_CRMPazySalvo.PrcRfContact', 10);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      raise ex.CONTROLLED_ERROR;
    when others then
      errors.seterror;
      raise ex.CONTROLLED_ERROR;
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

    cursor cuDiaActual is
      select to_char(sysdate, 'DD') from dual;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuDiaActual', 10);

    open cuDiaActual;
    fetch cuDiaActual
      into NuDiaActual;
    close cuDiaActual;

    ut_trace.trace('Fin LDC_CRMPazySalvo.FnuDiaActual', 10);

    return(NuDiaActual);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuDiaActual := 0;
      return(NuDiaActual);
    when others then
      Errors.setError;
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

    cursor cuMesActual is
      select to_char(sysdate, 'MM') from dual;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuMesActual', 10);

    open cuMesActual;
    fetch cuMesActual
      into NuMesActual;
    close cuMesActual;

    ut_trace.trace('Fin LDC_CRMPazySalvo.FnuMesActual', 10);

    return(NuMesActual);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuMesActual := 0;
      return(NuMesActual);
    when others then
      Errors.setError;
      NuMesActual := 0;
      return(NuMesActual);
  END FnuMesActual;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuMesActual
  Descripcion    : Funcion para obtener el Año actual del sistema.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuAnnoActual return number IS

    NuAnnoActual number;

    cursor cuAnnoActual is
      select to_char(sysdate, 'YYYY') from dual;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuMesActual', 10);

    open cuAnnoActual;
    fetch cuAnnoActual
      into NuAnnoActual;
    close cuAnnoActual;

    ut_trace.trace('Fin LDC_CRMPazySalvo.FnuMesActual', 10);

    return(NuAnnoActual);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuAnnoActual := 0;
      return(NuAnnoActual);
    when others then
      Errors.setError;
      NuAnnoActual := 0;
      return(NuAnnoActual);
  END FnuAnnoActual;

  /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuContactCode
  Descripcion    : Funcion para obtener la identificacion del contacto.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/
  FUNCTION FnuContactCode return mo_packages.contact_id%type IS

    NuContactId mo_packages.subscriber_id%type;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuContactId', 10);

    NuContactId := DAGE_SUBSCRIBER.FSBGETIDENTIFICATION(nvl(damo_packages.fnugetcontact_id(ge_boinstancecontrol.fsbGetFieldValue('MO_PACKAGES',
                                                                                                                                 'PACKAGE_ID'),
                                                                                           null),
                                                            0));

    --select identification
    --  into NuContactId
    --  from ge_subscriber
    -- where subscriber_id = nvl(damo_packages.Fnugetcontact_Id(cc_bocertificate.fnupackagesid,
    --                                                          null),
    --                           0);

    --NuContactId:=0;

    ut_trace.trace('Fin  LDC_CRMPazySalvo.FnuContactId', 10);

    return(NuContactId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuContactId := 0;
      return(NuContactId);
    when others then
      Errors.setError;
      NuContactId := 0;
      return(NuContactId);
  END FnuContactCode;

 /*****************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : FnuProductId
  Descripcion    : Funcion para obtener el número del servicio suscrito.
  Autor          :
  Fecha          : 11/07/2012

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  27/08/2012      Sayra Ocoró         Se adiciona filtro por motivo a la consulta
  ******************************************************************/
  FUNCTION FnuProductId return pr_product.product_id%type IS

    NuProductId pr_product.product_id%type;

  begin

    ut_trace.trace('Inicio LDC_CRMPazySalvo.FnuProductId', 10);

    select product_id
    into NuProductId
    from mo_motive
    where package_id = cc_bocertificate.fnupackagesid
    and motive_id = cc_bocertificate.fnuMotiveId;
    ut_trace.trace('Fin  LDC_CRMPazySalvo.FnuProductId', 10);

    return(NuProductId);

  EXCEPTION
    when ex.CONTROLLED_ERROR then
      NuProductId := 0;
      return(NuProductId);
    when others then
      Errors.setError;
      NuProductId := 0;
      return(NuProductId);
  END FnuProductId;

/*Función que devuelve la versión del pkg*/
FUNCTION fsbVersion RETURN VARCHAR2 IS
BEGIN
     return CSBVERSION;
END FSBVERSION;
--BEGIN
  --null;
  --cnuGasService := Dald_parameter.fnuGetNumeric_Value('COD_TIPO_SERV');
END LDC_CRMPAZYSALVO;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CRMPAZYSALVO', 'ADM_PERSON');
END;
/
