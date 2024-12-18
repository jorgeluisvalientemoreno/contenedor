CREATE OR REPLACE package ADM_PERSON.LDCI_PKCONSULTABRILLA is
  /*****************************************************************
  propiedad intelectual de gdc (c).

  unidad         : ldci_pkcrmfinbrillaporaliado
  descripcion    : paquete para agrupar los servicios del portal brilla
  autor          : sebastian tapias
  fecha          : 01/02/2018
  req            : 200-1511

  fecha             autor                modificacion
  =========       =========             ====================
  ******************************************************************/
  PROCEDURE prcConsultaBarrio(inuSubscription IN suscripc.susccodi%type,
                              onuBarrio       OUT ab_address.neighborthood_id%type,
                              osbBarrio       OUT ge_geogra_location.description%type);

  FUNCTION getIdTypeByPrommisoryPu(inuPagare      in ld_promissory_pu.promissory_id%type,
                                   isbTypeUsuario in ld_promissory_pu.promissory_type%type)
            return constants_per.TYREFCURSOR;

  PROCEDURE diligenciamiento_venta(inususcripc      in number,
                                   inuidentityped   in number,
                                   isbidentinumberd in varchar2,
                                   inuidentitypec   in number,
                                   isbidentinumberc in varchar2,
                                   inucodprove      in number,
                                   ocuvalida        out constants_per.tyrefcursor,
                                   ocuinfosuscripc  out constants_per.tyrefcursor,
                                   ocuinfodeudor    out constants_per.tyrefcursor,
                                   ocuinfocodeudor  out constants_per.tyrefcursor,
                                   ocuinfofactura   out constants_per.tyrefcursor,
                                   ocucupoextra     out constants_per.tyrefcursor,
                                   onuerrorcode     out number,
                                   osberrormessage  out varchar2);

  PROCEDURE proconsultabrilla(ISBXML          IN CLOB,
                              OCUCONDICIONES  OUT SYS_REFCURSOR,
                              OCUINFOSUSCRIPC OUT SYS_REFCURSOR,
                              OCUINFODEUDOR   OUT SYS_REFCURSOR,
                              OCUINFOCODEUDOR OUT SYS_REFCURSOR,
                              OCUINFOFACTURA  OUT SYS_REFCURSOR,
                              OCUCUPOEXTRA    OUT SYS_REFCURSOR,
                              ----
                              OCUCAMPANAFNB OUT SYS_REFCURSOR,
                              ----
                              ONUERRORCODE    OUT NUMBER,
                              OSBERRORMESSAGE OUT VARCHAR2);

  PROCEDURE proconsultarespventas(ISBXML          IN CLOB,
                                  OCURESPUESTAS   OUT SYS_REFCURSOR,
                                  ONUERRORCODE    OUT NUMBER,
                                  OSBERRORMESSAGE OUT VARCHAR2);

  PROCEDURE prgetfactura(inususcripc in suscripc.susccodi%type,
                         ocufactura  out constants.tyrefcursor);

  PROCEDURE legaliza_venta(INUORDERID      IN NUMBER,
                           ISBFACTURA      IN VARCHAR2,
                           ISBCOMMENT      IN VARCHAR2,
                           ONUERRORCODE    OUT NUMBER,
                           OSBERRORMESSAGE OUT VARCHAR2);

  PROCEDURE legaliza_documentos(INUORDERID        IN NUMBER,
                                INUOPERATING      IN NUMBER,
                                INUCODESTLEY      IN LDC_PROTECCION_DATOS.COD_ESTADO_LEY%TYPE,
                                ISBACTUALIZADATOS IN VARCHAR2,
                                ONUERRORCODE      OUT NUMBER,
                                OSBERRORMESSAGE   OUT VARCHAR2);

  FUNCTION getIdTypeByPrommisory(inuTypeId         in ld_promissory.ident_type_id%type,
                                 inuIdentification in ld_promissory.identification%type,
                                 isbTypeUsuario    in ld_promissory_pu.promissory_type%type)
    return constants_per.TYREFCURSOR;

end LDCI_PKCONSULTABRILLA;
/


CREATE OR REPLACE package body ADM_PERSON.LDCI_PKCONSULTABRILLA is

    --Variables para gestión de traza
    csbNOMPKG      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;
    nuErrorCode    NUMBER;
    sbErrorMessage VARCHAR2(4000);

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : prcCierraCursor
  Descripcion    : Procedimiento para cerrar cursores (mandarlos con "DUMMY" en caso de que sean nulos)
  Autor          : Sebastian Tapias
  Fecha          : 02/04/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  =========       =========             ====================
  ******************************************************************/

  PROCEDURE prcCierraCursor(CUCURSOR IN OUT SYS_REFCURSOR) AS

  csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'prcCierraCursor';
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);

    IF NOT CUCURSOR%ISOPEN THEN
      OPEN CUCURSOR FOR
        SELECT * FROM dual where 1 = 2;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  END;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : prcConsultaBarrio
  Descripcion    : Procedimiento para consultar barrios.
  Autor          : Sebastian Tapias
  Fecha          : 02/04/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  =========       =========             ====================
  12/10/2023        Adrianavg           OSF-1687 Reemplazar daab_address.fnugetneighborthood_id por ADM_PERSON.PKG_BCDIRECCIONES.FNUGETBARRIO
                                        Reemplazar dage_geogra_location.fsbgetdescription por ADM.PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO
                                        Se añade manejo de traza PKG_TRAZA y de error controlado PKG_ERROR
  ******************************************************************/

  PROCEDURE prcConsultaBarrio(inuSubscription IN suscripc.susccodi%type,
                              onuBarrio       OUT ab_address.neighborthood_id%type,
                              osbBarrio       OUT ge_geogra_location.description%type) AS

    rcProduct    dapr_product.stypr_product;
    nuGasProduct pr_product.product_id%type := null;
    nuAddress_Id ab_address.address_id%type := null;

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'prcConsultaBarrio';

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);

    pkg_error.prinicializaerror(nuErrorCode,sbErrorMessage );

    pkg_traza.trace(csbMetodo||' inuSubscription '||inuSubscription , csbNivelTraza);

    nuGasProduct := ld_bononbankfinancing.fnugetGasProduct(inuSubscription);

    if nuGasProduct IS NOT NULL THEN

      dapr_product.getrecord(nuGasProduct, rcProduct);

      nuAddress_Id := rcProduct.address_id;

      pkg_traza.trace(csbMetodo||' nuAddress_Id '||nuAddress_Id , csbNivelTraza);

      onuBarrio := PKG_BCDIRECCIONES.FNUGETBARRIO(nuAddress_Id);

      osbBarrio := PKG_BCDIRECCIONES.FSBGETDESCRIPCIONUBICAGEO(onuBarrio);

    else
      onuBarrio := -1;
      osbBarrio := ' - ';
    end if;

      pkg_traza.trace(csbMetodo||' onuBarrio: '||onuBarrio||
                                 ', osbBarrio: '||osbBarrio, csbNivelTraza);
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    WHEN OTHERS THEN
         onuBarrio := -1;
         osbBarrio := ' - ';
         pkg_error.setError;
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' onuBarrio '||onuBarrio||' osbBarrio '||osbBarrio, csbNivelTraza);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
  END;

  /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Unidad         : getIdTypeByPrommisoryPu
    Descripcion    : Obtiene la informacion del pagare unico
    Autor          : S.PACHECO
    Fecha          : 23/09/2018

    Parametros                   Descripcion
    ============             ===================
    inuTypeId:               Tipo de idenfiticación
    inuIdentification:       Nro idenfiticación
    inuPagare                Pagare Unico
    isbTypeUsuario           Tipo de Usuario: Deudor/Codeudor

    Historia de Modificaciones
    Fecha            Autor                 Modificacion
    =========        =========             ====================
    23/09/2018       SPacheco               Creación
    31/01/2019       Daniel Valiente        Se agrego un valor por Defecto para identificar el Tipo de
                                            Usuario (Deudor/Codeudor). Se asigna un valor por Defecto
                                            para no alterar servicios dependientes.
    12/10/2023       Adrianavg              OSF-1687 Se crea cursor cnuPackage. Se reemplaza el tipo de dato del retorno constants.tyRefCursor
                                            por constants_per.TYREFCURSOR. Se añade manejo de traza PKG_TRAZA y de error controlado PKG_ERROR
    08/11/2023       Adrianavg              OSF-1687 Se ajusta declaración del cursor cnuPackage, se retira llamado a la excepcion no_data_found
  ******************************************************************/

  FUNCTION getIdTypeByPrommisoryPu(inuPagare      in ld_promissory_pu.promissory_id%type,
                                   isbTypeUsuario in ld_promissory_pu.promissory_type%type)

   return constants_per.TYREFCURSOR

   IS

    rfPrommisory constants_per.TYREFCURSOR;
    nuPackage    ldc_pagunidat.package_id%TYPE := null;
    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'getIdTypeByPrommisoryPu';

    CURSOR cnuPackage
    is
    SELECT l.package_id
      FROM ldc_pagunidat l
     WHERE l.pagare_id = inuPagare;

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);

    pkg_error.prinicializaerror(nuErrorCode,sbErrorMessage );

    pkg_traza.trace(csbMetodo||' inuPagare '||inuPagare||', isbTypeUsuario '||isbTypeUsuario, csbNivelTraza);

    BEGIN
        OPEN cnuPackage;
        FETCH cnuPackage INTO nuPackage;
        CLOSE cnuPackage;
    EXCEPTION
      WHEN OTHERS THEN
        nuPackage := null;
    END;

    IF nuPackage IS NOT NULL THEN
    pkg_traza.trace(csbMetodo||' nuPackage '||nuPackage, csbNivelTraza);
      OPEN rfPrommisory FOR
        select *
          from (SELECT l.promissory_id,
                       l.holder_bill,
                       l.debtorname,
                       l.identification,
                       l.forwardingplace,
                       l.forwardingdate,
                       l.gender,
                       l.civil_state_id,
                       l.birthdaydate,
                       l.school_degree_,
                       l.propertyphone_id,
                       l.dependentsnumber,
                       l.housingtype,
                       l.housingmonth,
                       l.holderrelation,
                       l.occupation,
                       l.companyname,
                       l.companyaddress_id,
                       l.phone1_id,
                       l.movilphone_id,
                       l.oldlabor,
                       l.activity,
                       l.monthlyincome,
                       l.expensesincome,
                       l.commerreference,
                       l.phonecommrefe,
                       l.movilphocommrefe,
                       l.addresscommrefe,
                       l.familiarreference,
                       l.phonefamirefe,
                       l.movilphofamirefe,
                       l.addressfamirefe,
                       l.personalreference,
                       l.phonepersrefe,
                       l.movilphopersrefe,
                       l.addresspersrefe,
                       l.email,
                       l.package_id,
                       l.promissory_type,
                       l.ident_type_id,
                       l.contract_type_id,
                       l.category_id,
                       l.subcategory_id,
                       l.phone2_id,
                       nvl(l.address_id, 0) address_id,
                       l.last_name
                  FROM LD_PROMISSORY_PU L, MO_PACKAGES M
                 WHERE L.PACKAGE_ID = M.PACKAGE_ID
                   AND M.PACKAGE_ID = nuPackage
                   AND L.PROMISSORY_TYPE = isbTypeUsuario
                 ORDER BY M.REQUEST_DATE DESC)
         where rownum = 1;

    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN(rfPrommisory);
    CLOSE rfPrommisory;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
         pkg_error.setError;
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERC);
         RETURN NULL;--Retorna null si no encuentra registros con los parametros de busqueda
    WHEN OTHERS THEN
         pkg_error.setError;
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
         RETURN NULL; --Retorna null si no encuentra registros con los parametros de busqueda
  END getIdTypeByPrommisoryPu;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : prReleaseSubscription
  Descripcion    : Procedimiento para liberar el bloqueo
  Autor          : Sebastian Tapias
  Fecha          : 03/07/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  =========       =========             ====================
 12/10/2023        Adrianavg             OSF-1687 Se reemplaza ut_trace.trace por pkg_traza.trace, se reemplaza ex.CONTROLLED_ERROR
                                         por PKG_ERROR.CONTROLLED_ERROR. Se reemplaza Errors.setError por pkg_error.setError
                                         Se añade manejo de variables de error
  ******************************************************************/

  FUNCTION prReleaseSubscription(inuSubscriptionID IN suscripc.susccodi%type)

   return boolean IS

    nuRequestResult INTEGER := 0;

    nuDEF_SUBSCRIPTION suscripc.susccodi%type := ge_boparameter.fnuGet('DEF_SUBSCRIPTION');

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'prReleaseSubscription';

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);

    pkg_error.prinicializaerror(nuErrorCode, sbErrorMessage );

    pkg_traza.trace(csbMetodo||' inuSubscriptionID '||inuSubscriptionID
                             ||' nuDEF_SUBSCRIPTION '||nuDEF_SUBSCRIPTION, csbNivelTraza);

    IF (inuSubscriptionID IS NOT NULL) AND

       (inuSubscriptionID <> nuDEF_SUBSCRIPTION) THEN

      DECLARE

        sbLockHandle VARCHAR2(2000);
        sbLockName VARCHAR2(100) := 'FIFAP_' || inuSubscriptionID;

      BEGIN

        pkg_traza.trace(csbMetodo||' LockName '||sbLockName, csbNivelTraza);

        EXECUTE IMMEDIATE 'DECLARE PRAGMA AUTONOMOUS_TRANSACTION; BEGIN dbms_lock.allocate_unique(:sbLockName,:sbLockHandle); END;'
        USING sbLockName, out sbLockHandle;

        pkg_traza.trace(csbMetodo||' LockHandle '||sbLockHandle, csbNivelTraza);

        nuRequestResult := dbms_lock.release(lockhandle => sbLockHandle);

      EXCEPTION
        WHEN OTHERS THEN
         nuErrorCode:= pkg_error.CNUGENERIC_MESSAGE;
         pkg_error.setErrorMessage(nuErrorCode, 'WARNING: No Desbloqueo de Contrato[' || inuSubscriptionID ||']');
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
      END;

      pkg_traza.trace(csbMetodo||' LockRequestResult '||nuRequestResult, csbNivelTraza);

      -- Verifica si el contrato ya se encuentra bloqueado.
      IF (nuRequestResult IN (3, 4, 5)) THEN
         pkg_traza.trace(csbMetodo||' NOK', csbNivelTraza, pkg_traza.csbFIN);
         RETURN FALSE;
      END IF;

    END IF;

   pkg_traza.trace(csbMetodo||' OK', csbNivelTraza, pkg_traza.csbFIN);
   RETURN TRUE;

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         pkg_error.setError;
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERC);
         RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS THEN
         pkg_error.setError;
         pkg_error.geterror(nuErrorCode,sbErrorMessage);
         pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
         RAISE PKG_ERROR.CONTROLLED_ERROR;
  END prReleaseSubscription;

  PROCEDURE prLegalizaOtFnbWeb(inuIdOrder        IN or_order.order_id%TYPE,
                               inuCodEstLey      IN LDC_PROTECCION_DATOS.COD_ESTADO_LEY%TYPE,
                               isbActualizaDatos IN VARCHAR2,
                               ONUERRORCODE      OUT NUMBER,
                               OSBERRORMESSAGE   OUT VARCHAR2) is
    /*****************************************************************
      Propiedad intelectual de JM (c).

      Unidad         : prLegalizaOtFnbWeb
      Descripcion    : Procedimiento legalizar OTs Revisi?n de Documentos de FNB y asigna el estado de protecci?n datos personales
      Autor          : Sebastian Tapias
      Fecha          : 23-MAYO-2018
      Observacion    : Se Copia del servicio LDC_PRLEGALIZAOTFNB

      Parametros              Descripcion
      ============         ===================

      Fecha             Autor                 Modificacion
      =========       =========              ====================
      23/05/2018      STapias                REQ.2001511 Creacion.
      17/10/2023      Adrianavg              OSF-1687 Se reemplaza UT_TRACE por PKG_TRAZA.
                                             Se reemplaza UT_SESSION.GETUSER por ADM_PERSON.PKG_SESSION.GETUSER.
                                             Se retira el when exception ex.CONTROLLED_ERROR donde se inserta en LDC_PROTECCION_DATOS, ya que al
                                             interior no se hace uso de esta exception y cualquier error se iría por el When Others
                                             Se reemplaza raise EX.CONTROLLED_ERROR por raise PKG_ERROR.CONTROLLED_ERROR
                                             Se crea cursor cuSubscriberId, cuCantidadIDCodeudor, cuTypSubscriberId, cuTypeId y cuIdentSubscriberId.
                                             Se reemplaza Ld_Boconstans.cnuGeneric_Error por pkg_error.CNUGENERIC_MESSAGE.
                                             Se retira IF-ENDIF open.fblAplicaEntrega(csbEntrega2001015)
                                             Se reemplaza ut_date.fdtsysdate por LDC_BOCONSGENERALES.FDTGETSYSDATE.
                                             Se reemplaza os_registerrequestwithxml por ADM_PERSON.API_REGISTERREQUESTBYXML.
                                             Se reemplaza ERRORS.SETERROR por PKG_ERROR.SETERROR.
                                             Se reemplaza el tipo de las variables isbrequestxml y isbrequestxmlCODEUDOR, de Varchar2(3000) por
                                             constants_per.TIPO_XML_SOL.
                                             Se retiran variables, exceptions y cursores que no se estan usando como:isbrequestxmlCODEUDOR,
                                             cnuNULL_ATTRIBUTE, EX_ERROR, nupersonid, nutask_type_id, sbSeparador, isbTagName, sbTagNameMot, nuIdContrato, sbActividadId
                                             sbOldLastName, inuProd, nuOrdenSolicitud, seqMo_Dt_Chg, onuErrorCodeApiAsig, osbErrorMessageApiAsig, nuOrActivityID, isbObservacionLeg,
                                             sbDatos, onuerrorcodeLeg, osberrormessageLeg, rcmo_dt_chg_E_MAIL, rcmo_dt_chg_IDENT_TYPE_ID, rcmo_dt_chg_IDENTIFICATION,
                                             rcmo_dt_chg_SUBSCRIBER_NAME, rcmo_dt_chg_SUBS_LAST_NAME, vOrder, vActiOrder, vOrderStatus, vCausal, vCadena, rccurGetSolicitud.
                                             cursor curGetSolicitud, curGetOrActivityID
                                             Se colocan palabras claves en mayúsculas. A isbrequestxml se le asigna pkg_xml_soli_fnb.getSolicitudCorreccionDatos
                                             para que retorne el XML para la solicitud 100296: P_CORRECCION_DE_DATOS_POR_XML_100296
                                             Se retira nombre de esquema OPEN.
    ******************************************************************/
    ------------------------
    --Variables -->
    ------------------------
    bocambioNameCODEUDOR  boolean := false;
    bocambioIdCODEUDOR    boolean := false;

    nuCant         number;
    nuSubscriberId or_order_activity.subscriber_id%type;
    sbCurrentUser  sa_user.mask%type;
    nuGroupId      NUMBER;
    rcGrouper      daldc_orden_lodpd.styLDC_ORDEN_LODPD;
    nuConsecutive  number := 0;

    NURECEPTYPE_ID NUMBER;
    isbrequestxml  constants_per.tipo_xml_sol%type;
    bocambioName   boolean := false;
    bocambioId     boolean := false;

    onupackageidT    number;
    onumotiveidT     number;
    onuerrorcodeT    number;
    osberrormessageT varchar2(3000);
    nuTypeId         number;

    temp       number(10);
    nuContador NUMBER;

    nucausal   number;
    sbCambioNombre constant varchar2(100) := 'nombre';
    sbCambioId     constant varchar2(100) := 'identificacion';
    inuPackageId   constant number := 100216;
    nuIteraccion          number;
    nuPackageOrdenInicial number;
    nuConteo              number;
    inuPackageId          number;
    sbComentarioSolcitud  varchar2(300);

    nuNewIdentificacion number;
    nuOldIdentificacion number;
    sbNewName           varchar2(100);
    sbNewLastName       varchar2(100);
    sbOldName           varchar2(100);

    SBCOMMENT          varchar2(600);

    rcMOPackages    damo_packages.styMO_packages;
    rcProductMotive DAPS_Product_Motive.styPS_Product_Motive;
    rcMOMotive      damo_motive.styMO_MOTIVE;
    rcProduct       dapr_product.styPR_product;

    nucontratocodeudor   number;
    nucantidadIDCodeudor number;

    CURSOR cu_Lodpd(nuOrder or_order.order_id%type) is
      select o.consecutive
        from ldc_orden_lodpd o
       where o.order_id = nuOrder;

    -- cursor que obtiene las operaciones a realizar
    CURSOR curSolicitud(inuPackageid number) is
      select *
        from ldc_Datos_actualizar d
       where d.package_id = inuPackageid
         and d.tipo_cambio <> 'Nombre y/o ID';

    CURSOR curSolicitudCODEUDOR(inuPackageid number) is
      select *
        from ldc_Datos_actualizar d
       where d.package_id = inuPackageid
         and d.tipo_cambio = 'Nombre y/o ID';
    RFcurSolicitudCODEUDOR curSolicitudCODEUDOR%ROWTYPE;

    -- obtiene producto
    CURSOR curProducto(nuContrato servsusc.sesunuse%type) is --no se esta usando
      select SESUNUSE
        from servsusc se, suscripc s
       where se.sesunuse = nuContrato -- contrato
         and se.sesuserv = 7014 -- gas
         and s.susccodi = se.SESUSUSC;

    -- obtiene la solicitud y la iteracion
    CURSOR curGetSolicitudyIteracion(inuIdOrder number) IS
      SELECT oa.PACKAGE_ID, mo.cust_care_reques_num
        FROM or_order_activity oa, mo_packages mo
       WHERE oa.order_id = inuIdOrder
         AND oa.package_id = mo.package_id;

    -- valida si realiza una opcion
    CURSOR curValidaRegistro(nuPackage number) IS
      SELECT COUNT(1)
        FROM (SELECT *
                FROM ldc_Datos_actualizar d
               WHERE d.package_id = nuPackageOrdenInicial);

    CURSOR curGetDataSubsc(idCliente number) is
      select g.identification  identificacion,
             g.subscriber_name nombres,
             g.subs_last_name  apellidos
        from ge_subscriber g
       where g.subscriber_id = idCliente;
    rccurGetDataSubsc curGetDataSubsc%rowtype;

    --Cusor para validar si la orden esta relacionada a una solicitud de pagare unico.
    CURSOR cuExistePagareUnico is
      select ooa.*
        from Or_Order_Activity ooa
       where ooa.package_id in
             (select ldc_pud.package_id
                from ldc_pagunidat ldc_pud
               where ldc_pud.pagare_id in
                     (select lpud.pagare_id
                        from ldc_pagunidet lpud
                       where lpud.package_id_sale in
                             (select ooa.package_id
                                from Or_Order_Activity ooa
                               where ooa.order_id = inuIdOrder
                                 and rownum = 1)
                         and rownum = 1)
                 and rownum = 1);
    rfcuExistePagareUnico cuExistePagareUnico%rowtype;

    CURSOR cuExisteOTDOCREVLeg(InuPackagePU number) is
      select oo.*, rowid
        from or_order oo
       where oo.order_id in
             (select ooa.order_id
                from Or_Order_Activity ooa
               where ooa.package_id = InuPackagePU
                 and ooa.activity_id =
                     to_number(dald_parameter.fsbGetValue_Chain('COD_ACT_REVDOC_PAGAREUNI')));
    rfcuExisteOTDOCREVLeg cuExisteOTDOCREVLeg%rowtype;

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'prLegalizaOtFnbWeb';

    --obtiene el id del subcriptor
    CURSOR cuSubscriberId
    is
    SELECT subscriber_id
      FROM Or_Order_Activity
     WHERE order_id = inuIdOrder
       AND ROWNUM = 1;

    CURSOR cuTypeId(p_nuSubscriber_Id Ge_Subscriber.Subscriber_Id%type)
    is
    SELECT gs.Ident_Type_Id
      FROM Ge_Subscriber gs
     WHERE gs.Subscriber_Id = p_nuSubscriber_Id;

    CURSOR cuCantidadIDCodeudor(p_nuIdentificacion Ge_Subscriber.identification%type)
    is
    SELECT count(gs.Subscriber_Id) --cantidad
    FROM Ge_Subscriber gs
    WHERE GS.identification = TO_CHAR(p_nuIdentificacion);

    CURSOR cuTypSubscriberId(p_nuIdentificacion Ge_Subscriber.identification%type)
    is
    SELECT gs.Ident_Type_Id, gs.Subscriber_Id
      FROM Ge_Subscriber gs
     WHERE GS.identification = TO_CHAR(p_nuIdentificacion);

   CURSOR cuIdentSubscriberId(p_nucontratocodeudor suscripc.susccodi%type)
   is
   SELECT gs.Ident_Type_Id, gs.Subscriber_Id
     FROM Ge_Subscriber gs, suscripc s
    WHERE s.susccodi = p_nucontratocodeudor
      AND GS.SUBSCRIBER_ID = s.suscclie
      AND rownum = 1;

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);

    pkg_error.prinicializaerror(onuerrorcode,osberrormessage );

    pkg_traza.trace(csbMetodo||' inuIdOrder '||inuIdOrder
                             ||', Codigo Estado Ley inuCodEstLey '||inuCodEstLey
                             ||', isbActualizaDatos '||isbActualizaDatos, csbNivelTraza);

    nuGroupId := LDC_BOPROCESRUTEROS.FNUOBTIENESECUENCIA('SEQ_LDC_ORDEN_LODPD');

    pkg_traza.trace(csbMetodo||' Codigo Agrupador - nuGroupId '||nuGroupId, csbNivelTraza);

    -- Obtiene el usuario actual
    sbCurrentUser := Pkg_Session.Getuser;

    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------

      OPEN cuExistePagareUnico;
     FETCH cuExistePagareUnico
      INTO rfcuExistePagareUnico;
    IF cuExistePagareUnico%found THEN
       OPEN cuExisteOTDOCREVLeg(rfcuExistePagareUnico.Package_Id);
      FETCH cuExisteOTDOCREVLeg
       INTO rfcuExisteOTDOCREVLeg;
      IF cuExisteOTDOCREVLeg%found THEN
        IF (rfcuExisteOTDOCREVLeg.Order_Status_Id <>
           dald_parameter.fnuGetNumeric_Value('ESTADO_CERRADO')) then
          ONUERRORCODE    := -1;
          OSBERRORMESSAGE := UPPER('La orden de Rev. Doc. del Pagare Unico aun no ha sido legalizada');
          RAISE PKG_ERROR.CONTROLLED_ERROR;
        END IF;
      ELSE
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('No existe Doc. Rev. para la Solicitud Pagare Unico[' ||
                                 rfcuExistePagareUnico.Package_Id || ']');
        RAISE PKG_ERROR.CONTROLLED_ERROR;
      END IF;
      CLOSE cuExisteOTDOCREVLeg;
    END IF;
    CLOSE cuExistePagareUnico;

    IF (nuGroupId IS NULL) THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [NUGROUPID] NO PUDO SER OBTENIDO.');
      RAISE PKG_ERROR.CONTROLLED_ERROR;
    END IF;

     OPEN cuSubscriberId;
    FETCH cuSubscriberId INTO nuSubscriberId;
    CLOSE cuSubscriberId;

    pkg_traza.trace(csbMetodo||' Suscriptor de Activity: nuSubscriberId => '||nuSubscriberId, csbNivelTraza);

    IF (inuCodEstLey IS NULL) THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INUCODESTLEY] NO PUEDE SER NULO.');
      RAISE PKG_ERROR.CONTROLLED_ERROR;
    ELSE

      BEGIN
        --S?lo debe quedar activo el registro insertado.
        UPDATE LDC_PROTECCION_DATOS
           SET ESTADO = 'N'
         WHERE ID_CLIENTE = nuSubscriberId;

        --Insertar en ldc_proteccion_datos
        INSERT INTO LDC_PROTECCION_DATOS
          (ID_CLIENTE,
           COD_ESTADO_LEY,
           ESTADO,
           FECHA_CREACION,
           USUARIO_CREACION,
           PACKAGE_ID)
        VALUES
          (nuSubscriberId, inuCodEstLey, 'S', SYSDATE, sbCurrentUser, 3);

        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          ROLLBACK;
          onuErrorCode    := pkg_error.CNUGENERIC_MESSAGE;
          osbErrorMessage := sqlerrm;
          RAISE PKG_ERROR.CONTROLLED_ERROR;
      END;

      COMMIT;
    END IF;

    --legaliza las ordenes de revisi?n de documentos.
    LD_BONONBANKFINANCING.LEGALIZEREVIWORDER(inuIdOrder);

     OPEN cu_Lodpd(inuIdOrder);
    FETCH cu_Lodpd
     INTO nuConsecutive;
    CLOSE cu_Lodpd;

    pkg_traza.trace(csbMetodo||' nuConsecutive => '||nuConsecutive, csbNivelTraza);

    IF (nvl(nuConsecutive, 0) = 0) then
      rcGrouper.consecutive   := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL('SEQ_LDC_ORDEN_LOD_ID');
      rcGrouper.order_id      := inuIdOrder;
      rcGrouper.register_date := LDC_BOCONSGENERALES.FDTGETSYSDATE;
      rcGrouper.grouper_id    := nuGroupId;
      daldc_orden_lodpd.insRecord(rcGrouper);

    ELSE
      daldc_orden_lodpd.updGROUPER_ID(nuConsecutive, nuGroupId);
    END IF;

    -- VALIDA QUE EL CAMPO ACTUALIZA DATOS ESTE EN ACTUALIZAR
    --la logica varia para cuando sea 1 actulice los datos del DEUDOR y CODEUDOR
    IF (isbActualizaDatos = '1') THEN

      pkg_traza.trace(csbMetodo||' INICIO CREAR Y ATENDER SOLICITUDES', csbNivelTraza, pkg_traza.csbINICIO);

      -- sacamos la solicitud y la iteracion de la orden inicial
       OPEN curGetSolicitudyIteracion(inuIdOrder);
      FETCH curGetSolicitudyIteracion
       INTO nuPackageOrdenInicial, nuIteraccion;
      CLOSE curGetSolicitudyIteracion;

      pkg_traza.trace(csbMetodo||' nuPackageOrdenInicial: '||nuPackageOrdenInicial
                               ||' nuIteraccion: '||nuIteraccion, csbNivelTraza);

       OPEN curValidaRegistro(nuPackageOrdenInicial);
      FETCH curValidaRegistro
       INTO nuConteo;
      CLOSE curValidaRegistro;

      pkg_traza.trace(csbMetodo||' nuConteo: '||nuConteo , csbNivelTraza);

      -- validar que la solicitud tenga un registro en ldc_Datos_actualizar
      IF (nuConteo > 0) THEN

        pkg_traza.trace(csbMetodo||' validar que la solicitud del Cliente tenga un registro en ldc_Datos_actualizar', csbNivelTraza);

        FOR recCurSolicitud in curSolicitud(nuPackageOrdenInicial) LOOP
          -- variables comunes para los dos procesos
          nuSubscriberId       := TO_NUMBER(recCurSolicitud.idcliente);
          sbComentarioSolcitud := 'Cambio de Datos del Cliente por XML';

          -- Validar que tipo de cambio se debe realziar
          IF (recCurSolicitud.TIPO_CAMBIO = sbCambioId) THEN
            -- datos que cambian
            nuNewIdentificacion := to_number(recCurSolicitud.new_ident);
            nuOldIdentificacion := to_number(recCurSolicitud.old_ident);
            bocambioId          := true;
          END IF;

          IF (recCurSolicitud.TIPO_CAMBIO = sbCambioNombre) THEN
            -- datos que cambian
            sbNewName     := recCurSolicitud.new_name;
            sbNewLastName := recCurSolicitud.new_lastname;
            bocambioName  := true;
          END IF;

        END LOOP; -- fin loop cursor

        IF NOT bocambioName THEN
          OPEN curGetDataSubsc(nuSubscriberId);
         FETCH curGetDataSubsc
          INTO rccurGetDataSubsc;
          CLOSE curGetDataSubsc;
          -- Se conservan estos datos igual que ge_subscriber
          sbNewName     := rccurGetDataSubsc.nombres;
          sbNewLastName := rccurGetDataSubsc.apellidos;
        END IF;

        IF NOT bocambioId THEN
          OPEN curGetDataSubsc(nuSubscriberId);
         FETCH curGetDataSubsc
          INTO rccurGetDataSubsc;
          CLOSE curGetDataSubsc;
          -- Se conservan estos datos igual que ge_subscriber
          nuNewIdentificacion := TO_NUMBER(rccurGetDataSubsc.identificacion);
        END IF;

        sbComentarioSolcitud := 'Cambio Datos del Deudor Por Venta FNB No ' ||  nuPackageOrdenInicial;

        NURECEPTYPE_ID := dald_parameter.fnuGetNumeric_Value('COD_TIPO_MEDIO_RECEP');

         OPEN cuTypeId(nuSubscriberId);
        FETCH cuTypeId INTO nuTypeId;
        CLOSE cuTypeId;

        -- darevalo[22/10/2015] cambio[8871]: se a?ade encoding , permite caracteres especiales
        -- XML del tramite
        isbrequestxml := pkg_xml_soli_fnb.getSolicitudCorreccionDatos(nuRecepType_id ,
                                                                      sbComentarioSolcitud,
                                                                      nuSubscriberId,
                                                                      nuTypeId,
                                                                      nuNewIdentificacion,
                                                                      sbNewName,
                                                                      sbNewLastName); 

        pkg_traza.trace(csbMetodo||' TRAMITE DEUDOR XML [' || isbrequestxml || ']', csbNivelTraza);

        -- Se llama al api
        API_REGISTERREQUESTBYXML(isbrequestxml   => isbrequestxml,
                                  onupackageid    => onupackageidT,
                                  onumotiveid     => onumotiveidT,
                                  onuerrorcode    => onuerrorcodeT,
                                  osberrormessage => osberrormessageT);

        -- SE VALIDA SI SE PRESENTO ALGUN ERROR
        IF (onuerrorcodeT = 0) THEN
          pkg_traza.trace(csbMetodo||' FIN TRAMITE DEUDOR XML ---> OK', csbNivelTraza);
        ELSE
          pkg_traza.trace(csbMetodo||' FIN TRAMITE DEUDOR XML ---> ERROR', csbNivelTraza);
          pkg_traza.trace(csbMetodo||' Cliente a crear: ' || nuNewIdentificacion, csbNivelTraza);
          ONUERRORCODE    := -1;
          OSBERRORMESSAGE := UPPER('En la solicitud [' || nuPackageOrdenInicial || ']  :  ' || osberrormessageT);
          RAISE PKG_ERROR.CONTROLLED_ERROR;
        END IF;

        DBMS_LOCK.SLEEP(30);

        --Inicio
        bocambioIdCODEUDOR := FALSE;
        FOR recCurSolicitud in curSolicitudCODEUDOR(nuPackageOrdenInicial) LOOP
          -- variables comunes para los dos procesos
          nuSubscriberId       := TO_NUMBER(recCurSolicitud.idcliente);
          sbComentarioSolcitud := 'Cambio Datos del Codeudor Por Venta FNB No ' || nuPackageOrdenInicial;

          nuNewIdentificacion := TO_NUMBER(recCurSolicitud.new_ident);
          nuOldIdentificacion := TO_NUMBER(recCurSolicitud.old_ident);
          bocambioIdCODEUDOR  := TRUE;

          sbNewName            := recCurSolicitud.new_name;
          sbNewLastName        := recCurSolicitud.new_lastname;
          bocambioNameCODEUDOR := TRUE;

          nucontratocodeudor := nvl(recCurSolicitud.Idcontrato, 0);

        END LOOP; -- fin loop cursor

        IF bocambioIdCODEUDOR THEN

          IF nuSubscriberId IS NOT NULL THEN

            nuTypeId := NULL;

            NURECEPTYPE_ID := dald_parameter.fnuGetNumeric_Value('COD_TIPO_MEDIO_RECEP');

            IF nucontratocodeudor = 0 THEN
               OPEN cuCantidadIDCodeudor(nuOldIdentificacion);
               FETCH cuCantidadIDCodeudor INTO nucantidadIDCodeudor;
               CLOSE cuCantidadIDCodeudor;
              IF nucantidadIDCodeudor = 1 THEN
                 OPEN cuTypSubscriberId(nuOldIdentificacion);
                FETCH cuTypSubscriberId INTO nuTypeId, nuSubscriberId;
                CLOSE cuTypSubscriberId;
              ELSE
                ONUERRORCODE    := -1;
                OSBERRORMESSAGE := UPPER('La identificacion [' || nuOldIdentificacion || '] se encuentra registrada en el sistema mas de una vez.');
                RAISE PKG_ERROR.CONTROLLED_ERROR;
              END IF;
            ELSE
                 OPEN cuIdentSubscriberId(nucontratocodeudor);
                FETCH cuIdentSubscriberId INTO nuTypeId, nuSubscriberId;
                CLOSE cuIdentSubscriberId;
            END IF;

            IF nuTypeId is not null THEN

              -- XML del tramite
              isbrequestxml := pkg_xml_soli_fnb.getSolicitudCorreccionDatos(nuRecepType_id ,
                                                                      sbComentarioSolcitud,
                                                                      nuSubscriberId,
                                                                      nuTypeId,
                                                                      nuNewIdentificacion,
                                                                      sbNewName,
                                                                      sbNewLastName);                                

              pkg_traza.trace(csbMetodo||' TRAMITE CODEUDOR XML [' || isbrequestxml || ']', csbNivelTraza);

              -- Se llama al api
              API_REGISTERREQUESTBYXML(isbrequestxml   => isbrequestxml,
                                        onupackageid    => onupackageidT,
                                        onumotiveid     => onumotiveidT,
                                        onuerrorcode    => onuerrorcodeT,
                                        osberrormessage => osberrormessageT);

              -- SE VALIDA SI SE PRESENTO ALGUN ERROR
              IF (onuerrorcodeT = 0) THEN
                pkg_traza.trace(csbMetodo||' FIN TRAMITE CODEUDOR XML ---> OK', csbNivelTraza);
              ELSE
                pkg_traza.trace(csbMetodo||' FIN TRAMITE CODEUDOR XML ---> ERROR', csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Cliente a crear: ' || nuNewIdentificacion, csbNivelTraza);
                ONUERRORCODE    := -1;
                OSBERRORMESSAGE := UPPER('En la solicitud [' || nuPackageOrdenInicial || ']  :  ' || osberrormessageT);
                RAISE PKG_ERROR.CONTROLLED_ERROR;
              END IF;
            END IF; --fin validacion nuTypeId
          END IF; --fin validacion nuSubscriberId is not null
        END IF; --fin validcion bocambioIdCODEUDOR

        COMMIT;

      END IF; -- fin  IF(nuConteo > 0)
    ELSE
      --la logica para actualizar solo DEUDOR
      IF (isbActualizaDatos = '3') THEN

        pkg_traza.trace(csbMetodo||' INICIO CREAR Y ATENDER SOLICITUD PARA DEUDOR', csbNivelTraza);
        -- sacamos la solicitud y la iteracion de la orden inicial
         OPEN curGetSolicitudyIteracion(inuIdOrder);
        FETCH curGetSolicitudyIteracion
         INTO nuPackageOrdenInicial, nuIteraccion;
        CLOSE curGetSolicitudyIteracion;

        pkg_traza.trace(csbMetodo||' nuPackageOrdenInicial: '||nuPackageOrdenInicial
                                 ||' nuIteraccion: '||nuIteraccion, csbNivelTraza);

         OPEN curValidaRegistro(nuPackageOrdenInicial);
        FETCH curValidaRegistro
         INTO nuConteo;
        CLOSE curValidaRegistro;

        pkg_traza.trace(csbMetodo||' nuConteo: '||nuConteo, csbNivelTraza);

        -- validar que la solicitud tenga un registro en ldc_Datos_actualizar
        IF (nuConteo > 0) THEN

          FOR recCurSolicitud in curSolicitud(nuPackageOrdenInicial) LOOP
            -- variables comunes para los dos procesos
            nuSubscriberId       := TO_NUMBER(recCurSolicitud.idcliente);
            sbComentarioSolcitud := 'Cambio de Datos del Cliente por XML';

            -- Validar que tipo de cambio se debe realziar
            IF (recCurSolicitud.TIPO_CAMBIO = sbCambioId) THEN
              -- datos que cambian
              nuNewIdentificacion := TO_NUMBER(recCurSolicitud.new_ident);
              nuOldIdentificacion := TO_NUMBER(recCurSolicitud.old_ident);
              bocambioId          := TRUE;
            END IF;

            IF (recCurSolicitud.TIPO_CAMBIO = sbCambioNombre) THEN
              -- datos que cambian
              sbNewName     := recCurSolicitud.new_name;
              sbNewLastName := recCurSolicitud.new_lastname;
              bocambioName  := TRUE;
            END IF;

          END LOOP; -- fin loop cursor

          IF NOT bocambioName THEN
            OPEN curGetDataSubsc(nuSubscriberId);
           FETCH curGetDataSubsc
            INTO rccurGetDataSubsc;
           CLOSE curGetDataSubsc;
            -- Se conservan estos datos igual que ge_subscriber
            sbNewName     := rccurGetDataSubsc.nombres;
            sbNewLastName := rccurGetDataSubsc.apellidos;
          END IF;

          IF NOT bocambioId THEN
            OPEN curGetDataSubsc(nuSubscriberId);
           FETCH curGetDataSubsc
            INTO rccurGetDataSubsc;
           CLOSE curGetDataSubsc;
            -- Se conservan estos datos igual que ge_subscriber
            nuNewIdentificacion := to_number(rccurGetDataSubsc.identificacion);
          END IF;

          sbComentarioSolcitud := 'Cambio Datos del Deudor Por Venta FNB No ' ||
                                  nuPackageOrdenInicial;

          NURECEPTYPE_ID := dald_parameter.fnuGetNumeric_Value('COD_TIPO_MEDIO_RECEP');
             OPEN cuTypeId(nuSubscriberId);
            FETCH cuTypeId INTO nuTypeId;
            CLOSE cuTypeId;

          -- XML del tramite
            isbrequestxml := pkg_xml_soli_fnb.getSolicitudCorreccionDatos(nuRecepType_id ,
                                                                  sbComentarioSolcitud,
                                                                  nuSubscriberId,
                                                                  nuTypeId,
                                                                  nuNewIdentificacion,
                                                                  sbNewName,
                                                                  sbNewLastName);                            

          pkg_traza.trace(csbMetodo||' TRAMITE XML [' || isbrequestxml || ']', csbNivelTraza);

          -- Se llama al api
          API_REGISTERREQUESTBYXML(isbrequestxml   => isbrequestxml,
                                    onupackageid    => onupackageidT,
                                    onumotiveid     => onumotiveidT,
                                    onuerrorcode    => onuerrorcodeT,
                                    osberrormessage => osberrormessageT);

          -- SE VALIDA SI SE PRESENTO ALGUN ERROR
          IF (onuerrorcodeT = 0) THEN
            pkg_traza.trace(csbMetodo||' FIN TRAMITE XML ---> OK', csbNivelTraza);
            COMMIT;
          ELSE
            pkg_traza.trace(csbMetodo||' FIN TRAMITE XML ---> ERROR', csbNivelTraza);
            pkg_traza.trace(csbMetodo||' Cliente a crear: ' || nuNewIdentificacion, csbNivelTraza);

            ONUERRORCODE    := -1;
            OSBERRORMESSAGE := UPPER('En la solicitud [' || nuPackageOrdenInicial || ']  :  ' || osberrormessageT);
            RAISE PKG_ERROR.CONTROLLED_ERROR;
          END IF;

        END IF; -- fin  IF(nuConteo > 0)
      ELSE
        --la logica varia para cuando sea 1 actulice los datos del DEUDOR y CODEUDOR
        IF (isbActualizaDatos = '4') THEN

          pkg_traza.trace(csbMetodo||' INICIO CREAR Y ATENDER SOLICITUD PARA CODEUDOR', csbNivelTraza);

          -- sacamos la solicitud y la iteracion de la orden inicial
          OPEN curGetSolicitudyIteracion(inuIdOrder);
         FETCH curGetSolicitudyIteracion
          INTO nuPackageOrdenInicial, nuIteraccion;
         CLOSE curGetSolicitudyIteracion;

        pkg_traza.trace(csbMetodo||' nuPackageOrdenInicial: '||nuPackageOrdenInicial
                                 ||' nuIteraccion: '||nuIteraccion, csbNivelTraza);

          OPEN curValidaRegistro(nuPackageOrdenInicial);
         FETCH curValidaRegistro
          INTO nuConteo;
         CLOSE curValidaRegistro;

         pkg_traza.trace(csbMetodo||' nuConteo: '||nuConteo, csbNivelTraza);

          -- validar que la solicitud tenga un registro en ldc_Datos_actualizar
          IF (nuConteo > 0) THEN

            pkg_traza.trace(csbMetodo||' validar que la solicitud del Codeudor tenga un registro en ldc_Datos_actualizar', csbNivelTraza);
            --Inicio
            FOR recCurSolicitud in curSolicitudCODEUDOR(nuPackageOrdenInicial) LOOP
              -- variables comunes para los dos procesos
              nuSubscriberId       := TO_NUMBER(recCurSolicitud.idcliente);
              sbComentarioSolcitud := 'Cambio Datos del Codeudor Por Venta FNB No ' || nuPackageOrdenInicial;

              nuNewIdentificacion := TO_NUMBER(recCurSolicitud.new_ident);
              nuOldIdentificacion := TO_NUMBER(recCurSolicitud.old_ident);
              bocambioIdCODEUDOR  := TRUE;

              sbNewName            := recCurSolicitud.new_name;
              sbNewLastName        := recCurSolicitud.new_lastname;
              bocambioNameCODEUDOR := TRUE;

              nucontratocodeudor := nvl(recCurSolicitud.Idcontrato, 0);

            END LOOP; -- fin loop cursor

            IF bocambioIdCODEUDOR THEN

              NURECEPTYPE_ID := dald_parameter.fnuGetNumeric_Value('COD_TIPO_MEDIO_RECEP');

              IF nucontratocodeudor = 0 THEN
                 OPEN cuCantidadIDCodeudor(nuOldIdentificacion);
                FETCH cuCantidadIDCodeudor INTO nucantidadIDCodeudor;
                CLOSE cuCantidadIDCodeudor;
                IF nucantidadIDCodeudor = 1 THEN
                   OPEN cuTypSubscriberId(nuOldIdentificacion);
                  FETCH cuTypSubscriberId INTO nuTypeId, nuSubscriberId;
                  CLOSE cuTypSubscriberId;
                ELSE
                  ONUERRORCODE    := -1;
                  OSBERRORMESSAGE := UPPER('La identificacion [' || nuOldIdentificacion || '] se encuentra registrada en el sistema mas de una vez.');
                  RAISE PKG_ERROR.CONTROLLED_ERROR;
                END IF;
              ELSE
                 OPEN cuIdentSubscriberId(nucontratocodeudor);
                FETCH cuIdentSubscriberId INTO nuTypeId, nuSubscriberId;
                CLOSE cuIdentSubscriberId;
              END IF;

              -- XML del tramite
              isbrequestxml := pkg_xml_soli_fnb.getSolicitudCorreccionDatos(nuRecepType_id ,
                                                                  sbComentarioSolcitud,
                                                                  nuSubscriberId,
                                                                  nuTypeId,
                                                                  nuNewIdentificacion,
                                                                  sbNewName,
                                                                  sbNewLastName);              

              pkg_traza.trace(csbMetodo||' TRAMITE XML [' || isbrequestxml || ']', csbNivelTraza);

              -- Se llama al api
              API_REGISTERREQUESTBYXML(isbrequestxml   => isbrequestxml,
                                        onupackageid    => onupackageidT,
                                        onumotiveid     => onumotiveidT,
                                        onuerrorcode    => onuerrorcodeT,
                                        osberrormessage => osberrormessageT);

              -- SE VALIDA SI SE PRESENTO ALGUN ERROR
              IF (onuerrorcodeT = 0) THEN
                pkg_traza.trace(csbMetodo||' FIN TRAMITE XML ---> OK', csbNivelTraza);
                COMMIT;
              ELSE
                pkg_traza.trace(csbMetodo||' FIN TRAMITE XML ---> ERROR', csbNivelTraza);
                pkg_traza.trace(csbMetodo||' Cliente a crear: ' || nuNewIdentificacion, csbNivelTraza);
                ONUERRORCODE    := -1;
                OSBERRORMESSAGE := UPPER('En la solicitud [' || nuPackageOrdenInicial || ']  :  ' || osberrormessageT);
                RAISE PKG_ERROR.CONTROLLED_ERROR;
              END IF;

            END IF;

          END IF; -- fin  IF(nuConteo > 0)
        END IF; -- fin IF(sbActualizaDatos = '4')
      END IF; -- fin IF(sbActualizaDatos = '3')
    END IF; -- fin IF(sbActualizaDatos = '1')
    pkg_traza.trace(csbMetodo||' FIN CREAR Y ATENDER SOLICITUDES', csbNivelTraza);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := UPPER(' PROCESO OK');
    pkg_traza.trace(csbMetodo||osberrormessage, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
       ROLLBACK;
       ONUERRORCODE := -1;
       IF OSBERRORMESSAGE IS NULL THEN
          OSBERRORMESSAGE := UPPER('ERROR LEGALIZANDO OT DE DOCUMENTOS');
       END IF;
      pkg_traza.trace(csbMetodo||' - '||onuErrorCode||' - '||osbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
      pkg_error.geterror(onuErrorCode,osbErrorMessage);
      RAISE PKG_ERROR.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ROLLBACK;
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR LEGALIZANDO OT DE DOCUMENTOS');
      pkg_traza.trace(csbMetodo||' - '||onuErrorCode||' - '||osbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
      pkg_error.geterror(onuErrorCode,osbErrorMessage);
      RAISE PKG_ERROR.CONTROLLED_ERROR;

  END prLegalizaOtFnbWeb;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : DILIGENCIAMIENTO_VENTA
  Descripcion    : Validaciones e informacion inicial para una venta Brilla
  Autor          : Sebastian Tapias
  Fecha          : 01/02/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  17/10/2023        Adrianavg            OSF-1687 Se reemplaza UT_TRACE por PKG_TRAZA.
                                         Se crea cursor cuExistSuscripc, cuPersonPortal y cuCupoEstrato como reemplazo del SELECT-INTO.
                                         Se reemplaza EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR. Se reemplaza ERRORS.SETERROR por
                                         PKG_ERROR.SETERROR. El tipo de dato de cuCursor, cuCursorSuscripc, cuCursorDeudor, cuCursorCupoEx
                                         ocuValida, ocuInfoSuscripc, ocuInfoDeudor, ocuInfoCoDeudor, ocuInfoFactura y ocuCupoExtra se cambia de
                                         constants.tyrefcursor por constants_per.tyrefcursor. Las palabras claves se colocan en mayúscula.
                                         Se añade inicializacion de variables que manejan el error con pkg_error.prInicializaError
                                         Se reubican la asignación nuCodValidacion  y sbNombreValidacion, del 01, 02, 04, 11 y 12 antes
                                         del BEGIN-END. Se reordena la asignación de sbItemSql. Se retira codigo comentado de LD_BONONBANKFINANCING.IdeInfProm
  27/10/2023        Adrianavg            OSF-1687 Se ajusta EXCEPTION para dald_quota_block.getRecords y se reemplaza ld_boconstans.fsbYesFlag por constants_per.csbyes                                         
  08/11/2023        Adrianavg            OSF-1687 Se ajusta lógica donde se asigna valor "Y" a la variable SbFlagUnion para dejarlo como se encontraba originalmente, posterior
                                         al RETURN  
  =========       =========             ====================
  ******************************************************************/
  procedure diligenciamiento_venta(inuSuscripc      IN NUMBER,
                                   inuIdentiTypeD   IN NUMBER,
                                   isbIdentiNumberD IN VARCHAR2,
                                   inuIdentiTypeC   IN NUMBER,
                                   isbIdentiNumberC IN VARCHAR2,
                                   inuCodProve      IN NUMBER,
                                   ocuValida        OUT constants_per.tyrefcursor,
                                   ocuInfoSuscripc  OUT constants_per.tyrefcursor,
                                   ocuInfoDeudor    OUT constants_per.tyrefcursor,
                                   ocuInfoCoDeudor  OUT constants_per.tyrefcursor,
                                   ocuInfoFactura   OUT constants_per.tyrefcursor,
                                   ocuCupoExtra     OUT constants_per.tyrefcursor,
                                   onuErrorCode     OUT NUMBER,
                                   osbErrorMessage  OUT VARCHAR2) is

    sbBlockSuscripc    BOOLEAN;
    sbBlockDeudor      BOOLEAN;
    sbRolloverCodeudor BOOLEAN;
    sbRolloverDeudor   BOOLEAN;
    sbRollover_Y_N     VARCHAR2(1);
    nuValidaFactura    NUMBER;
    nuVentasCodeudor   NUMBER;
    sbExcluyeCodeudor  BOOLEAN;
    nuVentaMant        NUMBER;
    sbBoolean          VARCHAR2(1);
    nuVentaSeguro      NUMBER;
    sbRequiereCodeudor BOOLEAN := FALSE;
    sbDesbloqueo       BOOLEAN := FALSE;
    nuExistSuscripc    NUMBER;
    sbExistCupoExtra   VARCHAR(1) := 'N';

    SbSQL            varchar2(10000);
    SbFlagUnion      varchar2(1) := 'N';
    SbUnion          varchar2(100) := null;
    SbSQLFIFAPInfo   varchar2(10000);
    sbItemSql        varchar2(10000) := NULL;
    sbCursorDSql     varchar2(10000) := NULL;
    sbCursorCSql     varchar2(10000) := NULL;
    cuCursor         constants_per.tyrefcursor;
    cuCursorSuscripc constants_per.tyrefcursor;
    cuCursorDeudor   constants_per.tyrefcursor;
    cuCursorCupoEx   constants_per.tyrefcursor;

    CURSOR cuDeudorSolidario(isbIdentification ldc_codeudor.iden_codeudor%type,
                             inuIdentType      ldc_codeudor.ident_type_deudor%type) IS
      SELECT ldc_codeudor.ident_deudor, ldc_codeudor.iden_type_codeudor
        FROM ldc_codeudor
       WHERE iden_codeudor = isbIdentification
         and iden_type_codeudor = inuIdentType
         and codeudor_solidario = 'Y';

    sbFlagDeudorSol ldc_codeudor.codeudor_solidario%type := null;

    TYPE t_DetalleCliente IS RECORD(
      SUBSCRIBER_NAME ge_subscriber.subscriber_name%TYPE,
      SUBS_LAST_NAME  ge_subscriber.subs_last_name%TYPE,
      GENDER          ge_subs_general_data.gender%TYPE,
      DATE_BIRTH      ge_subs_general_data.date_birth%TYPE,
      ADDRESS_ID      ge_subscriber.address%TYPE);

    v_DetalleCliente t_DetalleCliente;

    TYPE t_CupoExtra IS RECORD(
      SBLINE         VARCHAR2(300),
      SBSUBLINE      VARCHAR2(300),
      SBSUPPLIER     VARCHAR2(300),
      SBSALE_CHANEL  VARCHAR2(300),
      EXQUOTE        ld_extra_quota.value%TYPE,
      INITIAL_DATE   DATE,
      FINAL_DATE     DATE,
      LINE_ID        ld_extra_quota.Line_Id%TYPE,
      SUBLINE_ID     ld_extra_quota.Subline_Id%TYPE,
      SUPPLIER_ID    ld_extra_quota.supplier_id%TYPE,
      SALE_CHANEL_ID ld_extra_quota.sale_chanel_id%TYPE,
      EXTRAQUOTE_ID  ld_extra_quota.extra_quota_id%TYPE);

    TYPE tbCupoExtra IS TABLE OF t_CupoExtra;

    v_CupoExtra tbCupoExtra := tbCupoExtra();

    nuNextCupo NUMBER;

    TYPE t_Facturas IS RECORD(
      factcodi factura.factcodi%TYPE,
      factsusc factura.factsusc%TYPE,
      factpefa factura.factpefa%TYPE,
      factvaap factura.factvaap%TYPE,
      factfege factura.factfege%TYPE);

    v_Facturas t_Facturas;

    TYPE t_DeudorCodeudor IS RECORD(
      PROMISSORY_ID     NUMBER(15),
      HOLDER_BILL       VARCHAR2(1),
      DEBTORNAME        VARCHAR2(100),
      IDENTIFICATION    VARCHAR2(20),
      FORWARDINGPLACE   NUMBER(15),
      FORWARDINGDATE    DATE,
      GENDER            VARCHAR2(1),
      CIVIL_STATE_ID    NUMBER(2),
      BIRTHDAYDATE      DATE,
      SCHOOL_DEGREE_    NUMBER(2),
      PROPERTYPHONE_ID  NUMBER(15),
      DEPENDENTSNUMBER  NUMBER(15),
      HOUSINGTYPE       NUMBER(15),
      HOUSINGMONTH      NUMBER(4),
      HOLDERRELATION    NUMBER(4),
      OCCUPATION        VARCHAR2(100),
      COMPANYNAME       VARCHAR2(100),
      COMPANYADDRESS_ID NUMBER(15),
      PHONE1_ID         NUMBER(15),
      MOVILPHONE_ID     NUMBER(15),
      OLDLABOR          NUMBER(4),
      ACTIVITY          VARCHAR2(100),
      MONTHLYINCOME     NUMBER(15, 2),
      EXPENSESINCOME    NUMBER(15, 2),
      COMMERREFERENCE   VARCHAR2(200),
      PHONECOMMREFE     VARCHAR2(20),
      MOVILPHOCOMMREFE  VARCHAR2(20),
      ADDRESSCOMMREFE   NUMBER(15),
      FAMILIARREFERENCE VARCHAR2(200),
      PHONEFAMIREFE     VARCHAR2(20),
      MOVILPHOFAMIREFE  VARCHAR2(20),
      ADDRESSFAMIREFE   NUMBER(15),
      PERSONALREFERENCE VARCHAR2(200),
      PHONEPERSREFE     VARCHAR2(20),
      MOVILPHOPERSREFE  VARCHAR2(20),
      ADDRESSPERSREFE   NUMBER(15),
      EMAIL             VARCHAR2(100),
      PACKAGE_ID        NUMBER(15),
      PROMISSORY_TYPE   VARCHAR2(1),
      IDENT_TYPE_ID     NUMBER(4),
      CONTRACT_TYPE_ID  NUMBER(4),
      CATEGORY_ID       NUMBER(2),
      SUBCATEGORY_ID    NUMBER(2),
      PHONE2_ID         NUMBER(15),
      ADDRESS_ID        NUMBER(15),
      LAST_NAME         VARCHAR2(100));

    v_DeudorCodeudor t_DeudorCodeudor;

    nuCodValidacion    NUMBER(2) := null;
    sbNombreValidacion VARCHAR2(500);
    sbResult           VARCHAR2(2);
    sbPermiteVenta     VARCHAR2(2);
    sbMensaje          VARCHAR2(1000);

    IDPAGAREUNICO       NUMBER;
    OSBIDENTTYPE        VARCHAR2(100);
    OSBIDENTIFICATION   VARCHAR2(20);
    ONUSUBSCRIBERID     NUMBER(15);
    OSBSUBSNAME         VARCHAR2(100);
    OSBSUBSLASTNAME     VARCHAR2(100);
    OSBADDRESS          VARCHAR2(200);
    ONUADDRESS_ID       NUMBER(15);
    ONUGEOLOCATION      NUMBER(6);
    OSBFULLPHONE        VARCHAR2(200);
    OSBCATEGORY         VARCHAR2(100);
    OSBSUBCATEGORY      VARCHAR2(100);
    ONUCATEGORY         NUMBER;
    ONUSUBCATEGORY      NUMBER;
    ONUREDBALANCE       NUMBER;
    ONUASSIGNEDQUOTE    NUMBER;
    ONUUSEDQUOTE        NUMBER;
    ONUAVALIBLEQUOTE    NUMBER;
    OSBSUPPLIERNAME     VARCHAR2(100);
    ONUSUPPLIERID       NUMBER(4);
    OSBPOINTSALENAME    VARCHAR2(100);
    ONUPOINTSALEID      NUMBER(15);
    OBLTRANSFERQUOTE    BOOLEAN;
    OBLCOSIGNER         BOOLEAN;
    OBLCONSIGNERGASPROD BOOLEAN;
    OBLMODISALESCHANEL  BOOLEAN;
    ONUSALESCHANEL      NUMBER(4);
    OSBPROMISSORYTYPE   VARCHAR2(1);
    OBLREQUIAPPROANNULM BOOLEAN;
    OBLREQUIAPPRORETURN BOOLEAN;
    OSBSALENAMEREPORT   VARCHAR2(20);
    OSBEXERULEPOSTSALE  VARCHAR2(100);
    OSBPOSTLEGPROCESS   VARCHAR2(1);
    ONUMINFORDELIVERY   NUMBER(15, 2);
    OBLDELIVINPOINT     BOOLEAN;
    OBLEDITPOINTDEL     BOOLEAN;
    OBLLEGDELIVORDEAUTO BOOLEAN;
    OSBTYPEPROMISSNOTE  VARCHAR2(1);
    ONUINSURANCERATE    NUMBER;
    ODTDATE_BIRTH       DATE;
    OSBGENDER           VARCHAR2(1);
    ODTPEFEME           DATE;
    OSBVALIDATEBILL     VARCHAR2(100);
    OSBLOCATION         VARCHAR2(100);
    OSBDEPARTMENT       VARCHAR2(100);
    OSBEMAIL            VARCHAR2(100);

    ONUSALDORED    NUMBER(15, 2) := null;
    OSBCUPOBLO     VARCHAR2(10) := null;
    ONUCUPOESTRATO NUMBER(15, 2) := null;
    OSBPOLICY      VARCHAR2(32000) := null;
    OSBSEGMENT     VARCHAR2(1000) := null;
    ONUSEGMENTID   NUMBER(15) := null;
    ONUVOUCHOER    NUMBER(10) := null;
    NUBARRIO       ab_address.neighborthood_id%type := null;
    SBBARRIO       ge_geogra_location.description%type := null;
    tbBlock        dald_quota_block.tytbLD_quota_block;

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'diligenciamiento_venta';

    CURSOR cuExistSuscripc(p_inuSuscripc Suscripc.susccodi%type)
    IS
    SELECT COUNT(1)
      INTO nuExistSuscripc
      FROM SUSCRIPC
     WHERE SUSCRIPC.SUSCCODI = p_inuSuscripc;

    CURSOR cuPersonPortal(p_nuCodProve  or_operating_unit.contractor_id%type)
    IS /*Obtiene la persona conectada del proveedor*/
    SELECT person_id
    FROM cc_orga_area_seller
    WHERE IS_current = 'Y'
     AND organizat_area_id in (SELECT op.operating_unit_id
                                 FROM or_operating_unit op
                                WHERE op.contractor_id = p_nuCodProve /*309*/
                               )
     AND ROWNUM = 1;

    CURSOR cuCupoEstrato(p_onucategory LD_CREDIT_QUOTA.CATEGORY_ID%TYPE , p_onusubcategory LD_CREDIT_QUOTA.SUBCATEGORY_ID%TYPE )
    IS
    SELECT L.QUOTA_VALUE CUPO_ESTRATO
    FROM LD_CREDIT_QUOTA L
    WHERE L.CATEGORY_ID = p_onucategory
     AND L.SUBCATEGORY_ID = p_onusubcategory
     AND L.SIMULATION = 'N'
     AND ROWNUM = 1;

  BEGIN
    --------------------------------------------------------------------------------------------
    ----------------------------------> VALIDACION DE CAMPOS <----------------------------------
    --------------------------------------------------------------------------------------------
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    pkg_error.prInicializaError( onuErrorCode,osbErrorMessage);

    pkg_traza.trace(csbMetodo||' inuSuscripc: '||inuSuscripc
                             ||', inuIdentiTypeD: '||inuIdentiTypeD
                             ||', isbIdentiNumberD: '||isbIdentiNumberD
                             ||', isbIdentiNumberC: '||isbIdentiNumberC
                             ||', inuCodProve: '||inuCodProve , csbNivelTraza );


    IF inuSuscripc IS NULL THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error: El campo [inuSuscripc] no puede ser nulo.');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);
      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
      RETURN;
    ELSE
      BEGIN
         OPEN cuExistSuscripc(inuSuscripc);
        FETCH cuExistSuscripc INTO nuExistSuscripc;
        CLOSE cuExistSuscripc;

        IF nuExistSuscripc = 0 THEN
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error: El contrato [' || inuSuscripc || '] no existe.');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);
          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
          RETURN;
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error: El contrato [' || inuSuscripc || '] no existe.');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);
          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
          RETURN;
        WHEN OTHERS THEN
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error: Validando el contrato [' || inuSuscripc || '], verifique si es valido.');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);
          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
          RETURN;
      END;
    END IF;
    IF inuIdentiTypeD IS NULL THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error: El campo [inuIdentiTypeD] no puede ser nulo.');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);
      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
      RETURN;
    END IF;
    IF isbIdentiNumberD IS NULL THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error: El campo [isbIdentiNumberD] no puede ser nulo.');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);
      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
      RETURN;
    END IF;

    IF inuCodProve IS NULL THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error: El campo [inuCodProve] no puede ser nulo.');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);
      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
      RETURN;
    END IF;
    --------------------------------------------------------------------------------------------
    ---------------------------> VALIDACIONES A LA SUSCRIPCION <--------------------------------
    --------------------------------------------------------------------------------------------
    /*Obtiene la persona conectada del proveedor*/
    BEGIN
        OPEN cuPersonPortal(inuCodProve);
        FETCH cuPersonPortal INTO LD_BONONBANKFINANCING.nupersonportal;
        CLOSE cuPersonPortal;

        pkg_traza.trace(csbMetodo||', PersonPortal: '||LD_BONONBANKFINANCING.nupersonportal, csbNivelTraza );

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando persona conectada');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);
        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
        RETURN;
    END;
    ----------------------------------------------------------------
    -- Validaci?n de suscripci?n que est? asociado en la venta. -->
    ----------------------------------------------------------------
    nuCodValidacion := 01;

    sbNombreValidacion := 'Valida bloqueo para la suscripcion.';

    pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

    BEGIN
      sbBlockSuscripc := LD_BONONBANKFINANCING.LockSubscription(inuSuscripc);

      IF (sbBlockSuscripc) THEN
         pkg_traza.trace(csbMetodo||', sbBlockSuscripc: TRUE', csbNivelTraza );
      ELSE
         pkg_traza.trace(csbMetodo||', sbBlockSuscripc: FALSE', csbNivelTraza );
      END IF;

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando la suscripción que está asociada a la venta');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);
        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );
        RETURN;
    END;

    IF sbBlockSuscripc = TRUE THEN

      sbPermiteVenta := 'S';
      sbMensaje      := 'Suscripcion [' || inuSuscripc || '] Habilitada para venta';
      pkg_traza.trace(csbMetodo||', sbMensaje: '||sbMensaje, csbNivelTraza );
    ELSE

      sbPermiteVenta := 'N';
      sbMensaje      := 'OTRA SESION ESTA CONSULTADO EL CONTRATO [' || inuSuscripc || '], POR FAVOR INTENTA MAS TARDE';

      sbSql := UPPER('SELECT ''' || nuCodValidacion     || ''' CODCONDICION, '''
                                 || sbNombreValidacion  || ''' NOMBRECONDICION, '''
                                 || sbPermiteVenta      || ''' PERMITEVENTA, '''
                                 || sbMensaje           || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      onuErrorCode    := -1;
      osbErrorMessage := UPPER(sbMensaje);
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);

      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

      RETURN;

      SbFlagUnion := 'Y';
    END IF;

    pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );
    ---------------------------------------
    -- Validaci?n de factura vencidas. -->
    ---------------------------------------

    nuCodValidacion := 02;

    sbNombreValidacion := 'Valida si existen facturas vencidas.';

    pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

    BEGIN
      nuValidaFactura := LD_BONONBANKFINANCING.fnuBillNumber(inuSuscripc);

      pkg_traza.trace(csbMetodo||', nuValidaFactura: '||nuValidaFactura, csbNivelTraza );
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando facturas vencidas');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

        RETURN;
    END;

    IF nuValidaFactura = -1 THEN

      sbPermiteVenta := 'N';
      sbMensaje      := 'Suscripcion [' || inuSuscripc || '] Posee facturas vencidas';
      pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje, csbNivelTraza );

    ELSIF nuValidaFactura = 0 THEN

      sbPermiteVenta := 'S';
      sbMensaje      := 'Suscripcion [' || inuSuscripc || '] Habilitada para venta';
      pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje, csbNivelTraza );

    ELSE

      sbPermiteVenta := 'N';
      sbMensaje      := 'Suscripcion [' || inuSuscripc || '] Posee facturas vencidas';
      pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje, csbNivelTraza );

    END IF;

    IF nuValidaFactura <> 0 THEN

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||', sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida       := cuCursor;
      onuErrorCode    := -1;
      osbErrorMessage := UPPER(sbMensaje);
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);

      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

      RETURN;

      SbFlagUnion := 'Y';
    END IF;

    pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    --------------------------------------------------------------------------------------------
    ---------------------------> INFORMACION DE LA SUSCRIPCION <--------------------------------
    --------------------------------------------------------------------------------------------
    BEGIN
      LD_BONONBANKFINANCING.getFIFAPInfo(inuSuscripc,
                                         OSBIDENTTYPE,
                                         OSBIDENTIFICATION,
                                         ONUSUBSCRIBERID,
                                         OSBSUBSNAME,
                                         OSBSUBSLASTNAME,
                                         OSBADDRESS,
                                         ONUADDRESS_ID,
                                         ONUGEOLOCATION,
                                         OSBFULLPHONE,
                                         OSBCATEGORY,
                                         OSBSUBCATEGORY,
                                         ONUCATEGORY,
                                         ONUSUBCATEGORY,
                                         ONUREDBALANCE,
                                         ONUASSIGNEDQUOTE,
                                         ONUUSEDQUOTE,
                                         ONUAVALIBLEQUOTE,
                                         OSBSUPPLIERNAME,
                                         ONUSUPPLIERID,
                                         OSBPOINTSALENAME,
                                         ONUPOINTSALEID,
                                         OBLTRANSFERQUOTE,
                                         OBLCOSIGNER,
                                         OBLCONSIGNERGASPROD,
                                         OBLMODISALESCHANEL,
                                         ONUSALESCHANEL,
                                         OSBPROMISSORYTYPE,
                                         OBLREQUIAPPROANNULM,
                                         OBLREQUIAPPRORETURN,
                                         OSBSALENAMEREPORT,
                                         OSBEXERULEPOSTSALE,
                                         OSBPOSTLEGPROCESS,
                                         ONUMINFORDELIVERY,
                                         OBLDELIVINPOINT,
                                         OBLEDITPOINTDEL,
                                         OBLLEGDELIVORDEAUTO,
                                         OSBTYPEPROMISSNOTE,
                                         ONUINSURANCERATE,
                                         ODTDATE_BIRTH,
                                         OSBGENDER,
                                         ODTPEFEME,
                                         OSBVALIDATEBILL,
                                         OSBLOCATION,
                                         OSBDEPARTMENT,
                                         OSBEMAIL);
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo informacion de la suscripcion');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

        RETURN;
    END;

    --Obtiene Pagare Unico
    BEGIN
      IDPAGAREUNICO := LDC_PKVENTAPAGOUNICO.FNUPAGAREUNICO(inuSuscripc);

      pkg_traza.trace(csbMetodo||', Idpagareunico: '||IDPAGAREUNICO, csbNivelTraza );

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo PAGARE UNICO');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

        RETURN;
    END;

    sbItemSql := '''' || IDPAGAREUNICO || ''' NUPAGAREUNICO, ';
    sbItemSql := sbItemSql || '''' || OSBIDENTTYPE      || ''' OSBIDENTTYPE, ';
    sbItemSql := sbItemSql || '''' || OSBIDENTIFICATION || ''' OSBIDENTIFICATION, ';
    sbItemSql := sbItemSql || '''' || ONUSUBSCRIBERID   || ''' ONUSUBSCRIBERID, ';
    sbItemSql := sbItemSql || '''' || OSBSUBSNAME       || ''' OSBSUBSNAME, ';
    sbItemSql := sbItemSql || '''' || OSBSUBSLASTNAME   || ''' OSBSUBSLASTNAME, ';
    sbItemSql := sbItemSql || '''' || OSBADDRESS        || ''' OSBADDRESS, ';
    sbItemSql := sbItemSql || '''' || ONUADDRESS_ID     || ''' ONUADDRESS_ID, ';
    sbItemSql := sbItemSql || '''' || ONUGEOLOCATION    || ''' ONUGEOLOCATION, ';
    sbItemSql := sbItemSql || '''' || OSBFULLPHONE      || ''' OSBFULLPHONE, ';
    sbItemSql := sbItemSql || '''' || OSBCATEGORY       || ''' OSBCATEGORY, ';
    sbItemSql := sbItemSql || '''' || OSBSUBCATEGORY    || ''' OSBSUBCATEGORY, ';
    sbItemSql := sbItemSql || '''' || ONUCATEGORY       || ''' ONUCATEGORY, ';
    sbItemSql := sbItemSql || '''' || ONUSUBCATEGORY    || ''' ONUSUBCATEGORY, ';
    sbItemSql := sbItemSql || '''' || ONUASSIGNEDQUOTE  || ''' ONUASSIGNEDQUOTE, ';
    sbItemSql := sbItemSql || '''' || ONUUSEDQUOTE      || ''' ONUUSEDQUOTE, ';
    sbItemSql := sbItemSql || '''' || ONUAVALIBLEQUOTE  || ''' ONUAVALIBLEQUOTE, ';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza );

    IF OBLTRANSFERQUOTE = TRUE THEN

      sbBoolean := 'Y';

    ELSE

      sbBoolean := 'N';

      --TransferQuota

      nuCodValidacion := 03;

      sbNombreValidacion := 'Valida si Permite traslado de cupo Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbBoolean || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||', sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    END IF;

    IF OBLCOSIGNER = TRUE THEN

      pkg_traza.trace(csbMetodo||', Oblcosigner: TRUE', csbNivelTraza );

      sbBoolean          := 'Y';
      sbRequiereCodeudor := TRUE;
      -------------------------------------
      -- Valida si excluye codeudor.  -->
      -------------------------------------

      nuCodValidacion := 04;

      sbNombreValidacion := 'Valida si requiere codeudor Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      BEGIN
        ldc_codeudores.blValidNoCosigner(inuIdentiTypeD,
                                         isbIdentiNumberD,
                                         inuSuscripc,
                                         sbExcluyeCodeudor);
      EXCEPTION
        WHEN OTHERS THEN
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error validando exclusion de codeudor');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);

          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza );

          RETURN;
      END;

      IF sbExcluyeCodeudor = TRUE THEN

        sbRequiereCodeudor := FALSE;

      END IF;

      IF sbRequiereCodeudor = FALSE THEN

        sbResult       := 'N';
        sbPermiteVenta := 'S';
        sbMensaje      := '' || sbResult || '';

        pkg_traza.trace(csbMetodo||' sbRequiereCodeudor: FALSE', csbNivelTraza );

      ELSE
        pkg_traza.trace(csbMetodo||' sbRequiereCodeudor: TRUE', csbNivelTraza );
        sbResult       := 'Y';
        sbPermiteVenta := 'S';
        sbMensaje      := '' || sbResult || '';

        IF SbFlagUnion = 'Y' THEN
          SbUnion := 'UNION';
        ELSE
          SbUnion := null;
        END IF;

        sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                             || 'SELECT '''
                             || nuCodValidacion     || ''' CODCONDICION, '''
                             || sbNombreValidacion  || ''' NOMBRECONDICION, '''
                             || sbPermiteVenta      || ''' PERMITEVENTA, '''
                             || sbMensaje           || ''' MENSAJE FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

        OPEN cuCursor FOR sbSql;

        ocuValida := cuCursor;

        SbFlagUnion := 'Y';

      END IF;

       pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    ELSE
      sbRequiereCodeudor := FALSE;
      sbBoolean          := 'N';

      pkg_traza.trace(csbMetodo||' sbRequiereCodeudor: FALSE', csbNivelTraza );

    END IF;

    IF sbRequiereCodeudor = TRUE THEN
      IF OBLCONSIGNERGASPROD = TRUE THEN

      pkg_traza.trace(csbMetodo||' Oblconsignergasprod: TRUE', csbNivelTraza );

        sbBoolean := 'Y';

        --Codeudor requiere producto GAS

        nuCodValidacion := 05;

        sbNombreValidacion := 'Valida si el codeudor debe tener producto de GAS Y/N';

        pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

        sbResult       := sbBoolean;
        sbPermiteVenta := 'S';
        sbMensaje      := '' || sbBoolean || '';

        IF SbFlagUnion = 'Y' THEN
          SbUnion := 'UNION';
        ELSE
          SbUnion := null;
        END IF;

        sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                             || 'SELECT '''
                             || nuCodValidacion     || ''' CODCONDICION, '''
                             || sbNombreValidacion  || ''' NOMBRECONDICION, '''
                             || sbPermiteVenta      || ''' PERMITEVENTA, '''
                             || sbMensaje           || ''' MENSAJE FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

        OPEN cuCursor FOR sbSql;

        ocuValida := cuCursor;

        SbFlagUnion := 'Y';

        pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

      ELSE

        sbBoolean := 'N';

      END IF;

    END IF;

    IF OBLMODISALESCHANEL = TRUE THEN

      sbBoolean := 'Y';

    ELSE

      sbBoolean := 'N';

      --Selecciona canal de venta Y/N

      nuCodValidacion := 06;

      sbNombreValidacion := 'Valida si puede seleccionar canal de venta Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbBoolean || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    END IF;

    IF OBLDELIVINPOINT = TRUE THEN

      sbBoolean := 'Y';

      --Entrega en punto Y/N

      nuCodValidacion := 07;

      sbNombreValidacion := 'Valida si permite entrega en punto Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbBoolean || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    ELSE

      sbBoolean := 'N';

    END IF;

    IF OBLDELIVINPOINT = TRUE THEN

      --Valor minimo para entrega

      nuCodValidacion := 08;

      sbNombreValidacion := 'Valida el valor minimo para entrega';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      sbPermiteVenta := 'S';
      sbMensaje      := '' || ONUMINFORDELIVERY || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

      IF OBLEDITPOINTDEL = TRUE THEN

        sbBoolean := 'Y';

      ELSE

        sbBoolean := 'N';

        --Es editable Entrega en Punto? Y/N

        nuCodValidacion := 09;

        sbNombreValidacion := 'Valida si es editable la Entrega en Punto? Y/N';

        pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

        sbPermiteVenta := 'S';
        sbMensaje      := '' || sbBoolean || '';

        IF SbFlagUnion = 'Y' THEN
          SbUnion := 'UNION';
        ELSE
          SbUnion := null;
        END IF;

        sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                             || 'SELECT '''
                             || nuCodValidacion     || ''' CODCONDICION, '''
                             || sbNombreValidacion  || ''' NOMBRECONDICION, '''
                             || sbPermiteVenta      || ''' PERMITEVENTA, '''
                             || sbMensaje           || ''' MENSAJE FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

        OPEN cuCursor FOR sbSql;

        ocuValida := cuCursor;

        SbFlagUnion := 'Y';

        pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

      END IF;

    END IF;

    IF OBLLEGDELIVORDEAUTO = TRUE THEN

      sbBoolean := 'Y';

    ELSE

      sbBoolean := 'N';

      --Legaliza ordenes de entrega automaticamente? Y/N

      nuCodValidacion := 10;

      sbNombreValidacion := 'Valida si legaliza ordenes de entrega automaticamente? Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza );

      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbBoolean || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza );

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza );

    END IF;

    sbItemSql := sbItemSql || '''' || ODTDATE_BIRTH || ''' ODTDATE_BIRTH, ';
    sbItemSql := sbItemSql || '''' || OSBGENDER     || ''' OSBGENDER, ';
    sbItemSql := sbItemSql || '''' || ODTPEFEME     || ''' ODTPEFEME, ';
    sbItemSql := sbItemSql || '''' || OSBLOCATION   || ''' OSBLOCATION, ';
    sbItemSql := sbItemSql || '''' || OSBDEPARTMENT || ''' OSBDEPARTMENT, ';
    sbItemSql := sbItemSql || '''' || OSBEMAIL      || ''' OSBEMAIL,';
    ONUSALDORED := ONUREDBALANCE;
    sbItemSql   := sbItemSql || '''' || ONUSALDORED || ''' ONUSALDORED,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza );

    BEGIN
      dald_quota_block.getRecords('ld_quota_block.subscription_id = ' || nvl(inuSuscripc, 1.1)
                                  || ' order by register_date desc ', tbBlock);
      IF (tbBlock(tbBlock.first).block = constants_per.csbyes) THEN
        OSBCUPOBLO := 'SI';
      ELSE
        OSBCUPOBLO := 'NO';
      END IF;
    EXCEPTION
      WHEN PKG_ERROR.CONTROLLED_ERROR THEN
        PKG_ERROR.getError(onuErrorCode, osbErrorMessage);
        IF (1 = onuErrorCode) THEN
          OSBCUPOBLO := 'NO';
        END IF;           
        pkg_traza.trace(csbMetodo||' dald_quota_block - '||onuErrorCode||' - '||osbErrorMessage, csbNivelTraza, pkg_traza.csbFIN_ERC);
    END;
    sbItemSql := sbItemSql || '''' || OSBCUPOBLO || ''' OSBCUPOBLO,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    BEGIN
         OPEN cuCupoEstrato(ONUCATEGORY, ONUSUBCATEGORY);
        FETCH cuCupoEstrato INTO ONUCUPOESTRATO;
        CLOSE cuCupoEstrato;

    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        ONUCUPOESTRATO := null;
        pkg_error.setError;
        pkg_error.geterror(nuErrorCode,sbErrorMessage);
        pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage, csbNivelTraza, pkg_traza.csbFIN_ERC);
    END;
    sbItemSql := sbItemSql || '''' || ONUCUPOESTRATO ||  ''' ONUCUPOESTRATO,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    BEGIN

      pkg_traza.trace(csbMetodo||' - Validando politicas', csbNivelTraza );

      OSBPOLICY := ld_boqueryfnb.fsbgetPolicy(inuSuscripc);
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando politicas');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;
    sbItemSql := sbItemSql || '' || OSBPOLICY || ' OSBPOLICY,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    pkg_traza.trace(csbMetodo||' Termina Validando politicas', csbNivelTraza );

    BEGIN

      pkg_traza.trace(csbMetodo||' - Validando segmentacion', csbNivelTraza );

      ldc_bccommercialsegmentfnb.proGetAcronNameSegmbySusc(inuSuscripc,
                                                           ONUSEGMENTID,
                                                           OSBSEGMENT);
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando segmentacion');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;
    sbItemSql := sbItemSql || '''' || ONUSEGMENTID || ''' ONUSEGMENTID,';
    sbItemSql := sbItemSql || '''' || ONUSEGMENTID || '|' || OSBSEGMENT || ''' OSBSEGMENT,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    pkg_traza.trace(csbMetodo||' Termina Validando segmentacion', csbNivelTraza );

    BEGIN

      pkg_traza.trace(csbMetodo||' - Obteniendo VOUCHER', csbNivelTraza );

      ONUVOUCHOER := LDC_PKVENTAPAGOUNICO.FNUVOUCHER(inuSuscripc,  IDPAGAREUNICO);
    EXCEPTION
      When others then
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo VOUCHER');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    sbItemSql := sbItemSql || '''' || ONUVOUCHOER || ''' ONUVOUCHOER,';

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    pkg_traza.trace(csbMetodo||' Termina obteniendo VOUCHER', csbNivelTraza );

    -----------------
    --OBTIENE BARRIO
    -----------------

    prcConsultaBarrio(inuSuscripc, NUBARRIO, SBBARRIO);

    sbItemSql := sbItemSql || '''' || NUBARRIO          || ''' ONUBARRIO,';
    sbItemSql := sbItemSql || '''' || SBBARRIO          || ''' OSBBARRIO,';
    sbItemSql := sbItemSql || '''' || ONUSALESCHANEL    || ''' ONUSALESCHANEL'; --Canal de venta, Etapa 2, 200-2027

    pkg_traza.trace(csbMetodo||' sbItemSql: '||sbItemSql, csbNivelTraza);

    SbSQLFIFAPInfo := UPPER('SELECT ' || sbItemSql || ' FROM DUAL');

    pkg_traza.trace(csbMetodo||' SbSQLFIFAPInfo: '||SbSQLFIFAPInfo, csbNivelTraza);

    OPEN cuCursorSuscripc FOR SbSQLFIFAPInfo;

    ocuInfoSuscripc := cuCursorSuscripc;

    --------------------------------------------------------------------------------------------
    ---------------------------> VALIDACIONES AL DEUDOR/CODEUDOR <------------------------------
    --------------------------------------------------------------------------------------------
    nuCodValidacion := 11;

    sbNombreValidacion := 'Valida si el deudor esta bloqueado.';

    pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza);

    BEGIN
      sbBlockDeudor := LD_BONONBANKFINANCING.fnuValidateSubsBlocked(inuIdentiTypeD,
                                                                    isbIdentiNumberD);
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error realizando validaciones generales al deudor');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    IF sbBlockDeudor = TRUE THEN

      sbResult       := 'Y';
      sbPermiteVenta := 'N';
      sbMensaje      := '' || sbResult || '';

    ELSE

      sbResult       := 'N';
      sbPermiteVenta := 'S';
      sbMensaje      := 'Deudor [' || isbIdentiNumberD || '] Habilitado para venta';

      pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje, csbNivelTraza);

    END IF;

    IF sbBlockDeudor = TRUE THEN

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza);

      OPEN cuCursor FOR sbSql;

      ocuValida       := cuCursor;
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Deudor [' || isbIdentiNumberD ||  '] No Habilitado para venta');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);

      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

      RETURN;

      SbFlagUnion := 'Y';
    END IF;

    pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza);

    -------------------------------------
    -- Valida codeudor.  -->
    -------------------------------------
    IF sbRequiereCodeudor = TRUE OR inuIdentiTypeC IS NOT NULL OR
       isbIdentiNumberC IS NOT NULL THEN

      nuCodValidacion := 12;

      sbNombreValidacion := 'Valida si el codeudor esta bloqueado.';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza);

      IF inuIdentiTypeC IS NULL OR isbIdentiNumberC IS NULL THEN

        onuErrorCode    := -1;
        osbErrorMessage := UPPER('La venta requiere codeudor, por favor ingrese los datos.');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;

      ELSE
        ----------------------
        --CA.200-2027 Se agrega la misma validacion que al deudor.
        ----------------------
        sbBlockDeudor := FALSE;
        pkg_traza.trace(csbMetodo||' sbBlockDeudor: FALSE', csbNivelTraza);
        BEGIN

          pkg_traza.trace(csbMetodo||' - Validaciones generales al codeudor ', csbNivelTraza);

          sbBlockDeudor := LD_BONONBANKFINANCING.fnuValidateSubsBlocked(inuIdentiTypeC,
                                                                        isbIdentiNumberC);
        EXCEPTION
          WHEN OTHERS THEN
            onuErrorCode    := -1;
            osbErrorMessage := UPPER('Error realizando validaciones generales al codeudor');
            /*Cerrar Cursores*/
            prcCierraCursor(ocuValida);
            prcCierraCursor(ocuInfoSuscripc);
            prcCierraCursor(ocuInfoDeudor);
            prcCierraCursor(ocuInfoCoDeudor);
            prcCierraCursor(ocuInfoFactura);
            prcCierraCursor(ocuCupoExtra);

            pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

            RETURN;

        END;

        IF sbBlockDeudor = TRUE THEN

          sbResult       := 'Y';
          sbPermiteVenta := 'N';
          sbMensaje      := '' || sbResult || '';

        ELSE

          sbResult       := 'N';
          sbPermiteVenta := 'S';
          sbMensaje      := 'Codeudor [' || isbIdentiNumberC || '] Habilitado para venta';

          pkg_traza.trace(csbMetodo||' sbMensaje: '||sbMensaje, csbNivelTraza);

        END IF;

        IF sbBlockDeudor = TRUE THEN

          IF SbFlagUnion = 'Y' THEN
            SbUnion := 'UNION';
          ELSE
            SbUnion := null;
          END IF;

          sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                               || 'SELECT '''
                               || nuCodValidacion       || ''' CODCONDICION, '''
                               || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                               || sbPermiteVenta        || ''' PERMITEVENTA, '''
                               || sbMensaje             || ''' MENSAJE FROM DUAL');

          pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza);

          OPEN cuCursor FOR sbSql;

          ocuValida       := cuCursor;
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Codeudor [' || isbIdentiNumberC || '] No Habilitado para venta');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);

          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

          RETURN;

          SbFlagUnion := 'Y';

        END IF;
        ----------------------
        -- CA.200-2027 Fin.
        ----------------------
        pkg_traza.trace(csbMetodo||' Termina Validaciones generales al codeudor ', csbNivelTraza);

      END IF; -- Fin IF inuIdentiTypeC IS NULL OR isbIdentiNumberC IS NULL THEN

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza);

    END IF; -- Fin IF sbRequiereCodeudor = TRUE THEN

    --------------------------------------------------------------------------------------------
    ---------------------------> INFORMACION DEL DEUDOR/CODEUDOR <------------------------------
    --------------------------------------------------------------------------------------------
    BEGIN
      ---------------------------
      --Valida Deudor Rollover
      ---------------------------
      sbRolloverDeudor := FALSE;
      sbRollover_Y_N   := null;
      BEGIN

        pkg_traza.trace(csbMetodo||' - Validando deudor rollover ', csbNivelTraza);

        LD_BONONBANKFINANCING.LDC_prValidateSalesDebtor(isbIdentiNumberD,
                                                        inuIdentiTypeD,
                                                        sbRolloverDeudor);
      EXCEPTION
        WHEN OTHERS THEN
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error validando deudor rollover');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);

          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

          RETURN;
      END;

      IF sbRolloverDeudor = FALSE THEN

        sbRollover_Y_N := 'N';

      ELSE

        sbRollover_Y_N := 'Y';

      END IF;
      ------------------------------
      --Fin Valida Deudor Rollover
      ------------------------------
      IF IDPAGAREUNICO IS NULL OR IDPAGAREUNICO = 0 THEN

         pkg_traza.trace(csbMetodo||' idpagareunico IS NULL OR idpagareunico = 0 ', csbNivelTraza);
        --caso 200-2375
        --se copia el servicio y se implemento en el paquete directamente
         ocuInfoDeudor := getIdTypeByPrommisory(inuIdentiTypeD,
                                               isbIdentiNumberD,
                                               'D');
      ELSE
        pkg_traza.trace(csbMetodo||' idpagareunico IS NOT NULL OR idpagareunico != 0 '||IDPAGAREUNICO, csbNivelTraza);

        ocuInfoDeudor := getIdTypeByPrommisoryPu(IDPAGAREUNICO, 'D');

      END IF;

      FETCH ocuInfoDeudor
       INTO v_DeudorCodeudor;

      IF v_DeudorCodeudor.PROMISSORY_ID IS NULL THEN

        pkg_traza.trace(csbMetodo||' PROMISSORY_ID IS NULL ', csbNivelTraza);

        BEGIN
          LD_BONONBANKFINANCING.GetSubscriberInfoBySusc(inuIdentiTypeD,
                                                        isbIdentiNumberD,
                                                        inuSuscripc,
                                                        cuCursorDeudor);

          FETCH cuCursorDeudor
           INTO v_DetalleCliente;

          --CASO 200-2375
          --Se cambio NULL por N en HOLDER_BILL por solucitud del Ing. Samuel Pacheco
          --CASO 200-2375

          sbCursorDSql := UPPER('SELECT NULL "PROMISSORY_ID",
                                ''N'' "HOLDER_BILL",              '''
                                || v_DetalleCliente.SUBSCRIBER_NAME || ''' "DEBTORNAME",
                                NULL "IDENTIFICATION",
                                NULL "FORWARDINGPLACE",
                                NULL "FORWARDINGDATE",
                                ''' || v_DetalleCliente.GENDER || ''' "GENDER",
                                NULL "CIVIL_STATE_ID",
                                ''' || v_DetalleCliente.DATE_BIRTH ||''' "BIRTHDAYDATE",
                                NULL "SCHOOL_DEGREE_",
                                NULL "PROPERTYPHONE_ID",
                                NULL "DEPENDENTSNUMBER",
                                NULL "HOUSINGTYPE",
                                NULL "HOUSINGMONTH",
                                NULL "HOLDERRELATION",
                                NULL "OCCUPATION",
                                NULL "COMPANYNAME",
                                NULL "COMPANYADDRESS_ID",
                                NULL "PHONE1_ID",
                                NULL "MOVILPHONE_ID",
                                NULL "OLDLABOR",
                                NULL "ACTIVITY",
                                NULL "MONTHLYINCOME",
                                NULL "EXPENSESINCOME",
                                NULL "COMMERREFERENCE",
                                NULL "PHONECOMMREFE",
                                NULL "MOVILPHOCOMMREFE",
                                NULL "ADDRESSCOMMREFE",
                                NULL "FAMILIARREFERENCE",
                                NULL "PHONEFAMIREFE",
                                NULL "MOVILPHOFAMIREFE",
                                NULL "ADDRESSFAMIREFE",
                                NULL "PERSONALREFERENCE",
                                NULL "PHONEPERSREFE",
                                NULL "MOVILPHOPERSREFE",
                                NULL "ADDRESSPERSREFE",
                                NULL "EMAIL",
                                NULL "PACKAGE_ID",
                                NULL "PROMISSORY_TYPE",
                                NULL "IDENT_TYPE_ID",
                                NULL "CONTRACT_TYPE_ID",
                                NULL "CATEGORY_ID",
                                NULL "SUBCATEGORY_ID",
                                NULL "PHONE2_ID",
                                ''' || v_DetalleCliente.ADDRESS_ID ||  ''' "ADDRESS_ID",
                                ''' || v_DetalleCliente.SUBS_LAST_NAME || ''' "LAST_NAME",
                                ''' || sbRollover_Y_N ||''' "ROLLOVER"
                           FROM DUAL');

          pkg_traza.trace(csbMetodo||' sbCursorDSql: '||sbCursorDSql, csbNivelTraza);

          OPEN ocuInfoDeudor FOR sbCursorDSql;

        EXCEPTION
          WHEN OTHERS THEN
            onuErrorCode    := -1;
            osbErrorMessage := UPPER('Error obteniendo informacion del deudor');
            /*Cerrar Cursores*/
            prcCierraCursor(ocuValida);
            prcCierraCursor(ocuInfoSuscripc);
            prcCierraCursor(ocuInfoDeudor);
            prcCierraCursor(ocuInfoCoDeudor);
            prcCierraCursor(ocuInfoFactura);
            prcCierraCursor(ocuCupoExtra);

            pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

            RETURN;
        END;

      ELSE

        pkg_traza.trace(csbMetodo||' PROMISSORY_ID: '||v_DeudorCodeudor.PROMISSORY_ID, csbNivelTraza);

        sbCursorDSql := UPPER('SELECT ''' || v_DeudorCodeudor.PROMISSORY_ID     || ''' "PROMISSORY_ID",
                                      ''' || v_DeudorCodeudor.HOLDER_BILL       || ''' "HOLDER_BILL",
                                      ''' || v_DeudorCodeudor.DEBTORNAME        || ''' "DEBTORNAME",
                                      ''' || v_DeudorCodeudor.IDENTIFICATION    || ''' "IDENTIFICATION",
                                      ''' || v_DeudorCodeudor.FORWARDINGPLACE   || ''' "FORWARDINGPLACE",
                                      ''' || v_DeudorCodeudor.FORWARDINGDATE    || ''' "FORWARDINGDATE",
                                      ''' || v_DeudorCodeudor.GENDER            || ''' "GENDER",
                                      ''' || v_DeudorCodeudor.CIVIL_STATE_ID    || ''' "CIVIL_STATE_ID",
                                      ''' || v_DeudorCodeudor.BIRTHDAYDATE      || ''' "BIRTHDAYDATE",
                                      ''' || v_DeudorCodeudor.SCHOOL_DEGREE_    || ''' "SCHOOL_DEGREE_",
                                      ''' || v_DeudorCodeudor.PROPERTYPHONE_ID  || ''' "PROPERTYPHONE_ID",
                                      ''' || v_DeudorCodeudor.DEPENDENTSNUMBER  || ''' "DEPENDENTSNUMBER",
                                      ''' || v_DeudorCodeudor.HOUSINGTYPE       || ''' "HOUSINGTYPE",
                                      ''' || v_DeudorCodeudor.HOUSINGMONTH      || ''' "HOUSINGMONTH",
                                      ''' || v_DeudorCodeudor.HOLDERRELATION    || ''' "HOLDERRELATION",
                                      ''' || v_DeudorCodeudor.OCCUPATION        || ''' "OCCUPATION",
                                      ''' || v_DeudorCodeudor.COMPANYNAME       || ''' "COMPANYNAME",
                                      ''' || v_DeudorCodeudor.COMPANYADDRESS_ID || ''' "COMPANYADDRESS_ID",
                                      ''' || v_DeudorCodeudor.PHONE1_ID         || ''' "PHONE1_ID",
                                      ''' || v_DeudorCodeudor.MOVILPHONE_ID     || ''' "MOVILPHONE_ID",
                                      ''' || v_DeudorCodeudor.OLDLABOR          || ''' "OLDLABOR",
                                      ''' || v_DeudorCodeudor.ACTIVITY          || ''' "ACTIVITY",
                                      ''' || v_DeudorCodeudor.MONTHLYINCOME     || ''' "MONTHLYINCOME",
                                      ''' || v_DeudorCodeudor.EXPENSESINCOME    || ''' "EXPENSESINCOME",
                                      ''' || v_DeudorCodeudor.COMMERREFERENCE   || ''' "COMMERREFERENCE",
                                      ''' || v_DeudorCodeudor.PHONECOMMREFE     || ''' "PHONECOMMREFE",
                                      ''' || v_DeudorCodeudor.MOVILPHOCOMMREFE  || ''' "MOVILPHOCOMMREFE",
                                      ''' || v_DeudorCodeudor.ADDRESSCOMMREFE   || ''' "ADDRESSCOMMREFE",
                                      ''' || v_DeudorCodeudor.FAMILIARREFERENCE || ''' "FAMILIARREFERENCE",
                                      ''' || v_DeudorCodeudor.PHONEFAMIREFE     || ''' "PHONEFAMIREFE",
                                      ''' || v_DeudorCodeudor.MOVILPHOCOMMREFE  || ''' "MOVILPHOFAMIREFE",
                                      ''' || v_DeudorCodeudor.ADDRESSCOMMREFE   || ''' "ADDRESSFAMIREFE",
                                      ''' || v_DeudorCodeudor.PERSONALREFERENCE || ''' "PERSONALREFERENCE",
                                      ''' || v_DeudorCodeudor.PHONEPERSREFE     || ''' "PHONEPERSREFE",
                                      ''' || v_DeudorCodeudor.MOVILPHOPERSREFE  || ''' "MOVILPHOPERSREFE",
                                      ''' || v_DeudorCodeudor.ADDRESSPERSREFE   || ''' "ADDRESSPERSREFE",
                                      ''' || v_DeudorCodeudor.EMAIL             || ''' "EMAIL",
                                      ''' || v_DeudorCodeudor.PACKAGE_ID        || ''' "PACKAGE_ID",
                                      ''' || v_DeudorCodeudor.PROMISSORY_TYPE   || ''' "PROMISSORY_TYPE",
                                      ''' || v_DeudorCodeudor.PROMISSORY_TYPE   || ''' "IDENT_TYPE_ID",
                                      ''' || v_DeudorCodeudor.CONTRACT_TYPE_ID  || ''' "CONTRACT_TYPE_ID",
                                      ''' || v_DeudorCodeudor.CATEGORY_ID       || ''' "CATEGORY_ID",
                                      ''' || v_DeudorCodeudor.SUBCATEGORY_ID    || ''' "SUBCATEGORY_ID",
                                      ''' || v_DeudorCodeudor.PHONE2_ID         || ''' "PHONE2_ID",
                                      ''' || v_DeudorCodeudor.ADDRESS_ID        || ''' "ADDRESS_ID",
                                      ''' || v_DeudorCodeudor.LAST_NAME         || ''' "LAST_NAME",
                                      ''' || sbRollover_Y_N                     || ''' "ROLLOVER"
                                      FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbCursorDSql: '||sbCursorDSql, csbNivelTraza);

        OPEN ocuInfoDeudor FOR sbCursorDSql;

      END IF;

    pkg_traza.trace(csbMetodo||' Termina Validando deudor rollover ', csbNivelTraza);

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo informacion del deudor');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    ---------------
    --Codeudor.
    ---------------
    BEGIN
      --------------------
      --200-2027
      --Se obtiene numero de ventas resgistradas y sin cancelar como codeudor.
      --------------------
      nuVentasCodeudor := 0;
      BEGIN

        IF (Dald_parameter.fsbGetValue_Chain('ACT_DEUDOR_SOLIDARIO') = 'Y') THEN
          -- Se valida ventas como deudor solidario, diferentes a las deudor de la venta.
          FOR x IN cuDeudorSolidario(isbIdentiNumberC, inuIdentiTypeC) LOOP
            IF to_number(x.ident_deudor) = to_number(isbIdentiNumberD) AND
               to_number(x.iden_type_codeudor) = inuIdentiTypeD THEN
              nuVentasCodeudor := 0;
            ELSE
              nuVentasCodeudor := 1;
            END IF;
            EXIT WHEN nuVentasCodeudor >= 1;
          END LOOP;

        END IF;

      EXCEPTION
        WHEN OTHERS THEN
          nuVentasCodeudor := 0;
      END;

      IF nuVentasCodeudor = 0 THEN
        BEGIN

          pkg_traza.trace(csbMetodo||' - Validando ventas asociadas codeudor', csbNivelTraza);

          nuVentasCodeudor := LDC_PKVENTAFNB.FNUCANTVENTSINCANC(inuIdentiTypeC,
                                                                isbIdentiNumberC);
        EXCEPTION
          WHEN OTHERS THEN
            onuErrorCode    := -1;
            osbErrorMessage := UPPER('Error validando ventas asociadas codeudor');
            /*Cerrar Cursores*/
            prcCierraCursor(ocuValida);
            prcCierraCursor(ocuInfoSuscripc);
            prcCierraCursor(ocuInfoDeudor);
            prcCierraCursor(ocuInfoCoDeudor);
            prcCierraCursor(ocuInfoFactura);
            prcCierraCursor(ocuCupoExtra);

            pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

            RETURN;
        END;

        pkg_traza.trace(csbMetodo||' Termina validando ventas asociadas codeudor', csbNivelTraza);

      END IF;
      ----------------
      --200-2027 Fin.
      ----------------
      ---------------------------
      --Valida Codeudor Rollover
      ---------------------------
      sbRolloverCodeudor := FALSE;
      sbRollover_Y_N     := null;
      BEGIN

        pkg_traza.trace(csbMetodo||' - Validando codeudor rollover ', csbNivelTraza);

        LD_BONONBANKFINANCING.LDC_prValidateSalesDebtor(isbIdentiNumberC,
                                                        inuIdentiTypeC,
                                                        sbRolloverCodeudor);
      EXCEPTION
        When others then
          onuErrorCode    := -1;
          osbErrorMessage := UPPER('Error validando codeudor rollover');
          /*Cerrar Cursores*/
          prcCierraCursor(ocuValida);
          prcCierraCursor(ocuInfoSuscripc);
          prcCierraCursor(ocuInfoDeudor);
          prcCierraCursor(ocuInfoCoDeudor);
          prcCierraCursor(ocuInfoFactura);
          prcCierraCursor(ocuCupoExtra);

          pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

          RETURN;
      END;

      IF sbRolloverCodeudor = FALSE THEN

        sbRollover_Y_N := 'N';

      ELSE

        sbRollover_Y_N := 'Y';

      END IF;

      ------------------------------
      --Fin Valida Codeudor Rollover
      ------------------------------
      IF IDPAGAREUNICO IS NULL OR IDPAGAREUNICO = 0 THEN

        pkg_traza.trace(csbMetodo||' idpagareunico IS NULL OR idpagareunico = 0 ', csbNivelTraza);
        --caso 200-2375
        --se copia el servicio y se implemento en el paquete directamente
        ocuInfoCoDeudor := getIdTypeByPrommisory(inuIdentiTypeC,
                                                 isbIdentiNumberC,
                                                 'C');
      ELSE

        pkg_traza.trace(csbMetodo||' idpagareunico IS NOT NULL OR idpagareunico != 0 ', csbNivelTraza);

        ocuInfoCoDeudor := getIdTypeByPrommisoryPu(IDPAGAREUNICO, 'C');
      END IF;

      v_DeudorCodeudor := null;

      FETCH ocuInfoCoDeudor
       INTO v_DeudorCodeudor;

      IF v_DeudorCodeudor.PROMISSORY_ID IS NULL THEN

        sbCursorCSql := UPPER('SELECT NULL "PROMISSORY_ID",
                                      NULL "HOLDER_BILL",
                                      NULL "DEBTORNAME",
                                      NULL "IDENTIFICATION",
                                      NULL "FORWARDINGPLACE",
                                      NULL "FORWARDINGDATE",
                                      NULL "GENDER",
                                      NULL "CIVIL_STATE_ID",
                                      NULL "BIRTHDAYDATE",
                                      NULL "SCHOOL_DEGREE_",
                                      NULL "PROPERTYPHONE_ID",
                                      NULL "DEPENDENTSNUMBER",
                                      NULL "HOUSINGTYPE",
                                      NULL "HOUSINGMONTH",
                                      NULL "HOLDERRELATION",
                                      NULL "OCCUPATION",
                                      NULL "COMPANYNAME",
                                      NULL "COMPANYADDRESS_ID",
                                      NULL "PHONE1_ID",
                                      NULL "MOVILPHONE_ID",
                                      NULL "OLDLABOR",
                                      NULL "ACTIVITY",
                                      NULL "MONTHLYINCOME",
                                      NULL "EXPENSESINCOME",
                                      NULL "COMMERREFERENCE",
                                      NULL "PHONECOMMREFE",
                                      NULL "MOVILPHOCOMMREFE",
                                      NULL "ADDRESSCOMMREFE",
                                      NULL "FAMILIARREFERENCE",
                                      NULL "PHONEFAMIREFE",
                                      NULL "MOVILPHOFAMIREFE",
                                      NULL "ADDRESSFAMIREFE",
                                      NULL "PERSONALREFERENCE",
                                      NULL "PHONEPERSREFE",
                                      NULL "MOVILPHOPERSREFE",
                                      NULL "ADDRESSPERSREFE",
                                      NULL "EMAIL",
                                      NULL "PACKAGE_ID",
                                      NULL "PROMISSORY_TYPE",
                                      NULL "IDENT_TYPE_ID",
                                      NULL "CONTRACT_TYPE_ID",
                                      NULL "CATEGORY_ID",
                                      NULL "SUBCATEGORY_ID",
                                      NULL "PHONE2_ID",
                                      NULL "ADDRESS_ID",
                                      NULL "LAST_NAME",
                                      ''' || nuVentasCodeudor ||''' "VENTAS_ASOCIADAS",
                                      ''' || sbRollover_Y_N ||''' "ROLLOVER"
                                      FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbCursorCSql '||sbCursorCSql, csbNivelTraza);

        OPEN ocuInfoCoDeudor FOR sbCursorCSql;

      ELSE

        sbCursorDSql := UPPER('SELECT '''
                                || v_DeudorCodeudor.PROMISSORY_ID       ||''' "PROMISSORY_ID", '''
                                || v_DeudorCodeudor.HOLDER_BILL         ||''' "HOLDER_BILL",  '''
                                || v_DeudorCodeudor.DEBTORNAME          ||''' "DEBTORNAME", '''
                                || v_DeudorCodeudor.IDENTIFICATION      ||''' "IDENTIFICATION", '''
                                || v_DeudorCodeudor.FORWARDINGPLACE     ||''' "FORWARDINGPLACE", '''
                                || v_DeudorCodeudor.FORWARDINGDATE      ||''' "FORWARDINGDATE", '''
                                || v_DeudorCodeudor.GENDER              ||''' "GENDER", '''
                                || v_DeudorCodeudor.CIVIL_STATE_ID      ||''' "CIVIL_STATE_ID", '''
                                || v_DeudorCodeudor.BIRTHDAYDATE        ||''' "BIRTHDAYDATE", '''
                                || v_DeudorCodeudor.SCHOOL_DEGREE_      ||''' "SCHOOL_DEGREE_", '''
                                || v_DeudorCodeudor.PROPERTYPHONE_ID    ||''' "PROPERTYPHONE_ID", '''
                                || v_DeudorCodeudor.DEPENDENTSNUMBER    ||''' "DEPENDENTSNUMBER", '''
                                || v_DeudorCodeudor.HOUSINGTYPE         ||''' "HOUSINGTYPE", '''
                                || v_DeudorCodeudor.HOUSINGMONTH        ||''' "HOUSINGMONTH", '''
                                || v_DeudorCodeudor.HOLDERRELATION      ||''' "HOLDERRELATION", '''
                                || v_DeudorCodeudor.OCCUPATION          ||''' "OCCUPATION", '''
                                || v_DeudorCodeudor.COMPANYNAME         ||''' "COMPANYNAME", '''
                                || v_DeudorCodeudor.COMPANYADDRESS_ID   ||''' "COMPANYADDRESS_ID", '''
                                || v_DeudorCodeudor.PHONE1_ID           ||''' "PHONE1_ID", '''
                                || v_DeudorCodeudor.MOVILPHONE_ID       ||''' "MOVILPHONE_ID", '''
                                || v_DeudorCodeudor.OLDLABOR            ||''' "OLDLABOR", '''
                                || v_DeudorCodeudor.ACTIVITY            ||''' "ACTIVITY", '''
                                || v_DeudorCodeudor.MONTHLYINCOME       ||''' "MONTHLYINCOME", '''
                                || v_DeudorCodeudor.EXPENSESINCOME      ||''' "EXPENSESINCOME", '''
                                || v_DeudorCodeudor.COMMERREFERENCE     ||''' "COMMERREFERENCE", '''
                                || v_DeudorCodeudor.PHONECOMMREFE       ||''' "PHONECOMMREFE", '''
                                || v_DeudorCodeudor.MOVILPHOCOMMREFE    ||''' "MOVILPHOCOMMREFE", '''
                                || v_DeudorCodeudor.ADDRESSCOMMREFE     ||''' "ADDRESSCOMMREFE", '''
                                || v_DeudorCodeudor.FAMILIARREFERENCE   ||''' "FAMILIARREFERENCE", '''
                                || v_DeudorCodeudor.PHONEFAMIREFE       ||''' "PHONEFAMIREFE", '''
                                || v_DeudorCodeudor.MOVILPHOCOMMREFE    ||''' "MOVILPHOFAMIREFE", '''
                                || v_DeudorCodeudor.ADDRESSCOMMREFE     ||''' "ADDRESSFAMIREFE", '''
                                || v_DeudorCodeudor.PERSONALREFERENCE   ||''' "PERSONALREFERENCE", '''
                                || v_DeudorCodeudor.PHONEPERSREFE       ||''' "PHONEPERSREFE", '''
                                || v_DeudorCodeudor.MOVILPHOPERSREFE    ||''' "MOVILPHOPERSREFE", '''
                                || v_DeudorCodeudor.ADDRESSPERSREFE     ||''' "ADDRESSPERSREFE", '''
                                || v_DeudorCodeudor.EMAIL               ||''' "EMAIL", '''
                                || v_DeudorCodeudor.PACKAGE_ID          ||''' "PACKAGE_ID", '''
                                || v_DeudorCodeudor.PROMISSORY_TYPE     ||''' "PROMISSORY_TYPE", '''
                                || v_DeudorCodeudor.PROMISSORY_TYPE     ||''' "IDENT_TYPE_ID", '''
                                || v_DeudorCodeudor.CONTRACT_TYPE_ID    ||''' "CONTRACT_TYPE_ID", '''
                                || v_DeudorCodeudor.CATEGORY_ID         ||''' "CATEGORY_ID", '''
                                || v_DeudorCodeudor.SUBCATEGORY_ID      ||''' "SUBCATEGORY_ID", '''
                                || v_DeudorCodeudor.PHONE2_ID           ||''' "PHONE2_ID", '''
                                || v_DeudorCodeudor.ADDRESS_ID          ||''' "ADDRESS_ID", '''
                                || v_DeudorCodeudor.LAST_NAME           ||''' "LAST_NAME", '''
                                || nuVentasCodeudor                     ||''' "VENTAS_ASOCIADAS", '''
                                || sbRollover_Y_N                       ||''' "ROLLOVER"
                           FROM DUAL');

        pkg_traza.trace(csbMetodo||' sbCursorDSql '||sbCursorDSql, csbNivelTraza);

        OPEN ocuInfoCoDeudor FOR sbCursorDSql;

      END IF;

    pkg_traza.trace(csbMetodo||' Termina validando codeudor rollover ', csbNivelTraza);

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo informacion del codeudor');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    --------------------------------------------------------------------------------------------
    ----------------------------> INFORMACION ADICIONAL A LA VENTA <----------------------------
    --------------------------------------------------------------------------------------------
    ---------------------------
    -- Venta Mantenimiento. -->
    ---------------------------
    nuCodValidacion := 13;

    sbNombreValidacion := 'Valida si aplica para Venta Mantenimiento';

    pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza);

    BEGIN

      nuVentaMant := LDC_PKVENTAFNB.FNUPROVEEDORVENTAMATERIALES(inuCodProve);

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error verificando aplicacion para venta de mantenimiento');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;


    IF nuVentaMant = 1 THEN

      sbResult       := 'Y';
      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbResult || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');


      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

    ELSE

      sbResult       := 'N';
      sbPermiteVenta := 'S';
      sbMensaje      := 'Proveedor [' || inuCodProve || '] NO Aplica para venta de mantenimiento';

    END IF;

    pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza);

    --Valida si permite vender seguro voluntario.

    BEGIN

      pkg_traza.trace(csbMetodo||' - Validando seguro voluntario', csbNivelTraza);

      nuVentaSeguro := LDC_PKVENTASEGUROVOLUNTARIO.FNUEXISTESEGUROVOLUNTARIO(inuSuscripc);

      pkg_traza.trace(csbMetodo||' Termina Validando seguro voluntario', csbNivelTraza);
    EXCEPTION
      WHEN OTHERS THEN
        nuVentaSeguro   := -1;
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error validando seguro voluntario');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    IF nuVentaSeguro = 0 THEN

      sbBoolean := 'Y';

    ELSE

      sbBoolean := 'N';

      nuCodValidacion := 14;

      sbNombreValidacion := 'Valida si permite vender seguro voluntario Y/N';

      pkg_traza.trace(csbMetodo||' - '||sbNombreValidacion, csbNivelTraza);

      sbPermiteVenta := 'S';
      sbMensaje      := '' || sbBoolean || '';

      IF SbFlagUnion = 'Y' THEN
        SbUnion := 'UNION';
      ELSE
        SbUnion := null;
      END IF;

      sbSql := UPPER(sbSql || chr(10) || SbUnion || chr(10)
                           || 'SELECT '''
                           || nuCodValidacion       || ''' CODCONDICION, '''
                           || sbNombreValidacion    || ''' NOMBRECONDICION, '''
                           || sbPermiteVenta        || ''' PERMITEVENTA, '''
                           || sbMensaje             || ''' MENSAJE FROM DUAL');

      pkg_traza.trace(csbMetodo||' sbSql: '||sbSql, csbNivelTraza);

      OPEN cuCursor FOR sbSql;

      ocuValida := cuCursor;

      SbFlagUnion := 'Y';

      pkg_traza.trace(csbMetodo||' Termina '||sbNombreValidacion, csbNivelTraza);

    END IF;

    --------------------------
    -- N Ultimas Facturas. -->
    --------------------------
    BEGIN

      pkg_traza.trace(csbMetodo||' - Valida ultimas facturas', csbNivelTraza);

      PRgetFACTURA(inuSuscripc, ocuInfoFactura);

      prcCierraCursor(ocuInfoFactura);

      pkg_traza.trace(csbMetodo||' - Termina valida ultimas facturas', csbNivelTraza);

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo ultimas facturas');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    ------------------
    -- Cupo extra. -->
    ------------------
    BEGIN

      pkg_traza.trace(csbMetodo||' - Valida CupoExtra ', csbNivelTraza);

      SbSQL          := NULL;
      cuCursorCupoEx := ld_bononbankfinancing.frfgetExtraQuoteBySubs(inuSuscripc);

      sbExistCupoExtra := 'N';

      LOOP
        FETCH cuCursorCupoEx BULK COLLECT
         INTO v_CupoExtra LIMIT 10;

        nuNextCupo := v_CupoExtra.first;

        WHILE (nuNextCupo IS NOT NULL) LOOP

          IF v_CupoExtra(nuNextCupo).EXTRAQUOTE_ID IS NULL THEN
            sbExistCupoExtra := 'N';
          ELSE
            sbExistCupoExtra := 'Y';
            IF SbSQL IS NULL THEN
              SbSQL := UPPER('SELECT ''' || v_CupoExtra(nuNextCupo).SBLINE          || ''' "LINEA",
                                     ''' || v_CupoExtra(nuNextCupo).SBSUBLINE       || ''' "SUBLINEA",
                                     ''' || v_CupoExtra(nuNextCupo).SBSUPPLIER      || ''' "SUPPLIER",
                                     ''' || v_CupoExtra(nuNextCupo).SBSALE_CHANEL   || ''' "CANAL_VENTA",
                                     ''' || v_CupoExtra(nuNextCupo).EXQUOTE         || ''' "CUPO_EXTRA",
                                     ''' || v_CupoExtra(nuNextCupo).INITIAL_DATE    || ''' "FECHA_INICIALVIGENCIA",
                                     ''' || v_CupoExtra(nuNextCupo).FINAL_DATE      || ''' "FECHA_FINVIGENCIA",
                                     ''' || v_CupoExtra(nuNextCupo).EXTRAQUOTE_ID   || ''' "ID_EXTRACUOTA"
                                   FROM DUAL');
            ELSE
              SbSQL := UPPER(SbSQL || chr(10) || 'UNION' || chr(10) ||
                             'SELECT ''' || v_CupoExtra(nuNextCupo).SBLINE          || ''' "LINEA",
                                     ''' || v_CupoExtra(nuNextCupo).SBSUBLINE       || ''' "SUBLINEA",
                                     ''' || v_CupoExtra(nuNextCupo).SBSUPPLIER      || ''' "SUPPLIER",
                                     ''' || v_CupoExtra(nuNextCupo).SBSALE_CHANEL   || ''' "CANAL_VENTA",
                                     ''' || v_CupoExtra(nuNextCupo).EXQUOTE         || ''' "CUPO_EXTRA",
                                     ''' || v_CupoExtra(nuNextCupo).INITIAL_DATE    || ''' "FECHA_INICIALVIGENCIA",
                                     ''' || v_CupoExtra(nuNextCupo).FINAL_DATE      || ''' "FECHA_FINVIGENCIA",
                                     ''' || v_CupoExtra(nuNextCupo).EXTRAQUOTE_ID   || ''' "ID_EXTRACUOTA"
                               FROM DUAL');
            END IF;

            pkg_traza.trace(csbMetodo||' SbSQL: '||SbSQL, csbNivelTraza);

          END IF;

          nuNextCupo := v_CupoExtra.next(nuNextCupo);

        END LOOP;

        EXIT WHEN cuCursorCupoEx%NOTFOUND;

      END LOOP;

      CLOSE cuCursorCupoEx;

      IF sbExistCupoExtra = 'N' THEN
        IF SbSQL IS NULL THEN
          SbSQL := 'SELECT NULL "LINEA",
                           NULL "SUBLINEA",
                           NULL "SUPPLIER",
                           NULL "CANAL_VENTA",
                           NULL "CUPO_EXTRA",
                           NULL "FECHA_INICIALVIGENCIA",
                           NULL "FECHA_FINVIGENCIA",
                           NULL "ID_EXTRACUOTA"
                           FROM DUAL';
          pkg_traza.trace(csbMetodo||' SbSQL: '||SbSQL, csbNivelTraza);
        END IF;
      END IF;

      OPEN ocuCupoExtra FOR sbSql;

      pkg_traza.trace(csbMetodo||' - Termina CupoExtra ', csbNivelTraza);

    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error obteniendo cupo extra');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    ------------------*********************************************************-----------------
    --************************************ FIN LOGICA ****************************************--
    ------------------*********************************************************-----------------
    BEGIN

      pkg_traza.trace(csbMetodo||' - Validando informacion en el servicio principal', csbNivelTraza);

      sbDesbloqueo := prReleaseSubscription(inuSuscripc);
      IF sbDesbloqueo = FALSE THEN

        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error al liberar contrato');
        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCode    := -1;
        osbErrorMessage := UPPER('Error al liberar contrato');
        /*Cerrar Cursores*/
        prcCierraCursor(ocuValida);
        prcCierraCursor(ocuInfoSuscripc);
        prcCierraCursor(ocuInfoDeudor);
        prcCierraCursor(ocuInfoCoDeudor);
        prcCierraCursor(ocuInfoFactura);
        prcCierraCursor(ocuCupoExtra);

        pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

        RETURN;
    END;

    onuErrorCode    := 0;
    osbErrorMessage := UPPER('Proceso Ok');

    /*Cerrar Cursores*/
    prcCierraCursor(ocuValida);
    prcCierraCursor(ocuInfoSuscripc);
    prcCierraCursor(ocuInfoDeudor);
    prcCierraCursor(ocuInfoCoDeudor);
    prcCierraCursor(ocuInfoFactura);
    prcCierraCursor(ocuCupoExtra);

    pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    RETURN;

  EXCEPTION
    WHEN OTHERS THEN
      onuErrorCode    := -1;
      osbErrorMessage := UPPER('Error validando informacion en el servicio principal');
      /*Cerrar Cursores*/
      prcCierraCursor(ocuValida);
      prcCierraCursor(ocuInfoSuscripc);
      prcCierraCursor(ocuInfoDeudor);
      prcCierraCursor(ocuInfoCoDeudor);
      prcCierraCursor(ocuInfoFactura);
      prcCierraCursor(ocuCupoExtra);

      pkg_traza.trace(csbMetodo||' osbErrorMessage: '||osbErrorMessage, csbNivelTraza);

  end diligenciamiento_venta;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : ldci_proTempConsultaBrilla
  Descripcion    : Servicio para recibir un XML con los datos.
                   de aqui se llama al servicio DILIGENCIAMIENTO_VENTA
                   (Este servicio es el llamado desde el Web Services)
  Autor          : Sebastian Tapias
  Fecha          : 01/02/2018
  REQ            : 200-1511

  Fecha             Autor                Modificacion
  =========       =========             ====================
  17/10/2023        Adrianavg            OSF-1687 Se añade uso del PKG_TRAZA.
                                         Se reemplaza SELECT-INTO por cursor cuDatos. Se añade inicializacion de variables que
                                         manejan el error con pkg_error.prInicializaError. Se colocan palabras clave en mayúsculas
                                         Se retira nombre de esquema OPEN.
  ******************************************************************/
  PROCEDURE proconsultabrilla(ISBXML          IN CLOB,
                              OCUCONDICIONES  OUT SYS_REFCURSOR,
                              OCUINFOSUSCRIPC OUT SYS_REFCURSOR,
                              OCUINFODEUDOR   OUT SYS_REFCURSOR,
                              OCUINFOCODEUDOR OUT SYS_REFCURSOR,
                              OCUINFOFACTURA  OUT SYS_REFCURSOR,
                              OCUCUPOEXTRA    OUT SYS_REFCURSOR,
                              ----
                              OCUCAMPANAFNB OUT SYS_REFCURSOR,
                              ----
                              ONUERRORCODE    OUT NUMBER,
                              OSBERRORMESSAGE OUT VARCHAR2) IS

    contrato               NUMBER;
    tipoIdentificacion     NUMBER;
    identificacion         VARCHAR2(20);
    tipoIdentifCodeudor    NUMBER;
    identificacionCodeudor VARCHAR2(20);
    idProveedor            NUMBER;

    ---
    sbSqlCampanaFNB varchar2(4000);
    ----

    CURSOR cuDatos
    is
    SELECT x.*
      into contrato,
           tipoIdentificacion,
           identificacion,
           tipoIdentifCodeudor,
           identificacionCodeudor,
           idProveedor
      FROM (select xmltype(ISBXML) data from dual) t,
           XMLTABLE(dald_parameter.fsbgetvalue_chain('TAG_PORTAL_BRILLA')
                    PASSING t.data
                    COLUMNS
                    contrato NUMBER                     PATH 'contrato',
                    tipoIdentificacion NUMBER           PATH 'tipoIdentificacion',
                    identificacion VARCHAR2(20)         PATH 'identificacion',
                    tipoIdentifCodeudor NUMBER          PATH 'tipoIdentifCodeudor',
                    identificacionCodeudor VARCHAR2(20) PATH 'identificacionCodeudor',
                    idProveedor NUMBER                  PATH 'idProveedor') x;

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'proconsultabrilla';

  BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

        pkg_error.prinicializaerror(onuerrorcode, osberrormessage);

     OPEN cuDatos;
    FETCH cuDatos
     INTO contrato,
          tipoIdentificacion,
          identificacion,
          tipoIdentifCodeudor,
          identificacionCodeudor,
          idProveedor;
    CLOSE cuDatos;

    DILIGENCIAMIENTO_VENTA(contrato,
                           tipoIdentificacion,
                           identificacion,
                           tipoIdentifCodeudor,
                           identificacionCodeudor,
                           idProveedor,
                           OCUCONDICIONES,
                           OCUINFOSUSCRIPC,
                           OCUINFODEUDOR,
                           OCUINFOCODEUDOR,
                           OCUINFOFACTURA,
                           OCUCUPOEXTRA,
                           ONUERRORCODE,
                           OSBERRORMESSAGE);

    BEGIN
      sbSqlCampanaFNB := 'select lc.line_id LINEA,
                                 lc.pldicodi PLANDIFE,
                                 (select pd.pldicumi
                                    from plandife pd
                                   where pd.pldicodi = lc.pldicodi
                                     and rownum = 1) CUMI,
                                 (select pd.pldicuma
                                    from plandife pd
                                   where pd.pldicodi = lc.pldicodi
                                     and rownum = 1) CUMA,
                                 lc.id_contratista SUPPLIER,
                                 lc.geograp_location_id GEO_ID,
                                 lc.confcampfnb_montominimo MONTO_MINIMO,
                                 lc.confcampfnb_fecini FECHA_INICIALVIGENCIA,
                                 lc.confcampfnb_fecfin FECHA_FINALVIGENCIA,
                                 nvl(dald_line.fsbGetDescription(lc.line_id, null),''TODOS'') DESC_LINEA,
                                 nvl(daGE_CONTRATISTA.Fsbgetdescripcion(lc.id_contratista, null),''TODOS'') DESC_SUPPLIER,
                                 nvl(daGE_GEOGRA_LOCATION.Fsbgetdescription(lc.geograp_location_id, null),''TODOS'') DESC_GEO
                            from ldc_confcampfnb lc
                           where nvl(lc.id_contratista, ' || idProveedor || ') = ' || idProveedor ||
                            'and (
                                    (select count(a.geograp_location_id)
                                       from ge_geogra_location a, ab_address b, suscripc c
                                      where a.geograp_location_id = b.geograp_location_id
                                        and b.address_id = c.susciddi
                                        and c.susccodi = ' || contrato ||
                                      ' and (a.geograp_location_id = decode(nvl(lc.geograp_location_id, -1), -1, a.geograp_location_id, lc.geograp_location_id)
                                         or  a.geo_loca_father_id =  decode(nvl(lc.geograp_location_id, -1), -1, a.geograp_location_id,  lc.geograp_location_id))
                                       ) > 0)
                             and (trunc(sysdate) >= trunc(lc.confcampfnb_fecini)
                             and  trunc(sysdate) <= trunc(lc.confcampfnb_fecfin))';

      pkg_traza.trace(csbMetodo||' sbSqlCampanaFNB:'||sbSqlCampanaFNB, csbNivelTraza);

      OPEN OCUCAMPANAFNB FOR sbSqlCampanaFNB;
    EXCEPTION
      WHEN OTHERS THEN
        ONUERRORCODE := 1;
    END;

    IF ONUERRORCODE = 0 THEN

      ONUERRORCODE    := 0;
      OSBERRORMESSAGE := UPPER('Proceso Ok');
      pkg_traza.trace(csbMetodo||' osberrormessage: '||OSBERRORMESSAGE, csbNivelTraza);
      /*Cerrar Cursores*/
      prcCierraCursor(OCUCONDICIONES);
      prcCierraCursor(OCUINFOSUSCRIPC);
      prcCierraCursor(OCUINFODEUDOR);
      prcCierraCursor(OCUINFOCODEUDOR);
      prcCierraCursor(OCUINFOFACTURA);
      prcCierraCursor(OCUCUPOEXTRA);
      --CASO 2422
      prcCierraCursor(OCUCAMPANAFNB);
      --CASO 2422
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error al consultar informacion ') || sqlerrm;
      pkg_traza.trace(csbMetodo||' - '||onuErrorCode||' - '||osbErrorMessage,  csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setErrorMessage(onuErrorCode, osbErrorMessage);
      pkg_error.geterror(onuErrorCode,osbErrorMessage);
      /*Cerrar Cursores*/
      prcCierraCursor(OCUCONDICIONES);
      prcCierraCursor(OCUINFOSUSCRIPC);
      prcCierraCursor(OCUINFODEUDOR);
      prcCierraCursor(OCUINFOCODEUDOR);
      prcCierraCursor(OCUINFOFACTURA);
      prcCierraCursor(OCUCUPOEXTRA);
      --CASO 2422
      prcCierraCursor(OCUCAMPANAFNB);
      --CASO 2422

  END proconsultabrilla;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : proconsultarespventas
  Descripcion    : Servicio para consultar el resultado del registro
                   de una o m?s ventas Brilla
  Autor          : Eduardo Ag?era
  Fecha          : 04/10/2018
  REQ            : 200-2027

  Fecha             Autor                Modificacion
  =========       =========             ====================
  17/10/2023        Adrianavg            OSF-1687 Se añade uso del PKG_TRAZA.
                                         Se añade inicializacion de variables que manejan el error
                                         con pkg_error.prInicializaError y uso del pkg_error.
                                         Se colocan palabras clave en mayúsculas
  ******************************************************************/
  PROCEDURE proconsultarespventas(ISBXML          IN CLOB,
                                  OCURESPUESTAS   OUT SYS_REFCURSOR,
                                  ONUERRORCODE    OUT NUMBER,
                                  OSBERRORMESSAGE OUT VARCHAR2) IS

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'proconsultarespventas';
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

    pkg_error.prinicializaerror(onuerrorcode, osberrormessage );

    OPEN OCURESPUESTAS FOR
      select d.id_externo, v.parametro_id, v.valor
        from ldci_outboxdet d, ldci_outboxdetval v
       where sistema = 'BRILLA'
         and operacion = 'VENTA'
         and v.outboxdet_id = d.codigo
         and id_externo in
             (Select Datos.idVenta
                From XMLTable('ventas/venta' Passing XMLType(ISBXML) Columns
                              idVenta Number Path 'idVenta') As Datos);

    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'Proceso Ejecutado correctamente';

    pkg_traza.trace(csbMetodo||' osberrormessage: '||OSBERRORMESSAGE, csbNivelTraza);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error al consultar informacion ') || sqlerrm;
      /*Cerrar Cursores*/
      prcCierraCursor(OCURESPUESTAS);
      pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);

  END proconsultarespventas;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : PRgetFACTURA
  Descripcion    : Devuelve facturas a sociada a un suscriptor.
  Autor          : Samuel Pacheco
  Fecha          : 01/02/2018
  REQ            : 200-1511

  Parametros              Descripcion
  ============         ===================
  inususcripc        Identificador del contrato.

  RETORNA
  styCursorOut          Cursor con consulta de FACTURAS (segun valor del parametro).

  Fecha             Autor                Modificacion
  =========       =========             ====================
                  Samuel Pacheci        CASO 200-2362
  17/10/2023      Adrianavg             OSF-1687 Se añade uso del PKG_TRAZA.Se retira código
                                        comentariado. Se retira la exception EX.CONTROLLED_ERROR
                                        no se usa al interior del procedure, para cualquier otro error se deja
                                        la exception WHEN OTHERS. En la exception se añade pkg_error.setError y
                                        pkg_error.geterror. Se colocan palabras clave en mayúsculas
  ******************************************************************/
  PROCEDURE prgetfactura(inususcripc in suscripc.susccodi%type,
                         ocuFACTURA  out constants.tyrefcursor) is

    sbSelect varchar2(500);
    sbWhere  varchar2(500);
    SbSQL    varchar2(500);

    vnuFACT ld_parameter.numeric_value%type := DALD_PARAMETER.fnuGetNumeric_Value('NUME_MEEV_FVB');

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'prgetfactura';

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

    pkg_traza.trace(csbMetodo||' inususcripc: '||inususcripc, csbNivelTraza);

    pkg_error.prinicializaerror(nuErrorCode,sbErrorMessage );

    --ARMA CADENA A CONSULTAR
    sbSelect := 'select * from (select factcodi, factsusc, factpefa, factvaap, factfege from factura where factsusc = ' ||
                TO_CHAR(inususcripc);

    sbWhere := ' order by factcodi desc) where (abs(months_between(factfege, sysdate))) < = ' ||  TO_CHAR(vnuFACT);

    SbSQL := UPPER(sbSelect || sbWhere);

    pkg_traza.trace(csbMetodo||' SbSQL: '||SbSQL, csbNivelTraza);

    OPEN ocuFACTURA FOR sbSql;
    /*Cerrar Cursores*/
    prcCierraCursor(ocuFACTURA);
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN;

  EXCEPTION
    WHEN OTHERS THEN
      /*Cerrar Cursores*/
      prcCierraCursor(ocuFACTURA);
      pkg_error.setError;
      pkg_error.geterror(nuErrorCode,sbErrorMessage);
      pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage, csbNivelTraza, pkg_traza.csbFIN_ERR);
      RAISE PKG_ERROR.CONTROLLED_ERROR;
  END prgetfactura;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : legaliza_venta
  Descripcion    :
  Autor          :
  Fecha          :
  REQ            :

  Parametros              Descripcion
  ============         ===================
  INUORDERID           Nro de Orden
  ISBFACTURA           ??
  ISBCOMMENT           Comentario

  RETORNA
  ONUERRORCODE          Código de error
  OSBERRORMESSAGE       Mnesaje de error

  Fecha             Autor                Modificacion
  =========       =========             ====================
  17/10/2023      Adrianavg             OSF-1687 Se añade encabezado para indicar info del método
                                        Se añade uso del PKG_TRAZA.
                                        Se reemplaza EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR.
                                        Se reemplaza or_boconstants.cnuORDER_STAT_ASSIGNED por PKG_GESTIONORDENES.CNUORDENASIGNADA
  ******************************************************************/
  PROCEDURE legaliza_venta(INUORDERID      IN NUMBER, --NUMBER(15)
                           ISBFACTURA      IN VARCHAR2, --VARCHAR2(50)
                           ISBCOMMENT      IN VARCHAR2, --VARCHAR2(2000)
                           ONUERRORCODE    OUT NUMBER,
                           OSBERRORMESSAGE OUT VARCHAR2) IS



    /******* VARIABLES *******/
    nuValueExito    ld_parameter.parameter_id%type;
    nuValueOlimpica ld_parameter.parameter_id%type;

    --Estado Entregado de la actividad
    csbEntregado  constant varchar2(3) := 'RE';
    csbFinalizada constant varchar2(3) := 'F';

    /*Actividad de entrega articulos Brilla*/
    cnuDelivActiv constant ld_parameter.numeric_value%type := ld_boconstans.cnuAct_Type_Del_FNB;

    /* Variable para sacar el servicio de la consulta. */
    CNUORDER_STAT_ASSIGNED CONSTANT OR_ORDER_STATUS.ORDER_STATUS_ID%TYPE := PKG_GESTIONORDENES.CNUORDENASIGNADA;

    NUCAUSAL ge_causal.causal_id%TYPE := 9724;
    SBACT    VARCHAR2(32000);
    SBCAD    VARCHAR2(32000);
    nuCount  NUMBER := 0;

    /******* CURSORES *******/

    CURSOR cu_actividades(inuorder         or_order.order_id%TYPE,
                          inuValueExito    ld_parameter.parameter_id%TYPE,
                          inuValueOlimpica ld_parameter.parameter_id%TYPE,
                          isbEntregado     VARCHAR2,
                          isbFinalizada    VARCHAR2,
                          inuactivity      NUMBER,
                          inustatus        NUMBER) IS
      SELECT oa.order_activity_id
        FROM ld_item_work_order l,
             or_order_activity  oa,
             mo_packages        p,
             or_order           o,
             or_order_status    os
       WHERE oa.order_activity_id = l.order_activity_id
         AND p.package_id = oa.package_id
         AND o.order_id = oa.order_id
         AND os.order_status_id = o.order_status_id
         AND l.supplier_id NOT IN (inuValueExito, inuValueOlimpica)
         AND l.state IN (isbEntregado)
         AND l.difecodi IS NULL
         AND oa.activity_id = inuactivity
         AND oa.status <> isbFinalizada
         AND o.order_status_id = inustatus
         AND oa.order_id = inuorder
       ORDER BY oa.order_id, oa.order_activity_id;

    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'legaliza_venta';

  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

    pkg_error.prinicializaerror(ONUERRORCODE, OSBERRORMESSAGE );
    --------------------------------------------------------------------------------------------
    ----------------------------------> VALIDACION DE CAMPOS <----------------------------------
    --------------------------------------------------------------------------------------------
    IF INUORDERID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INUORDERID] NO PUEDE SER NULO.');
      pkg_traza.trace(csbMetodo||' Osberrormessage '||Osberrormessage, csbNivelTraza, pkg_traza.csbFIN);
      RETURN;
    END IF;
    IF ISBFACTURA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ISBFACTURA] NO PUEDE SER NULO.');
      pkg_traza.trace(csbMetodo||' Osberrormessage '||Osberrormessage, csbNivelTraza, pkg_traza.csbFIN);
      RETURN;
    END IF;
    --------------------------------------------------------------------------------------------
    -----------------------------------> LOGICA PRINCIPAL <-------------------------------------
    --------------------------------------------------------------------------------------------

    nuValueExito    := Dald_Parameter.fnuGetNumeric_Value('COD_EXITO_FLOTE');
    nuValueOlimpica := Dald_Parameter.fnuGetNumeric_Value('COD_OLIMPICA_FLOTE');

    pkg_traza.trace(csbMetodo||' Inuorderid:'       ||INUORDERID
                             ||' nuValueExito:'     ||nuValueExito
                             ||' nuValueOlimpica:'  ||nuValueOlimpica
                             ||' csbEntregado:'     ||csbEntregado
                             ||' csbFinalizada:'    ||csbFinalizada
                             ||' cnuDelivActiv:'    ||cnuDelivActiv
                             ||' Cnuorder_Stat_Assigned:'||CNUORDER_STAT_ASSIGNED, csbNivelTraza);

    FOR i IN cu_actividades(INUORDERID,
                            nuValueExito,
                            nuValueOlimpica,
                            csbEntregado,
                            csbFinalizada,
                            cnuDelivActiv,
                            CNUORDER_STAT_ASSIGNED) LOOP
      nuCount := nuCount + 1;
      SBACT   := i.order_activity_id || ',1';
      IF nuCount > 1 THEN
        SBCAD := SBCAD || '|' || SBACT;
      ELSE
        SBCAD := SBACT;
      END IF;
    END LOOP;

    pkg_traza.trace(csbMetodo||' SBCAD:'||SBCAD, csbNivelTraza);

    /******************************************/
    -- LEGALIZACION DE LA VENTA.
    BEGIN
      pkg_traza.trace(csbMetodo||' - Legalizando venta', csbNivelTraza);

      LD_BOFLOWFNBPACK.LEGDELORDER(INUORDERID, NUCAUSAL, SBCAD);

      pkg_traza.trace(csbMetodo||' Termina Legalizando venta', csbNivelTraza);
    EXCEPTION
      WHEN OTHERS THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('Error legalizando venta');
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    END;

    /******************************************/
    -- ADICIONAR COMENTARIO.
    IF ISBCOMMENT IS NOT NULL THEN

      pkg_traza.trace(csbMetodo||' - Adicionar comentario', csbNivelTraza);

      BEGIN
        LD_BOFLOWFNBPACK.COMMENTDELORDER(INUORDERID, ISBCOMMENT);

        pkg_traza.trace(csbMetodo||' Termina Adicionar comentario', csbNivelTraza);

      EXCEPTION
        WHEN OTHERS THEN
          ONUERRORCODE    := -1;
          OSBERRORMESSAGE := UPPER('Error legalizando venta');
          RAISE PKG_ERROR.CONTROLLED_ERROR;
      END;
    END IF;

    /******************************************/
    -- ADICIONAR NUMERO DE FACTURA.
    BEGIN
      pkg_traza.trace(csbMetodo||' - Adicionar numero de factura', csbNivelTraza);

      LD_BOFLOWFNBPACK.REGISTERINVOICE(INUORDERID, ISBFACTURA);

      pkg_traza.trace(csbMetodo||' Termina Adicionar numero de factura', csbNivelTraza);

    EXCEPTION
      WHEN OTHERS THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('Error legalizando venta');
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    END;

    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := UPPER('OK');

    pkg_traza.trace(csbMetodo||' Osberrormessage '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      ROLLBACK;
      pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
    WHEN OTHERS THEN
      ROLLBACK;
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error general');
      pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
      RAISE PKG_ERROR.CONTROLLED_ERROR;
  END legaliza_venta;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : legaliza_documentos
  Descripcion    :
  Autor          :
  Fecha          :
  REQ            :

  Parametros              Descripcion
  ============         ===================
  INUORDERID           Nro de Orden
  INUOPERATING         Area operativa
  INUCODESTLEY         Codigo estado de Ley
  ISBACTUALIZADATOS    Indicador de actualizacion de datos

  RETORNA
  ONUERRORCODE          Código de error
  OSBERRORMESSAGE       Mnesaje de error

  Fecha             Autor                Modificacion
  =========       =========             ====================
  17/10/2023      Adrianavg             OSF-1687 Se añade encabezado para indicar info del método
                                        Se añade uso del PKG_TRAZA.
                                        Se reemplaza EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR.
                                        Se reemplaza DAOR_ORDER.FNUGETORDER_STATUS_ID por PKG_BCORDENES.FNUOBTIENEESTADO
                                        Se reemplaza or_boprocessorder.assign por API_ASSIGN_ORDER.
                                        Se retira rcOrder := Daor_Order.Frcgetrecord(INUORDERID);
                                        Se ajusta lógica para que valide el retorno del API_ASSIGN_ORDER                                        
  ******************************************************************/
  PROCEDURE legaliza_documentos(INUORDERID        IN NUMBER, --NUMBER(15)
                                INUOPERATING      IN NUMBER, --NUMBER(15)
                                INUCODESTLEY      IN LDC_PROTECCION_DATOS.COD_ESTADO_LEY%TYPE,
                                ISBACTUALIZADATOS IN VARCHAR2,
                                ONUERRORCODE      OUT NUMBER,
                                OSBERRORMESSAGE   OUT VARCHAR2) IS

    /******* VARIABLES *******/
    rcOrder daor_order.styor_order;
    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'legaliza_documentos';
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

    pkg_error.prinicializaerror(ONUERRORCODE, OSBERRORMESSAGE );
    --------------------------------------------------------------------------------------------
    ----------------------------------> VALIDACION DE CAMPOS <----------------------------------
    --------------------------------------------------------------------------------------------
    IF INUORDERID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INUORDERID] NO PUEDE SER NULO.');
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_traza.trace(csbMetodo||' Osberrormessage '||Osberrormessage, csbNivelTraza, pkg_traza.csbFIN);
      RETURN;
    END IF;
    IF INUCODESTLEY IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INUCODESTLEY] NO PUEDE SER NULO.');
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_traza.trace(csbMetodo||' Osberrormessage '||Osberrormessage, csbNivelTraza, pkg_traza.csbFIN);
      RETURN;
    END IF;
    IF ISBACTUALIZADATOS IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ISBACTUALIZADATOS] NO PUEDE SER NULO.');
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_traza.trace(csbMetodo||' Osberrormessage '||Osberrormessage, csbNivelTraza, pkg_traza.csbFIN);
      RETURN;
    END IF;
    --------------------------------------------------------------------------------------------
    -----------------------------------> LOGICA PRINCIPAL <-------------------------------------
    --------------------------------------------------------------------------------------------

    -- se asigna la orden si no esta asignada
    IF (PKG_BCORDENES.FNUOBTIENEESTADO(INUORDERID) <> 5) THEN

      IF INUOPERATING IS NULL THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INUOPERATING] NO PUEDE SER NULO.');
        pkg_traza.trace(csbMetodo||' Osberrormessage:'||OSBERRORMESSAGE, csbNivelTraza);
        pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
        pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
        RETURN;
      END IF;

        -- EJECUTA PROCESO DE ASIGNACION
        API_ASSIGN_ORDER(INUORDERID, INUOPERATING,  ONUERRORCODE, OSBERRORMESSAGE);
        
        IF ONUERRORCODE <> 0 THEN --VALIDAR RETORNO DEL API_ASSIGN_ORDER
           RAISE PKG_ERROR.CONTROLLED_ERROR;
        END IF;

    END IF;

    --Legalizacion de la orden
    BEGIN
      prLegalizaOtFnbWeb(INUORDERID,
                         INUCODESTLEY,
                         ISBACTUALIZADATOS,
                         ONUERRORCODE,
                         OSBERRORMESSAGE);
      IF ONUERRORCODE <> 0 THEN
        RAISE PKG_ERROR.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('Error legalizando orden');
        pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERR);
        pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
        pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
        RAISE PKG_ERROR.CONTROLLED_ERROR;
    END;

    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := UPPER('OK');
    pkg_traza.trace(csbMetodo||' Osberrormessage:'||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
      ROLLBACK;
      pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_error.setError;
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
    WHEN OTHERS THEN
      ROLLBACK;
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error general');
      pkg_traza.trace(csbMetodo||' - '||ONUERRORCODE||' - '||OSBERRORMESSAGE, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setErrorMessage(ONUERRORCODE,OSBERRORMESSAGE);
      pkg_error.geterror(ONUERRORCODE,OSBERRORMESSAGE);
      RAISE PKG_ERROR.CONTROLLED_ERROR;
  END legaliza_documentos;

  /*****************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : getIdTypeByPrommisory
  Descripcion    :
  Autor          :
  Fecha          :
  REQ            :

  Parametros              Descripcion
  ============         ===================
  inuTypeId:               Tipo de idenfiticación
  inuIdentification:       Nro idenfiticación
  isbTypeUsuario           Tipo de Usuario: Deudor/Codeudor

  RETORNA

  Fecha             Autor                Modificacion
  =========       =========             ====================
  17/10/2023      Adrianavg             OSF-1687: Se añade encabezado para indicar info del método
                                        Se reemplaza ut_trace.trace por PKG_TRAZA.
                                        Se reemplaza constants.tyRefCursor por constants_per.TYREFCURSOR.
                                        Las palabras claves se colocan en mayúscula. Se retira la exception
                                        EX.CONTROLLED_ERROR por que no se usa o invoca al interior de la lógica
                                        para cualquier otro error queda la exception when others
  ******************************************************************/
  FUNCTION getIdTypeByPrommisory(inuTypeId         in ld_promissory.ident_type_id%type,
                                 inuIdentification in ld_promissory.identification%type,
                                 isbTypeUsuario    in ld_promissory_pu.promissory_type%type)

   return constants_per.TYREFCURSOR

   IS

    rfPrommisory constants_per.TYREFCURSOR;
    csbMetodo CONSTANT VARCHAR(60) := csbNOMPKG||'getIdTypeByPrommisory';

  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

    pkg_error.prinicializaerror(nuErrorCode, sbErrorMessage );

    IF (DALD_PARAMETER.fblexist('MAX_DAYS_FNB')) THEN

      IF ((nvl(dald_parameter.fnuGetNumeric_Value('MAX_DAYS_FNB'), LD_BOConstans.cnuCero) <> LD_BOConstans.cnuCero)) THEN
        OPEN rfPrommisory FOR
          SELECT *
            FROM (SELECT l.promissory_id,
                         l.holder_bill,
                         l.debtorname,
                         l.identification,
                         l.forwardingplace,
                         l.forwardingdate,
                         l.gender,
                         l.civil_state_id,
                         l.birthdaydate,
                         l.school_degree_,
                         l.propertyphone_id,
                         l.dependentsnumber,
                         l.housingtype,
                         l.housingmonth,
                         l.holderrelation,
                         l.occupation,
                         l.companyname,
                         l.companyaddress_id,
                         l.phone1_id,
                         l.movilphone_id,
                         l.oldlabor,
                         l.activity,
                         l.monthlyincome,
                         l.expensesincome,
                         l.commerreference,
                         l.phonecommrefe,
                         l.movilphocommrefe,
                         l.addresscommrefe,
                         l.familiarreference,
                         l.phonefamirefe,
                         l.movilphofamirefe,
                         l.addressfamirefe,
                         l.personalreference,
                         l.phonepersrefe,
                         l.movilphopersrefe,
                         l.addresspersrefe,
                         l.email,
                         l.package_id,
                         l.promissory_type,
                         l.ident_type_id,
                         l.contract_type_id,
                         l.category_id,
                         l.subcategory_id,
                         l.phone2_id,
                         nvl(l.address_id, 0) address_id,
                         l.last_name
                    FROM LD_PROMISSORY L, MO_PACKAGES M
                   WHERE L.PACKAGE_ID = M.PACKAGE_ID
                     AND SYSDATE - M.REQUEST_DATE <=
                         dald_parameter.fnuGetNumeric_Value('MAX_DAYS')
                     AND L.IDENT_TYPE_ID = inuTypeId
                     AND L.IDENTIFICATION = inuIdentification
                     AND l.promissory_type = isbTypeUsuario
                   ORDER BY M.REQUEST_DATE DESC)
           WHERE ROWNUM = 1;

        pkg_traza.trace(csbMetodo||' OK', csbNivelTraza, pkg_traza.csbFIN);
        RETURN(rfPrommisory);
        CLOSE rfPrommisory;
      ELSE
        pkg_traza.trace(csbMetodo||' No cumple MAX_DAYS_FNB <> cnuCero', csbNivelTraza, pkg_traza.csbFIN);
        RETURN NULL;
      END IF;
    ELSE
      pkg_traza.trace(csbMetodo||' No cumple MAX_DAYS_FNB', csbNivelTraza, pkg_traza.csbFIN);
      RETURN NULL;
    END IF;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

  EXCEPTION
    WHEN NO_DATA_FOUND THEN
        pkg_error.setError;
        pkg_error.geterror(nuErrorCode,sbErrorMessage);
        pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage, csbNivelTraza, pkg_traza.csbFIN_ERC);
        --Retorna null si no encuentra registros con los parametros de busqueda
        RETURN NULL;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuErrorCode,sbErrorMessage);
        pkg_traza.trace(csbMetodo||' - '||nuErrorCode||' - '||sbErrorMessage, csbNivelTraza, pkg_traza.csbFIN_ERR);
        RAISE PKG_ERROR.CONTROLLED_ERROR;
  END getIdTypeByPrommisory;

end LDCI_PKCONSULTABRILLA;
/
PROMPT Otorgando permisos de ejecucion a LDCI_PKCONSULTABRILLA
BEGIN
  pkg_utilidades.prAplicarPermisos('LDCI_PKCONSULTABRILLA','ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCONSULTABRILLA TO INTEGRACIONES;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCONSULTABRILLA TO REXEREPORTES;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCONSULTABRILLA TO INTEGRADESA;
/
GRANT EXECUTE ON ADM_PERSON.LDCI_PKCONSULTABRILLA TO REXEINNOVA;
/
