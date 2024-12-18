create or replace package LDCI_PKVENTABRILLA is
  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : LDCI_PKVENTABRILLA
  DESCRIPCION    : PAQUETE PARA AGRUPAR LOS SERVICIOS DEL REGISTRO DE LA VENTA BRILLA
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraVenta
  DESCRIPCION    : Servicio para descerializar xml de venta y realizar venta brilla.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraVenta(isbXML       in CLOB,
                             onuPackage   out NUMBER,
                             onuErrorCodi out NUMBER,
                             osbErrorMsg  out VARCHAR2);

end LDCI_PKVENTABRILLA;
/
create or replace package body LDCI_PKVENTABRILLA is

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : LDCI_PKVENTABRILLA
  DESCRIPCION    : PAQUETE PARA AGRUPAR LOS SERVICIOS DEL REGISTRO DE LA VENTA BRILLA
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/

  --Se crea es tipo de tabla, para manejar la informacion del XML de la venta.
  TYPE t_DatosXml IS RECORD(
    NUCONTRACTID              NUMBER,
    NUCLIENTEID               NUMBER,
    NUCUPOCREDITO             NUMBER(15, 2),
    NUCUPOUSADO               NUMBER(15, 2),
    NUCUPOEXTRAUSADO          NUMBER(15, 2),
    NUCUPOMANUALUSADO         NUMBER(15, 2),
    NUFACTID1                 NUMBER(15),
    NUFACTID2                 NUMBER(15),
    NUPUNTOVENTA              NUMBER,
    NUCANALVENTA              NUMBER,
    NUVENDEDORID              NUMBER,
    DTFECHAVENTA              DATE,
    NUPAGARED                 VARCHAR(30),
    NUPAGAREM                 VARCHAR(30),
    NUPAGAREUNICO             VARCHAR(30),
    NUVOUCHER                 NUMBER(15),
    NUMEDIORECEPID            NUMBER,
    NUADRESSID                NUMBER,
    SBFLAGPERIGRA             VARCHAR(1),
    SBFLAGENTREGPUNT          VARCHAR(1),
    NUCUOTAINI                NUMBER(15, 2),
    SBCOMMENT                 VARCHAR(2000),
    NUCONTRATISTAID           NUMBER(4),
    NUIDENTYPE                NUMBER(4),
    SBINDENTIFICACION         VARCHAR2(20),
    SBTELEFONO                VARCHAR2(50),
    SBNOMBRES                 VARCHAR2(100),
    SBAPELLIDOS               VARCHAR2(100),
    SBEMAIL                   VARCHAR2(100),
    DTFECHANAC                DATE,
    SBGENDER                  VARCHAR2(1),
    NUCIVILSTATE              NUMBER(4),
    NUSCHOOLGRADE             NUMBER(4),
    NUPROFESSION              NUMBER(15),
    SBFLAGDEUCOD              VARCHAR2(1),
    SBFLAGTITULAR             VARCHAR2(1),
    NULUGAREXPECED            NUMBER(15),
    DTFECHAEXPECED            DATE,
    NUTELEFONOPREDIO          NUMBER(15),
    NUPERSONASCARGO           NUMBER(15),
    NUTIPOVIVIENDA            NUMBER(15),
    NUANTIGUEDADHOGAR         NUMBER(4),
    NURELACIONTITULAR         NUMBER(4),
    SBOCUPATION               VARCHAR2(100),
    SBNOMBREEMPRESA           VARCHAR2(100),
    NUADDRESSEMPRESA          NUMBER(15),
    NUTELEFONO1               NUMBER(15),
    NUTELEFONO2               NUMBER(15),
    NUTELEFONOMOVIL           NUMBER(15),
    NUANTIGUEDADLABORAL       NUMBER(4),
    SBACTIVIDAD               VARCHAR2(100),
    NUINGRESOS                NUMBER(15, 2),
    NUEGRESOS                 NUMBER(15, 2),
    SBREFERENCIAFAMILIAR      VARCHAR2(200),
    SBTELEFONOREFEFAMI        VARCHAR2(20),
    SBMOVILREFEFAMI           VARCHAR2(20),
    NUADDRESSREFEFAMI         NUMBER(15),
    SBREFERENCIAPERSONAL      VARCHAR2(200),
    SBTELEFONOREFEPERSO       VARCHAR2(20),
    SBMOVILREFEPERSO          VARCHAR2(20),
    NUADDRESSREFEPERSO        NUMBER(15),
    SBREFERENCIACOMERCIAL     VARCHAR2(200),
    SBTELEFONOREFECOMER       VARCHAR2(20),
    SBMOVILREFECOMER          VARCHAR2(20),
    NUADDRESSREFECOMER        NUMBER(15),
    NUCATEGORY                NUMBER(2),
    NUSUBCATEGORY             NUMBER(2),
    NUTIPOCONTRACT            NUMBER(4),
    SBFLAGTITULAR_COD         VARCHAR2(1),
    SBNOMBRES_COD             VARCHAR2(100),
    NUIDENTYPE_COD            NUMBER(4),
    SBINDENTIFICACION_COD     VARCHAR2(20),
    NULUGAREXPECED_COD        NUMBER(15),
    DTFECHAEXPECED_COD        DATE,
    SBGENDER_COD              VARCHAR2(1),
    NUCIVILSTATE_COD          NUMBER(2),
    DTFECHANAC_COD            DATE,
    NUSCHOOLGRADE_COD         NUMBER(2),
    NUADDRESS_COD             NUMBER(15),
    NUTELEFONOPREDIO_COD      NUMBER(15),
    NUPERSONASCARGO_COD       NUMBER(15),
    NUTIPOVIVIENDA_COD        NUMBER(15),
    NUANTIGUEDADHOGAR_COD     NUMBER(4),
    NURELACIONTITULAR_COD     NUMBER(4),
    SBOCUPATION_COD           VARCHAR2(100),
    SBNOMBREEMPRESA_COD       VARCHAR2(100),
    NUADDRESSEMPRESA_COD      NUMBER(15),
    NUTELEFONO1_COD           NUMBER(15),
    NUTELEFONO2_COD           NUMBER(15),
    NUTELEFONOMOVIL_COD       NUMBER(15),
    NUANTIGUEDADLABORAL_COD   NUMBER(4),
    SBACTIVIDAD_COD           VARCHAR2(100),
    NUINGRESOS_COD            NUMBER(15, 2),
    NUEGRESOS_COD             NUMBER(15, 2),
    SBREFERENCIAFAMILIAR_COD  VARCHAR2(200),
    SBTELEFONOREFEFAMI_COD    VARCHAR2(20),
    SBMOVILREFEFAMI_COD       VARCHAR2(20),
    NUADDRESSREFEFAMI_COD     NUMBER(15),
    SBREFERENCIAPERSONAL_COD  VARCHAR2(200),
    SBTELEFONOREFEPERSO_COD   VARCHAR2(20),
    SBMOVILREFEPERSO_COD      VARCHAR2(20),
    NUADDRESSREFEPERSO_COD    NUMBER(15),
    SBREFERENCIACOMERCIAL_COD VARCHAR2(200),
    SBTELEFONOREFECOMER_COD   VARCHAR2(20),
    SBMOVILREFECOMER_COD      VARCHAR2(20),
    NUADDRESSREFECOMER_COD    NUMBER(15),
    SBEMAIL_COD               VARCHAR2(100),
    NUCATEGORY_COD            NUMBER(2),
    NUSUBCATEGORY_COD         NUMBER(2),
    NUTIPOCONTRACT_COD        NUMBER(4),
    SBAPELLIDOS_COD           VARCHAR2(100),
    SBFLAGDEUDORSOLI_COD      VARCHAR2(1),
    NUCAUSALDEUSOLI_COD       NUMBER(4),
    SBDIRECCION_COD           VARCHAR2(200),
    NUVALORAPROXSEG           NUMBER(15),
    NUCUOTAAPROXMEN           NUMBER(15, 2),
    NUCUOTAAPROXMENSEG        NUMBER(15, 2),
    NUTOTALVENTA              NUMBER(15, 2),
    SBFLAGTRASLADOCUPO        VARCHAR(1));

  rgXML t_DatosXml; -- Se crea una variable con el tipo de tabla creada.

  ----------------------
  --Variables Generales.
  ----------------------
  NUEXTRAQUOTA NUMBER; --CupoExtra
  --Inicio Cambio solicitado por el Ing. Eduardo Aguera
  NUEXTRAQUOTAUSED NUMBER; --Cupo Extra usado.
  --Fin Cambio solicitado por el Ing. Eduardo Aguera
  ONUPACKAGEID    NUMBER := NULL; --Solicitud de venta
  ONUPACKAGEIDPU  NUMBER := NULL; --Solicitud de pagare unico
  ONUMOTIVEID     NUMBER(15) := NULL; --Motivo
  NUPROMISSORY_ID NUMBER; --Pagare
  SBUSEDPAGAREU   BOOLEAN := FALSE;
  NUCANTCUOTAS    NUMBER := 0;

  --------------------------------------------------------------------------------------------
  /*************************************INICIA PAQUETE***************************************/
  --------------------------------------------------------------------------------------------

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : fnuValidateConsecuFNB
  DESCRIPCION    : Servicio para validar si la unidad operativa del vendedor es igual a la del pagare.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  FUNCTION fnuValidateConsecuFNB(inuConsId IN fa_consasig.coasnume%TYPE)
  
   RETURN BOOLEAN IS
  
    CURSOR cuOperUnitPg(inuTipoComp tipocomp.ticocodi%TYPE) IS
    
      select hicdunop
      
        from (select hicdunop
              
                from fa_histcodi
              
               where hicdnume = inuConsId
                    
                 and hicdtico = inuTipoComp
              
               order by hicdcons desc)
      
       where rownum = 1;
  
    nuTipoComp tipocomp.ticocodi%TYPE;
  
    nuOperUnitPg or_operating_unit.operating_unit_id%TYPE; --Unidad operativa asignada al pagare
  
    nuContractorPg ge_contratista.id_contratista%type; --Contratista al que esta asignado el pagare
  
    nuContractorId ge_contratista.id_contratista%type; --Contratista al que pertenece el funcionario conectado
  
    nuOperatingUnit or_operating_unit.operating_unit_id%type;
  
    nuPersonId cc_orga_area_seller.person_id%type;
  
    CURSOR cuGetunitBySeller(PersonId cc_orga_area_seller.person_id%type) IS
      SELECT organizat_area_id
        FROM cc_orga_area_seller
       WHERE person_id =
             decode(PersonId, null, GE_BOPersonal.fnuGetPersonId, PersonId)
         AND IS_current = 'Y'
         AND rownum = 1;
  
    CURSOR cuPersonId IS
      SELECT person_id --organizat_area_id
      --into LD_BONONBANKFINANCING.nupersonportal
        FROM cc_orga_area_seller
       WHERE IS_current = 'Y'
         and organizat_area_id = rgXML.NUPUNTOVENTA
         AND rownum = 1;
  
  BEGIN
  
    open cuPersonId;
    fetch cuPersonId
      INTO nuPersonId;
    close cuPersonId;
  
    open cuGetunitBySeller(nuPersonId);
    fetch cuGetunitBySeller
      INTO nuOperatingUnit;
    close cuGetunitBySeller;
  
    if (nuOperatingUnit IS null) then
      RETURN FALSE;
    END if;
  
    ut_trace.trace('Inicia LD_BONonbankfinancing.fnuValidateConsecuFNB',
                   
                   11);
  
    --Obtiene el tipo de comprobante del producto brilla
  
    nuTipoComp := Dald_Parameter.fnuGetNumeric_Value('COD_TYPE_OF_PROOF',
                                                     
                                                     null);
  
    FOR rgcuOperUnitPg IN cuOperUnitPg(nuTipoComp) LOOP
    
      nuOperUnitPg := rgcuOperUnitPg.hicdunop;
    
    END LOOP;
  
    IF nuOperUnitPg IS NULL THEN
    
      RETURN FALSE;
    
    END IF;
  
    --Se obtiene el contratista al que pertenece la unidad operativa del funcionario
  
    nuContractorId := daor_operating_unit.fnugetcontractor_id(nuOperatingUnit);
  
    --Se obtiene el contratista al que pertenece la unidad operativa del pagare
  
    nuContractorPg := daor_operating_unit.fnugetcontractor_id(nuOperUnitPg);
  
    IF nuContractorId <> nuContractorPg THEN
    
      RETURN FALSE;
    
    END IF;
  
    ut_trace.trace('Finaliza LD_BONonbankfinancing.fnuValidateConsecuFNB',
                   
                   11);
  
    RETURN TRUE;
  
  EXCEPTION
  
    when ex.CONTROLLED_ERROR then
    
      raise ex.CONTROLLED_ERROR;
    
    when others then
    
      Errors.setError;
    
      raise ex.CONTROLLED_ERROR;
    
  END fnuValidateConsecuFNB;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proValidaPagare
  DESCRIPCION    : Servicio para validar existencia del pagare ingresado.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proValidaPagare(INUPAGARE       IN LD_PROMISSORY_PU.PROMISSORY_ID%TYPE,
                            ONUERRORCODE    OUT NUMBER,
                            OSBERRORMESSAGE OUT VARCHAR2) AS
    nuPagare NUMBER := null;
    nuEstado NUMBER := null;
  BEGIN
    --Se obtiene pagare y estado
    BEGIN
      SELECT t.pagare_id, t.estado
        INTO nuPagare, nuEstado
        FROM LDC_PAGUNIDAT t
       WHERE t.pagare_id = INUPAGARE;
    EXCEPTION
      WHEN OTHERS THEN
        nuPagare := null;
        nuEstado := null;
    END;
    --Si obtiene pagare y el estado es valido = 1
    IF nuPagare is not null AND
       nuEstado =
       (dald_parameter.fnuGetNumeric_Value('COD_EST_EN_PRO_PAG_UNI')) THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error: Ya existe un pagare unico con el consecutivo [' ||
                               to_char(INUPAGARE) || ']');
      --Si obtiene pagare y el estado no es valido < > 1
    ELSIF nuPagare is not null AND
          nuEstado <>
          (dald_parameter.fnuGetNumeric_Value('COD_EST_EN_PRO_PAG_UNI')) THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error: Ya existe un pagare unico con el consecutivo [' ||
                               to_char(INUPAGARE) || ']');
    ELSE
      ONUERRORCODE    := 1;
      OSBERRORMESSAGE := null;
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Si no se obtienen datos es porque el pagare no existe.
      ONUERRORCODE    := 1;
      OSBERRORMESSAGE := UPPER('El pagare no existe');
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error validando pagare : ' || SQLERRM);
      RETURN;
  END proValidaPagare;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proValidaPagare2
  DESCRIPCION    : Servicio para validar existencia del pagare ingresado.
  AUTOR          : Daniel Valiente
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proValidaPagare2(INUPAGARE       IN LD_PROMISSORY_PU.PROMISSORY_ID%TYPE,
                             ONUERRORCODE    OUT NUMBER,
                             OSBERRORMESSAGE OUT VARCHAR2) AS
    nuPagare NUMBER := null;
    nuEstado NUMBER := null;
  BEGIN
    --Se obtiene pagare y estado
    SELECT t.pagare_id, t.estado
      INTO nuPagare, nuEstado
      FROM LDC_PAGUNIDAT t
     WHERE t.pagare_id = INUPAGARE;
    --Si obtiene pagare y el estado es valido = 1
    IF nuPagare is not null AND
       nuEstado =
       (dald_parameter.fnuGetNumeric_Value('COD_EST_EN_PRO_PAG_UNI')) THEN
      ONUERRORCODE    := 0;
      OSBERRORMESSAGE := UPPER('Error: Ya existe un pagare unico con el consecutivo [' ||
                               to_char(INUPAGARE) ||
                               '] en estado en Proceso');
      --Si obtiene pagare y el estado no es valido < > 1
    ELSIF nuPagare is not null AND
          nuEstado <>
          (dald_parameter.fnuGetNumeric_Value('COD_EST_EN_PRO_PAG_UNI')) THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error: Ya existe un pagare unico con el consecutivo [' ||
                               to_char(INUPAGARE) ||
                               '] en estado Anulado o Vendido');
    END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      -- Si no se obtienen datos es porque el pagare no existe.
      ONUERRORCODE    := 1;
      OSBERRORMESSAGE := UPPER('El pagare no existe');
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error validando pagare : ' || SQLERRM);
      RETURN;
  END proValidaPagare2;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraSolicitudPagare
  DESCRIPCION    : Servicio para registrar el pagare ingresado.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraSolicitudPagare(INUPAGARE       IN LD_PROMISSORY_PU.PROMISSORY_ID%TYPE,
                                       ONUERRORCODE    OUT NUMBER,
                                       OSBERRORMESSAGE OUT VARCHAR2) AS
  
    ISBPAGAREXML       VARCHAR2(32767); -- Para Xml.
    NUESTADO_DE_PAGARE NUMBER := dald_parameter.fnuGetNumeric_Value('COD_EST_EN_PRO_PAG_UNI');
    nuSolicitudId      NUMBER;
    nuMotiveId         NUMBER;
  BEGIN
    ------------------------------
    -- Arma Xml para pagare unico
    ------------------------------
    ISBPAGAREXML := '<?xml version= "1.0" encoding= "ISO-8859-1" ?>' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML ||
                    '<P_LDC_SOLICITUD_PAGARE_UNICO_100279 ID_TIPOPAQUETE="100279">' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<RECEPTION_TYPE_ID>' ||
                    rgXML.NUMEDIORECEPID || '</RECEPTION_TYPE_ID>' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<CONTACT_ID>' || rgXML.NUCLIENTEID ||
                    '</CONTACT_ID>' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<ADDRESS_ID>' || rgXML.NUADRESSID ||
                    '</ADDRESS_ID>' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<COMMENT_ > [LDCSPU - PORTAL BRILLA]' ||
                    'GENERACION SOLICITUD DE PAGARE UNICO LDCSPU' ||
                    '</COMMENT_>' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<CONTRATO_PENDIENTE >' ||
                    rgXML.NUCONTRACTID || '</CONTRATO_PENDIENTE>' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<M_SERVICIOS_FINANCIEROS_100275>' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<CONSECUTIVO_DEL_PAGAR >' || INUPAGARE ||
                    '</CONSECUTIVO_DEL_PAGAR>' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<ESTADO_DE_PAGARE>' ||
                    NUESTADO_DE_PAGARE || '</ESTADO_DE_PAGARE>' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '<ID_PRODUCTO />' || chr(10);
    ISBPAGAREXML := ISBPAGAREXML || '</M_SERVICIOS_FINANCIEROS_100275>' ||
                    chr(10);
    ISBPAGAREXML := ISBPAGAREXML ||
                    '</P_LDC_SOLICITUD_PAGARE_UNICO_100279>' || chr(10);
  
    ------------------------------------------------------------------------
    --REGISTRO DE SOLICITUD.
    --Se envia el XML armado y se retorna el ID de la solicitud
    ------------------------------------------------------------------------
  
    OS_RegisterRequestWithXML(ISBPAGAREXML,
                              nuSolicitudId,
                              nuMotiveId,
                              ONUERRORCODE,
                              OSBERRORMESSAGE);
    IF ONUERRORCODE <> 0 THEN
      ONUERRORCODE := -1;
    END IF;
    ONUPACKAGEIDPU  := nuSolicitudId;
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando solicitud pagare unico : ' ||
                               SQLERRM);
      RETURN;
  END proRegistraSolicitudPagare;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proValidateNumberFNB
  DESCRIPCION    : Servicio para validar que el pagare ingresado corresponda a la unidad operativa.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/

  PROCEDURE proValidateNumberFNB(ONUERRORCODE    OUT NUMBER,
                                 OSBERRORMESSAGE OUT VARCHAR2)
  
   is
  
    /*Declaracion de variables*/
  
    inuTipoProd servicio.servcodi%type := 7055;
  
    nuType_of_proof tipocomp.ticocodi%type;
  
    nuErrorCode number;
  
    nuDocTypeSaleFNB NUMBER(15) := 135;
  
    sbErrorMessage varchar(32000);
  
    CNUFOLIO_NO_OPERUNIT CONSTANT NUMBER := 900827;
  
    /*Producto Promigas*/
  
    cnuPromigas CONSTANT servicio.servcodi%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA_PROM');
  
    /*Producto BRILLA*/
  
    cnuBrilla CONSTANT servicio.servcodi%TYPE := dald_parameter.fnuGetNumeric_Value('COD_PRODUCT_TYPE_BRILLA');
  
  BEGIN
  
    ut_trace.trace('Inicia LD_BONonbankfinancing.validateNumberFNB', 11);
  
    /*Valida el tipo de producto para obtener el tipo de comprobante*/
  
    if (inuTipoProd = cnuBrilla) then
    
      /*Obtener el parametro del tipo de comprobante de servicios financieros*/
    
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('COD_TYPE_OF_PROOF',
                                                            
                                                            null);
    
    elsif (inuTipoProd = cnuPromigas) then
    
      /*Obtener el parametro del tipo de comprobante de promigas*/
    
      nuType_of_proof := Dald_Parameter.fnuGetNumeric_Value('TYPE_OF_PROOF_PROMIGAS',
                                                            
                                                            null);
    
    END if;
  
    /*Call the procedure*/
  
    BEGIN
    
      pkconsecutivemgr.valauthnumber(inutipodocu => nuDocTypeSaleFNB,
                                     
                                     inucliente => Null,
                                     
                                     inuempresa => Null,
                                     
                                     inunumero => rgXML.NUPAGAREM,
                                     
                                     inutipocomp => nuType_of_proof,
                                     
                                     inuoperunit => rgXML.NUPUNTOVENTA,
                                     
                                     inutipoprod => inuTipoProd);
    
      ONUERRORCODE    := 0;
      OSBERRORMESSAGE := 'OK';
    EXCEPTION
    
      WHEN ex.CONTROLLED_ERROR THEN
      
        Errors.getError(nuErrorCode, sbErrorMessage);
      
        if nuErrorCode = CNUFOLIO_NO_OPERUNIT then
        
          --ABaldovino 30/04/2015 REQ 6920
        
          --Se modifica para que valide si el contratista del punto de atencion del funcionario conectado
        
          --corresponde al mismo del punto de atencion asignado al pagare.
        
          IF fnuValidateConsecuFNB(rgXML.NUPAGAREM) = FALSE THEN
            ONUERRORCODE    := -1;
            OSBERRORMESSAGE := 'ERROR VALIDANDO EL PAGARE ' ||
                               TO_CHAR(rgXML.NUPAGAREM) ||
                               ', PARA EL PROVEEDOR ' ||
                               TO_CHAR(rgXML.NUPUNTOVENTA);
            RAISE ex.CONTROLLED_ERROR;
          END IF;
        
        ELSE
          RAISE ex.CONTROLLED_ERROR;
        END IF;
      
      WHEN OTHERS THEN
        OSBERRORMESSAGE := 'ERROR VALIDANDO EL PAGARE ' ||
                           TO_CHAR(rgXML.NUPAGAREM) ||
                           ', PARA EL PROVEEDOR ' ||
                           TO_CHAR(rgXML.NUPUNTOVENTA);
        RAISE ex.CONTROLLED_ERROR;
    END;
  
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  
  EXCEPTION
    when ex.CONTROLLED_ERROR then
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR VALIDANDO EL PAGARE ' ||
                         TO_CHAR(rgXML.NUPAGAREM) || ', PARA EL PROVEEDOR ' ||
                         TO_CHAR(rgXML.NUPUNTOVENTA);
    when others then
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR VALIDANDO EL PAGARE ' ||
                         TO_CHAR(rgXML.NUPAGAREM) || ', PARA EL PROVEEDOR ' ||
                         TO_CHAR(rgXML.NUPUNTOVENTA);
    
      raise ex.CONTROLLED_ERROR;
  END proValidateNumberFNB;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraInformacionPagare
  DESCRIPCION    : Servicio para registrar el pagare ingresado.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 04/07/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  04-07-2018      SEBTAP               REQ.2001511 Creacion
  01-02-2019      DANVAL               Validacion del VOUCHER
  ******************************************************************/
  PROCEDURE proRegistraInformacionPagare(ONUERRORCODE    OUT NUMBER,
                                         OSBERRORMESSAGE OUT VARCHAR2) AS
    continuar  number;
    numDet     number;
    numVoucher number := rgXML.NUVOUCHER;
  BEGIN
    --Caso 2375
    --Validacion del VOUCHER
    continuar := 0;
    while continuar = 0 loop
      select count(1)
        into numDet
        from ldc_pagunidet p
       where p.pagare_id = NUPROMISSORY_ID
         and voucher = numVoucher;
      if numDet = 0 then
        continuar := 1;
      else
        numVoucher := numVoucher + 1;
      end if;
    end loop;
    ---
    --rgXML.
    LDC_PKVENTAPAGOUNICO.RegisterVentaFNBVoucher(ONUPACKAGEID,
                                                 NUPROMISSORY_ID,
                                                 numVoucher,
                                                 rgXML.NUTOTALVENTA,
                                                 NUCANTCUOTAS,
                                                 rgXML.NUCUOTAINI,
                                                 rgXML.NUVALORAPROXSEG);
  
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando informacion del pagare unico : ' ||
                               SQLERRM);
      RETURN;
  END proRegistraInformacionPagare;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proValidaCampos
  DESCRIPCION    : Servicio para validar que no existan campos nulos, antes de registrar la venta.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/

  PROCEDURE proValidaCampos(ONUERRORCODE    OUT NUMBER,
                            OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    --------------------------------------------------------------------------------------------
    ----------------------------------> VALIDACION DE CAMPOS <----------------------------------
    --------------------------------------------------------------------------------------------
    IF rgXML.NUCONTRACTID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID CONTRATO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCLIENTEID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID CLIENTE] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCUPOCREDITO IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [CUPO CREDITO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCUPOUSADO IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [CUPO USADO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUPUNTOVENTA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID PUNTO DE VENTA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCANALVENTA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID CANAL DE VENTA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUVENDEDORID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID VENDEDOR] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.DTFECHAVENTA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [FECHA DE VENTA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUPAGARED IS NOT NULL AND rgXML.NUPAGAREM IS NOT NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR: DEBE INGRESAR UN SOLO TIPO DE PAGARE [MANUAL O DIGITAL]. NO AMBOS A LA VEZ';
      RETURN;
    END IF;
    IF rgXML.NUPAGAREM IS NOT NULL AND rgXML.NUPAGAREUNICO IS NOT NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR: DEBE INGRESAR UN SOLO TIPO DE PAGARE [MANUAL O UNICO]. NO AMBOS A LA VEZ';
      RETURN;
    END IF;
    IF rgXML.NUPAGARED IS NOT NULL AND rgXML.NUPAGAREUNICO IS NOT NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := 'ERROR: DEBE INGRESAR UN SOLO TIPO DE PAGARE [UNICO O DIGITAL]. NO AMBOS A LA VEZ';
      RETURN;
    END IF;
    IF rgXML.NUMEDIORECEPID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID MEDIO DE RECEPCION] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUADRESSID IS NULL THEN
      BEGIN
        SELECT G.ADDRESS_ID
          INTO rgXML.NUADRESSID
          FROM GE_SUBSCRIBER G
         WHERE G.SUBSCRIBER_ID = rgXML.NUCLIENTEID;
        IF rgXML.NUADRESSID IS NULL THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          RAISE EX.CONTROLLED_ERROR;
        WHEN EX.CONTROLLED_ERROR THEN
          ONUERRORCODE    := -1;
          OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID DIRECCION] NO PUDO SER OBTENIDO.');
          RETURN;
        WHEN OTHERS THEN
          ONUERRORCODE    := -1;
          OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID DIRECCION] NO PUDO SER OBTENIDO.');
          RETURN;
      END;
    END IF;
    IF rgXML.SBFLAGPERIGRA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [PERIODO DE GRACIA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.SBFLAGENTREGPUNT IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ENTREGA EN PUNTO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCONTRATISTAID IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [ID CONTRATISTA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUIDENTYPE IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [TIPO IDENTIFICACION] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.SBINDENTIFICACION IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [IDENTIFICACION] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.SBNOMBRES IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [NOMBRES] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.SBAPELLIDOS IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [APELLIDOS] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.DTFECHANAC IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [FECHA DE NACIMIENTO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.SBINDENTIFICACION_COD IS NOT NULL THEN
      IF rgXML.SBFLAGTITULAR_COD IS NULL THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [INDICADOR DE TITULARIDAD CODEUDOR] NO PUEDE SER NULO.');
        RETURN;
      END IF;
      IF rgXML.SBNOMBRES_COD IS NULL THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [NOMBRES CODEUDOR] NO PUEDE SER NULO.');
        RETURN;
      END IF;
      IF rgXML.NUIDENTYPE_COD IS NULL THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [TIPO IDENTIFICACION CODEUDOR] NO PUEDE SER NULO.');
        RETURN;
      END IF;
      IF rgXML.SBAPELLIDOS_COD IS NULL THEN
        ONUERRORCODE    := -1;
        OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [APELLIDOS CODEUDOR] NO PUEDE SER NULO.');
        RETURN;
      END IF;
    END IF;
    IF rgXML.NUVALORAPROXSEG IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [VALOR APROXIMADO DEL SEGURO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCUOTAAPROXMEN IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [CUOTA APROXIMADA MENSUAL] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUCUOTAAPROXMENSEG IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [CUOTA APROXIMADA MENSUAL DEL SEGURO] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    IF rgXML.NUTOTALVENTA IS NULL THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('ERROR: EL CAMPO [VALOR TOTAL DE LA VENTA] NO PUEDE SER NULO.');
      RETURN;
    END IF;
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  END proValidaCampos;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraExtraCupo
  DESCRIPCION    : Servicio para registrar el cupo extra usado en la venta.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraExtraCupo(ONUERRORCODE    OUT NUMBER,
                                 OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.REGISTEREXTRAQUOTAFNBDETA(NUEXTRAQUOTA,
                                                    rgXML.NUCONTRACTID,
                                                    --Inicio Cambio solicitado por el Ing. Eduardo Aguera
                                                    NUEXTRAQUOTAUSED, --'Y',
                                                    --Fin Cambio solicitado por el Ing. Eduardo Aguera
                                                    ONUPACKAGEID);
  
    LD_BONONBANKFINANCING.VALIDAREXTRAQUOTAFNBDETA(ONUPACKAGEID);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando cupo extra: ' || SQLERRM);
      RETURN;
  END proRegistraExtraCupo;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraInstalArticulo
  DESCRIPCION    : Servicio para vregistrar la instalacion de articulos.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraInstalArticulo(ONUERRORCODE    OUT NUMBER,
                                      OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.REGISTERSALEINSTALL(ONUPACKAGEID,
                                              rgXML.NUCONTRACTID,
                                              rgXML.NUCONTRATISTAID);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando instalacion de articulos: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraInstalArticulo;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraDeudor
  DESCRIPCION    : Servicio para registrar datos del deudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraDeudor(ONUERRORCODE    OUT NUMBER,
                              OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.REGISTERDEUDORDATA(rgXML.NUCLIENTEID,
                                             NUPROMISSORY_ID,
                                             rgXML.SBFLAGTITULAR,
                                             rgXML.SBNOMBRES,
                                             rgXML.NUIDENTYPE,
                                             rgXML.SBINDENTIFICACION,
                                             rgXML.NULUGAREXPECED,
                                             rgXML.DTFECHAEXPECED,
                                             rgXML.SBGENDER,
                                             rgXML.NUCIVILSTATE,
                                             rgXML.DTFECHANAC,
                                             rgXML.NUSCHOOLGRADE,
                                             rgXML.NUADRESSID,
                                             rgXML.NUTELEFONOPREDIO,
                                             rgXML.NUPERSONASCARGO,
                                             rgXML.NUTIPOVIVIENDA,
                                             rgXML.NUANTIGUEDADHOGAR,
                                             rgXML.NURELACIONTITULAR,
                                             rgXML.SBOCUPATION,
                                             rgXML.SBNOMBREEMPRESA,
                                             rgXML.NUADDRESSEMPRESA,
                                             rgXML.NUTELEFONO1,
                                             rgXML.NUTELEFONO2,
                                             rgXML.NUTELEFONOMOVIL,
                                             rgXML.NUANTIGUEDADLABORAL,
                                             rgXML.SBACTIVIDAD,
                                             rgXML.NUINGRESOS,
                                             rgXML.NUEGRESOS,
                                             rgXML.SBREFERENCIAFAMILIAR,
                                             rgXML.SBTELEFONOREFEFAMI,
                                             rgXML.SBMOVILREFEFAMI,
                                             rgXML.NUADDRESSREFEFAMI,
                                             rgXML.SBREFERENCIAPERSONAL,
                                             rgXML.SBTELEFONOREFEPERSO,
                                             rgXML.SBMOVILREFEPERSO,
                                             rgXML.NUADDRESSREFEPERSO,
                                             rgXML.SBREFERENCIACOMERCIAL,
                                             rgXML.SBTELEFONOREFECOMER,
                                             rgXML.SBMOVILREFECOMER,
                                             rgXML.NUADDRESSREFECOMER,
                                             rgXML.SBEMAIL,
                                             ONUPACKAGEID,
                                             rgXML.NUCATEGORY,
                                             rgXML.NUSUBCATEGORY,
                                             rgXML.NUTIPOCONTRACT,
                                             rgXML.SBAPELLIDOS,
                                             null,
                                             null);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando deudor: ' || SQLERRM);
      RETURN;
  END proRegistraDeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proActualizaDeudor
  DESCRIPCION    : Servicio para actualizar datos del deudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proActualizaDeudor(ONUERRORCODE    OUT NUMBER,
                               OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.UPDDEBCOS(rgXML.NUIDENTYPE,
                                    rgXML.SBINDENTIFICACION,
                                    rgXML.SBTELEFONO,
                                    rgXML.SBNOMBRES,
                                    rgXML.SBAPELLIDOS,
                                    rgXML.SBEMAIL,
                                    rgXML.NUADRESSID,
                                    rgXML.DTFECHANAC,
                                    rgXML.SBGENDER,
                                    rgXML.NUCIVILSTATE,
                                    rgXML.NUSCHOOLGRADE,
                                    rgXML.NUPROFESSION,
                                    'D');
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error actualizando deudor: ' || SQLERRM);
      RETURN;
  END proActualizaDeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraDeudorPU
  DESCRIPCION    : Servicio para registrar datos del deudor para el pagare unico.
  AUTOR          : SAMUEL PACHECO
  FECHA          : 23/09/2018
  REQ            : 200-2027
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  23/09/2018      SAMPAC             REQ.2002027 Creacion
  ******************************************************************/
  PROCEDURE proRegistraDeudorPU(ONUERRORCODE    OUT NUMBER,
                                OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LDC_PKVENTAPAGOUNICO.RegisterDeudorData(rgXML.NUCLIENTEID,
                                            NUPROMISSORY_ID,
                                            rgXML.SBFLAGTITULAR,
                                            rgXML.SBNOMBRES,
                                            rgXML.NUIDENTYPE,
                                            rgXML.SBINDENTIFICACION,
                                            rgXML.NULUGAREXPECED,
                                            rgXML.DTFECHAEXPECED,
                                            rgXML.SBGENDER,
                                            rgXML.NUCIVILSTATE,
                                            rgXML.DTFECHANAC,
                                            rgXML.NUSCHOOLGRADE,
                                            rgXML.NUADRESSID,
                                            rgXML.NUTELEFONOPREDIO,
                                            rgXML.NUPERSONASCARGO,
                                            rgXML.NUTIPOVIVIENDA,
                                            rgXML.NUANTIGUEDADHOGAR,
                                            rgXML.NURELACIONTITULAR,
                                            rgXML.SBOCUPATION,
                                            rgXML.SBNOMBREEMPRESA,
                                            rgXML.NUADDRESSEMPRESA,
                                            rgXML.NUTELEFONO1,
                                            rgXML.NUTELEFONO2,
                                            rgXML.NUTELEFONOMOVIL,
                                            rgXML.NUANTIGUEDADLABORAL,
                                            rgXML.SBACTIVIDAD,
                                            rgXML.NUINGRESOS,
                                            rgXML.NUEGRESOS,
                                            rgXML.SBREFERENCIAFAMILIAR,
                                            rgXML.SBTELEFONOREFEFAMI,
                                            rgXML.SBMOVILREFEFAMI,
                                            rgXML.NUADDRESSREFEFAMI,
                                            rgXML.SBREFERENCIAPERSONAL,
                                            rgXML.SBTELEFONOREFEPERSO,
                                            rgXML.SBMOVILREFEPERSO,
                                            rgXML.NUADDRESSREFEPERSO,
                                            rgXML.SBREFERENCIACOMERCIAL,
                                            rgXML.SBTELEFONOREFECOMER,
                                            rgXML.SBMOVILREFECOMER,
                                            rgXML.NUADDRESSREFECOMER,
                                            rgXML.SBEMAIL,
                                            ONUPACKAGEIDPU,
                                            rgXML.NUCATEGORY,
                                            rgXML.NUSUBCATEGORY,
                                            rgXML.NUTIPOCONTRACT,
                                            rgXML.SBAPELLIDOS,
                                            null,
                                            null);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando deudor: ' || SQLERRM);
      RETURN;
  END proRegistraDeudorPU;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proActualizaAddressCodeudor
  DESCRIPCION    : Servicio para actualizar direccion datos del codeudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proActualizaAddressCodeudor(ONUERRORCODE    OUT NUMBER,
                                        OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
  
    UPDATE ld_promissory l
       SET l.address_parsed = rgXML.SBDIRECCION_COD
     WHERE l.promissory_id = NUPROMISSORY_ID
       AND l.identification = rgXML.SBINDENTIFICACION_COD
       AND l.ident_type_id = rgXML.NUIDENTYPE_COD
       AND l.package_id = ONUPACKAGEID
       AND l.promissory_type = 'C';
  
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error actualizando deudor: ' || SQLERRM);
      RETURN;
  END proActualizaAddressCodeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraCodeudor
  DESCRIPCION    : Servicio para registrar datos del codeudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraCodeudor(ONUERRORCODE    OUT NUMBER,
                                OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.REGISTERCOSIGNERDATA(NUPROMISSORY_ID,
                                               rgXML.SBFLAGTITULAR_COD,
                                               rgXML.SBNOMBRES_COD,
                                               rgXML.NUIDENTYPE_COD,
                                               rgXML.SBINDENTIFICACION_COD,
                                               rgXML.NULUGAREXPECED_COD,
                                               rgXML.DTFECHAEXPECED_COD,
                                               rgXML.SBGENDER_COD,
                                               rgXML.NUCIVILSTATE_COD,
                                               rgXML.DTFECHANAC_COD,
                                               rgXML.NUSCHOOLGRADE_COD,
                                               rgXML.NUADDRESS_COD,
                                               rgXML.NUTELEFONOPREDIO_COD,
                                               rgXML.NUPERSONASCARGO_COD,
                                               rgXML.NUTIPOVIVIENDA_COD,
                                               rgXML.NUANTIGUEDADHOGAR_COD,
                                               rgXML.NURELACIONTITULAR_COD,
                                               rgXML.SBOCUPATION_COD,
                                               rgXML.SBNOMBREEMPRESA_COD,
                                               rgXML.NUADDRESSEMPRESA_COD,
                                               rgXML.NUTELEFONO1_COD,
                                               rgXML.NUTELEFONO2_COD,
                                               rgXML.NUTELEFONOMOVIL_COD,
                                               rgXML.NUANTIGUEDADLABORAL_COD,
                                               rgXML.SBACTIVIDAD_COD,
                                               rgXML.NUINGRESOS_COD,
                                               rgXML.NUEGRESOS_COD,
                                               rgXML.SBREFERENCIAFAMILIAR_COD,
                                               rgXML.SBTELEFONOREFEFAMI_COD,
                                               rgXML.SBMOVILREFEFAMI_COD,
                                               rgXML.NUADDRESSREFEFAMI_COD,
                                               rgXML.SBREFERENCIAPERSONAL_COD,
                                               rgXML.SBTELEFONOREFEPERSO_COD,
                                               rgXML.SBMOVILREFEPERSO_COD,
                                               rgXML.NUADDRESSREFEPERSO_COD,
                                               rgXML.SBREFERENCIACOMERCIAL_COD,
                                               rgXML.SBTELEFONOREFECOMER_COD,
                                               rgXML.SBMOVILREFECOMER_COD,
                                               rgXML.NUADDRESSREFECOMER_COD,
                                               rgXML.SBEMAIL_COD,
                                               ONUPACKAGEID,
                                               rgXML.NUCATEGORY_COD,
                                               rgXML.NUSUBCATEGORY_COD,
                                               rgXML.NUTIPOCONTRACT_COD,
                                               rgXML.SBAPELLIDOS_COD,
                                               rgXML.SBFLAGDEUDORSOLI_COD,
                                               rgXML.NUCAUSALDEUSOLI_COD);
  
    proActualizaAddressCodeudor(ONUERRORCODE, OSBERRORMESSAGE);
    IF ONUERRORCODE <> 0 THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando codeudor [' ||
                               rgXML.SBINDENTIFICACION_COD || ']: ' ||
                               SQLERRM);
      RETURN;
    END IF;
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando codeudor [' ||
                               rgXML.SBINDENTIFICACION_COD || ']: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraCodeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proActualizaCodeudor
  DESCRIPCION    : Servicio para actualizar datos del codeudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proActualizaCodeudor(ONUERRORCODE    OUT NUMBER,
                                 OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.UPDDEBCOS(rgXML.NUIDENTYPE_COD,
                                    rgXML.SBINDENTIFICACION_COD,
                                    null,
                                    rgXML.SBNOMBRES_COD,
                                    rgXML.SBAPELLIDOS_COD,
                                    rgXML.SBEMAIL_COD,
                                    rgXML.NUADDRESS_COD,
                                    rgXML.DTFECHANAC_COD,
                                    rgXML.SBGENDER_COD,
                                    rgXML.NUCIVILSTATE_COD,
                                    rgXML.NUSCHOOLGRADE_COD,
                                    null,
                                    'C');
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error actualizando deudor: ' || SQLERRM);
      RETURN;
  END proActualizaCodeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proActualizaAddressCodeudorPU
  DESCRIPCION    : Servicio para actualizar direccion datos del codeudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proActualizaAddressCodeudorPU(ONUERRORCODE    OUT NUMBER,
                                          OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
  
    UPDATE ld_promissory_pu l
       SET l.address_parsed = rgXML.SBDIRECCION_COD
     WHERE l.promissory_id = NUPROMISSORY_ID
       AND l.identification = rgXML.SBINDENTIFICACION_COD
       AND l.ident_type_id = rgXML.NUIDENTYPE_COD
       AND l.package_id = ONUPACKAGEIDPU
       AND l.promissory_type = 'C';
  
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error actualizando deudor: ' || SQLERRM);
      RETURN;
  END proActualizaAddressCodeudorPU;

  /*********************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraCodeudorPU
  DESCRIPCION    : Servicio para registrar datos del codeudor en pagare unico.
  AUTOR          : SAMUEL PACHECO
  FECHA          : 23/09/2018
  REQ            : 200-2027
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  23/09/2018     SAMPAC               REQ.2002027 Creacion
  ******************************************************************/
  PROCEDURE proRegistraCodeudorPU(ONUERRORCODE    OUT NUMBER,
                                  OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LDC_PKVENTAPAGOUNICO.RegisterCosignerData(NUPROMISSORY_ID,
                                              rgXML.SBFLAGTITULAR_COD,
                                              rgXML.SBNOMBRES_COD,
                                              rgXML.NUIDENTYPE_COD,
                                              rgXML.SBINDENTIFICACION_COD,
                                              rgXML.NULUGAREXPECED_COD,
                                              rgXML.DTFECHAEXPECED_COD,
                                              rgXML.SBGENDER_COD,
                                              rgXML.NUCIVILSTATE_COD,
                                              rgXML.DTFECHANAC_COD,
                                              rgXML.NUSCHOOLGRADE_COD,
                                              rgXML.NUADDRESS_COD,
                                              rgXML.NUTELEFONOPREDIO_COD,
                                              rgXML.NUPERSONASCARGO_COD,
                                              rgXML.NUTIPOVIVIENDA_COD,
                                              rgXML.NUANTIGUEDADHOGAR_COD,
                                              rgXML.NURELACIONTITULAR_COD,
                                              rgXML.SBOCUPATION_COD,
                                              rgXML.SBNOMBREEMPRESA_COD,
                                              rgXML.NUADDRESSEMPRESA_COD,
                                              rgXML.NUTELEFONO1_COD,
                                              rgXML.NUTELEFONO2_COD,
                                              rgXML.NUTELEFONOMOVIL_COD,
                                              rgXML.NUANTIGUEDADLABORAL_COD,
                                              rgXML.SBACTIVIDAD_COD,
                                              rgXML.NUINGRESOS_COD,
                                              rgXML.NUEGRESOS_COD,
                                              rgXML.SBREFERENCIAFAMILIAR_COD,
                                              rgXML.SBTELEFONOREFEFAMI_COD,
                                              rgXML.SBMOVILREFEFAMI_COD,
                                              rgXML.NUADDRESSREFEFAMI_COD,
                                              rgXML.SBREFERENCIAPERSONAL_COD,
                                              rgXML.SBTELEFONOREFEPERSO_COD,
                                              rgXML.SBMOVILREFEPERSO_COD,
                                              rgXML.NUADDRESSREFEPERSO_COD,
                                              rgXML.SBREFERENCIACOMERCIAL_COD,
                                              rgXML.SBTELEFONOREFECOMER_COD,
                                              rgXML.SBMOVILREFECOMER_COD,
                                              rgXML.NUADDRESSREFECOMER_COD,
                                              rgXML.SBEMAIL_COD,
                                              ONUPACKAGEIDPU,
                                              rgXML.NUCATEGORY_COD,
                                              rgXML.NUSUBCATEGORY_COD,
                                              rgXML.NUTIPOCONTRACT_COD,
                                              rgXML.SBAPELLIDOS_COD,
                                              rgXML.SBFLAGDEUDORSOLI_COD,
                                              rgXML.NUCAUSALDEUSOLI_COD);
  
    proActualizaAddressCodeudorPU(ONUERRORCODE, OSBERRORMESSAGE);
    IF ONUERRORCODE <> 0 THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando codeudor PU [' ||
                               rgXML.SBINDENTIFICACION_COD || ']: ' ||
                               SQLERRM);
      RETURN;
    END IF;
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando codeudor PU [' ||
                               rgXML.SBINDENTIFICACION_COD || ']: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraCodeudorPU;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraDeudorCodeudor
  DESCRIPCION    : Servicio para registrar la relacion entre deudor y codeudor.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraDeudorCodeudor(ONUERRORCODE    OUT NUMBER,
                                      OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LDC_CODEUDORES.REGISTERCOSIGNERDATA(rgXML.NUIDENTYPE_COD,
                                        rgXML.SBINDENTIFICACION_COD,
                                        rgXML.SBFLAGDEUDORSOLI_COD,
                                        ONUPACKAGEID,
                                        rgXML.NUIDENTYPE,
                                        rgXML.SBINDENTIFICACION);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando deudor y codeudor: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraDeudorCodeudor;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraFechaEntrega
  DESCRIPCION    : Servicio para registrar la posible fecha de entrega del articulo.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraFechaEntrega(ONUERRORCODE    OUT NUMBER,
                                    OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BOFLOWFNBPACK.REGISTERDELIVDATE(ONUPACKAGEID, SYSDATE);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando fecha de entrega del articulo: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraFechaEntrega;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraDatosAdicionales
  DESCRIPCION    : Servicio para registrar datos adicionales a la venta.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraDatosAdicionales(ONUERRORCODE    OUT NUMBER,
                                        OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.REGADITIONALFNBINFO(ONUPACKAGEID,
                                              rgXML.NUCONTRACTID,
                                              rgXML.NUVALORAPROXSEG);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error registrando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proRegistraDatosAdicionales;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proActualizaDatosAdicionales
  DESCRIPCION    : Servicio para actualizar datos adicionales a la venta.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proActualizaDatosAdicionales(ONUERRORCODE    OUT NUMBER,
                                         OSBERRORMESSAGE OUT VARCHAR2) AS
  BEGIN
    LD_BONONBANKFINANCING.UPDADITIONALDATASALEFNB(ONUPACKAGEID,
                                                  rgXML.NUCUOTAAPROXMEN,
                                                  rgXML.NUVALORAPROXSEG,
                                                  rgXML.NUTOTALVENTA,
                                                  rgXML.SBFLAGTRASLADOCUPO);
    ONUERRORCODE    := 0;
    OSBERRORMESSAGE := 'OK';
  EXCEPTION
    WHEN OTHERS THEN
      ONUERRORCODE    := -1;
      OSBERRORMESSAGE := UPPER('Error actualizando datos adicionales: ' ||
                               SQLERRM);
      RETURN;
  END proActualizaDatosAdicionales;

  /*****************************************************************
  PROPIEDAD INTELECTUAL DE GDC (C).
  
  UNIDAD         : proRegistraVenta
  DESCRIPCION    : Servicio para descerializar xml de venta y realizar venta brilla.
  AUTOR          : SEBASTIAN TAPIAS
  FECHA          : 19/06/2018
  REQ            : 200-1511
  OBS            : Este servicio carga y/o usa valores de variables generales.
  
  FECHA             AUTOR                MODIFICACION
  =========       =========             ====================
  19-06-2018M      SEBTAP               REQ.2001511 Creacion
  ******************************************************************/
  PROCEDURE proRegistraVenta(isbXML       in CLOB,
                             onuPackage   out NUMBER,
                             onuErrorCodi out NUMBER,
                             osbErrorMsg  out VARCHAR2) AS
  
    ----------------------
    --Cursores.
    ----------------------
    CURSOR CUDIVXML(XMLVAL CLOB, TAG LDCI_OPERACION.TAG%TYPE) IS
      WITH LDCI_MESAENVWS AS
       (SELECT XMLTYPE(XMLVAL) AS STR_XML FROM DUAL)
      SELECT X.SUBXML
        FROM LDCI_MESAENVWS X,
             XMLTABLE(TAG PASSING STR_XML COLUMNS SUBXML XMLTYPE PATH '.') X;
  
    CURSOR cuXML(isbXMLDat IN CLOB, TAG LDCI_OPERACION.TAG%TYPE) IS
      SELECT DATOS."NUCONTRACTID",
             DATOS."NUCLIENTEID",
             DATOS."NUCUPOCREDITO",
             DATOS."NUCUPOUSADO",
             DATOS."NUCUPOEXTRAUSADO",
             DATOS."NUCUPOMANUALUSADO",
             DATOS."NUFACTID1",
             DATOS."NUFACTID2",
             DATOS."NUPUNTOVENTA",
             DATOS."NUCANALVENTA",
             DATOS."NUVENDEDORID",
             DATOS."DTFECHAVENTA",
             DATOS."NUPAGARED",
             DATOS."NUPAGAREM",
             DATOS."NUPAGAREUNICO",
             DATOS."NUVOUCHER",
             DATOS."NUMEDIORECEPID",
             DATOS."NUADRESSID",
             DATOS."SBFLAGPERIGRA",
             DATOS."SBFLAGENTREGPUNT",
             DATOS."NUCUOTAINI",
             DATOS."SBCOMMENT",
             DATOS."NUCONTRATISTAID",
             DATOS."NUIDENTYPE",
             DATOS."SBINDENTIFICACION",
             DATOS."SBTELEFONO",
             DATOS."SBNOMBRES",
             DATOS."SBAPELLIDOS",
             DATOS."SBEMAIL",
             DATOS."DTFECHANAC",
             DATOS."SBGENDER",
             DATOS."NUCIVILSTATE",
             DATOS."NUSCHOOLGRADE",
             DATOS."NUPROFESSION",
             DATOS."SBFLAGDEUCOD",
             DATOS."SBFLAGTITULAR",
             DATOS."NULUGAREXPECED",
             DATOS."DTFECHAEXPECED",
             DATOS."NUTELEFONOPREDIO",
             DATOS."NUPERSONASCARGO",
             DATOS."NUTIPOVIVIENDA",
             DATOS."NUANTIGUEDADHOGAR",
             DATOS."NURELACIONTITULAR",
             DATOS."SBOCUPATION",
             DATOS."SBNOMBREEMPRESA",
             DATOS."NUADDRESSEMPRESA",
             DATOS."NUTELEFONO1",
             DATOS."NUTELEFONO2",
             DATOS."NUTELEFONOMOVIL",
             DATOS."NUANTIGUEDADLABORAL",
             DATOS."SBACTIVIDAD",
             DATOS."NUINGRESOS",
             DATOS."NUEGRESOS",
             DATOS."SBREFERENCIAFAMILIAR",
             DATOS."SBTELEFONOREFEFAMI",
             DATOS."SBMOVILREFEFAMI",
             DATOS."NUADDRESSREFEFAMI",
             DATOS."SBREFERENCIAPERSONAL",
             DATOS."SBTELEFONOREFEPERSO",
             DATOS."SBMOVILREFEPERSO",
             DATOS."NUADDRESSREFEPERSO",
             DATOS."SBREFERENCIACOMERCIAL",
             DATOS."SBTELEFONOREFECOMER",
             DATOS."SBMOVILREFECOMER",
             DATOS."NUADDRESSREFECOMER",
             DATOS."NUCATEGORY",
             DATOS."NUSUBCATEGORY",
             DATOS."NUTIPOCONTRACT",
             DATOS."SBFLAGTITULAR_COD",
             DATOS."SBNOMBRES_COD",
             DATOS."NUIDENTYPE_COD",
             DATOS."SBINDENTIFICACION_COD",
             DATOS."NULUGAREXPECED_COD",
             DATOS."DTFECHAEXPECED_COD",
             DATOS."SBGENDER_COD",
             DATOS."NUCIVILSTATE_COD",
             DATOS."DTFECHANAC_COD",
             DATOS."NUSCHOOLGRADE_COD",
             DATOS."NUADDRESS_COD",
             DATOS."NUTELEFONOPREDIO_COD",
             DATOS."NUPERSONASCARGO_COD",
             DATOS."NUTIPOVIVIENDA_COD",
             DATOS."NUANTIGUEDADHOGAR_COD",
             DATOS."NURELACIONTITULAR_COD",
             DATOS."SBOCUPATION_COD",
             DATOS."SBNOMBREEMPRESA_COD",
             DATOS."NUADDRESSEMPRESA_COD",
             DATOS."NUTELEFONO1_COD",
             DATOS."NUTELEFONO2_COD",
             DATOS."NUTELEFONOMOVIL_COD",
             DATOS."NUANTIGUEDADLABORAL_COD",
             DATOS."SBACTIVIDAD_COD",
             DATOS."NUINGRESOS_COD",
             DATOS."NUEGRESOS_COD",
             DATOS."SBREFERENCIAFAMILIAR_COD",
             DATOS."SBTELEFONOREFEFAMI_COD",
             DATOS."SBMOVILREFEFAMI_COD",
             DATOS."NUADDRESSREFEFAMI_COD",
             DATOS."SBREFERENCIAPERSONAL_COD",
             DATOS."SBTELEFONOREFEPERSO_COD",
             DATOS."SBMOVILREFEPERSO_COD",
             DATOS."NUADDRESSREFEPERSO_COD",
             DATOS."SBREFERENCIACOMERCIAL_COD",
             DATOS."SBTELEFONOREFECOMER_COD",
             DATOS."SBMOVILREFECOMER_COD",
             DATOS."NUADDRESSREFECOMER_COD",
             DATOS."SBEMAIL_COD",
             DATOS."NUCATEGORY_COD",
             DATOS."NUSUBCATEGORY_COD",
             DATOS."NUTIPOCONTRACT_COD",
             DATOS."SBAPELLIDOS_COD",
             DATOS."SBFLAGDEUDORSOLI_COD",
             DATOS."NUCAUSALDEUSOLI_COD",
             DATOS."SBDIRECCION_COD",
             DATOS."NUVALORAPROXSEG",
             DATOS."NUCUOTAAPROXMEN",
             DATOS."NUCUOTAAPROXMENSEG",
             DATOS."NUTOTALVENTA",
             DATOS."SBFLAGTRASLADOCUPO"
        FROM XMLTable(TAG PASSING XMLType(isbXMLDat) COLUMNS "NUCONTRACTID"
                      NUMBER PATH 'idContrato',
                      "NUCLIENTEID" NUMBER PATH 'idCliente',
                      "NUCUPOCREDITO" NUMBER PATH 'cupoCredito',
                      "NUCUPOUSADO" NUMBER PATH 'cupoUsado',
                      "NUCUPOEXTRAUSADO" NUMBER PATH 'cupoExtraUsado',
                      "NUCUPOMANUALUSADO" NUMBER PATH 'cupoManualUsado',
                      "NUFACTID1" NUMBER PATH 'idFactura1',
                      "NUFACTID2" NUMBER PATH 'idFactura2',
                      "NUPUNTOVENTA" NUMBER PATH 'puntoVenta',
                      "NUCANALVENTA" NUMBER PATH 'canalVenta',
                      "NUVENDEDORID" NUMBER PATH 'idVendedor',
                      "DTFECHAVENTA" VARCHAR(100) PATH 'fechaVenta',
                      "NUPAGARED" VARCHAR(30) PATH 'pagareDigital',
                      "NUPAGAREM" VARCHAR(30) PATH 'pagareManual',
                      "NUPAGAREUNICO" VARCHAR(30) PATH 'pagareUnico',
                      "NUVOUCHER" NUMBER PATH 'voucher',
                      "NUMEDIORECEPID" NUMBER PATH 'medioRecepcion',
                      "NUADRESSID" NUMBER PATH 'idDireccion',
                      "SBFLAGPERIGRA" VARCHAR(1) PATH 'periodoGracia',
                      "SBFLAGENTREGPUNT" VARCHAR(1) PATH 'entregaPunto',
                      "NUCUOTAINI" NUMBER PATH 'cuotaInicial',
                      "SBCOMMENT" VARCHAR(2000) PATH 'comentarios',
                      "NUCONTRATISTAID" NUMBER PATH 'idContratista',
                      "NUIDENTYPE" NUMBER PATH 'deudor/tipoIdentificacion',
                      "SBINDENTIFICACION" VARCHAR2(20) PATH
                      'deudor/identificacion',
                      "SBTELEFONO" VARCHAR2(50) PATH 'deudor/telefono',
                      "SBNOMBRES" VARCHAR2(100) PATH 'deudor/nombre',
                      "SBAPELLIDOS" VARCHAR2(100) PATH 'deudor/apellido',
                      "SBEMAIL" VARCHAR2(100) PATH 'deudor/email',
                      "DTFECHANAC" VARCHAR(100) PATH
                      'deudor/fechaNacimiento',
                      "SBGENDER" VARCHAR2(1) PATH 'deudor/genero',
                      "NUCIVILSTATE" NUMBER PATH 'deudor/estadoCivil',
                      "NUSCHOOLGRADE" NUMBER PATH 'deudor/nivelEstudios',
                      "NUPROFESSION" NUMBER PATH 'deudor/profesion',
                      "SBFLAGDEUCOD" VARCHAR2(1) PATH 'deudor/tipoDeudor',
                      "SBFLAGTITULAR" VARCHAR2(1) PATH 'deudor/esTitular',
                      "NULUGAREXPECED" NUMBER PATH 'deudor/lugarExpCedula',
                      "DTFECHAEXPECED" VARCHAR(100) PATH
                      'deudor/fechaExpCedula',
                      "NUTELEFONOPREDIO" NUMBER PATH 'deudor/telefonoPredio',
                      "NUPERSONASCARGO" NUMBER PATH 'deudor/personasCargo',
                      "NUTIPOVIVIENDA" NUMBER PATH 'deudor/tipoVivienda',
                      "NUANTIGUEDADHOGAR" NUMBER PATH
                      'deudor/antiguedadVivienda',
                      "NURELACIONTITULAR" NUMBER PATH
                      'deudor/relacionTitular',
                      "SBOCUPATION" VARCHAR2(100) PATH 'deudor/ocupacion',
                      "SBNOMBREEMPRESA" VARCHAR2(100) PATH 'deudor/empresa',
                      "NUADDRESSEMPRESA" NUMBER PATH
                      'deudor/direccionEmpresa',
                      "NUTELEFONO1" NUMBER PATH 'deudor/telefono1',
                      "NUTELEFONO2" NUMBER PATH 'deudor/telefono2',
                      "NUTELEFONOMOVIL" NUMBER PATH 'deudor/movil',
                      "NUANTIGUEDADLABORAL" NUMBER PATH
                      'deudor/antiguedadLaboral',
                      "SBACTIVIDAD" VARCHAR2(100) PATH 'deudor/actividad',
                      "NUINGRESOS" NUMBER PATH 'deudor/ingresosMensuales',
                      "NUEGRESOS" NUMBER PATH 'deudor/gastosMensuales',
                      "SBREFERENCIAFAMILIAR" VARCHAR2(200) PATH
                      'deudor/referenciaFamiliar',
                      "SBTELEFONOREFEFAMI" VARCHAR2(20) PATH
                      'deudor/telefonoRefFamiliar',
                      "SBMOVILREFEFAMI" VARCHAR2(20) PATH
                      'deudor/movilRefFamiliar',
                      "NUADDRESSREFEFAMI" NUMBER PATH
                      'deudor/direccionRefFamiliar',
                      "SBREFERENCIAPERSONAL" VARCHAR2(200) PATH
                      'deudor/referenciaPersonal',
                      "SBTELEFONOREFEPERSO" VARCHAR2(20) PATH
                      'deudor/telefonoRefPersonal',
                      "SBMOVILREFEPERSO" VARCHAR2(20) PATH
                      'deudor/movilRefPersonal',
                      "NUADDRESSREFEPERSO" NUMBER PATH
                      'deudor/direccionRefPersonal',
                      "SBREFERENCIACOMERCIAL" VARCHAR2(200) PATH
                      'deudor/referenciaComercial',
                      "SBTELEFONOREFECOMER" VARCHAR2(20) PATH
                      'deudor/telefonoRefComercial',
                      "SBMOVILREFECOMER" VARCHAR2(20) PATH
                      'deudor/movilRefComercial',
                      "NUADDRESSREFECOMER" NUMBER PATH
                      'deudor/direccionRefComercial',
                      "NUCATEGORY" NUMBER PATH 'deudor/idCategoria',
                      "NUSUBCATEGORY" NUMBER PATH 'deudor/idSubcategoria',
                      "NUTIPOCONTRACT" NUMBER PATH 'deudor/tipoContrato',
                      "SBFLAGTITULAR_COD" VARCHAR2(1) PATH
                      'codeudor/esTitular',
                      "SBNOMBRES_COD" VARCHAR2(100) PATH 'codeudor/nombre',
                      "NUIDENTYPE_COD" NUMBER PATH
                      'codeudor/tipoIdentificacion',
                      "SBINDENTIFICACION_COD" VARCHAR2(20) PATH
                      'codeudor/identificacion',
                      "NULUGAREXPECED_COD" NUMBER PATH
                      'codeudor/lugarExpCedula',
                      "DTFECHAEXPECED_COD" VARCHAR(100) PATH
                      'codeudor/fechaExpCedula',
                      "SBGENDER_COD" VARCHAR2(1) PATH 'codeudor/genero',
                      "NUCIVILSTATE_COD" NUMBER PATH 'codeudor/estadoCivil',
                      "DTFECHANAC_COD" VARCHAR(100) PATH
                      'codeudor/fechaNacimiento',
                      "NUSCHOOLGRADE_COD" NUMBER PATH
                      'codeudor/nivelEstudios',
                      "NUADDRESS_COD" NUMBER PATH 'codeudor/idDireccion',
                      "NUTELEFONOPREDIO_COD" NUMBER PATH
                      'codeudor/telefonoPredio',
                      "NUPERSONASCARGO_COD" NUMBER PATH
                      'codeudor/personasCargo',
                      "NUTIPOVIVIENDA_COD" NUMBER PATH
                      'codeudor/tipoVivienda',
                      "NUANTIGUEDADHOGAR_COD" NUMBER PATH
                      'codeudor/antiguedadVivienda',
                      "NURELACIONTITULAR_COD" NUMBER PATH
                      'codeudor/relacionTitular',
                      "SBOCUPATION_COD" VARCHAR2(100) PATH
                      'codeudor/ocupacion',
                      "SBNOMBREEMPRESA_COD" VARCHAR2(100) PATH
                      'codeudor/empresa',
                      "NUADDRESSEMPRESA_COD" NUMBER PATH
                      'codeudor/direccionEmpresa',
                      "NUTELEFONO1_COD" NUMBER PATH 'codeudor/telefono1',
                      "NUTELEFONO2_COD" NUMBER PATH 'codeudor/telefono2',
                      "NUTELEFONOMOVIL_COD" NUMBER PATH 'codeudor/movil',
                      "NUANTIGUEDADLABORAL_COD" NUMBER PATH
                      'codeudor/antiguedadLaboral',
                      "SBACTIVIDAD_COD" VARCHAR2(100) PATH
                      'codeudor/actividad',
                      "NUINGRESOS_COD" NUMBER PATH
                      'codeudor/ingresosMensuales',
                      "NUEGRESOS_COD" NUMBER PATH 'codeudor/gastosMensuales',
                      "SBREFERENCIAFAMILIAR_COD" VARCHAR2(200) PATH
                      'codeudor/referenciaFamiliar',
                      "SBTELEFONOREFEFAMI_COD" VARCHAR2(20) PATH
                      'codeudor/telefonoRefFamiliar',
                      "SBMOVILREFEFAMI_COD" VARCHAR2(20) PATH
                      'codeudor/movilRefFamiliar',
                      "NUADDRESSREFEFAMI_COD" NUMBER PATH
                      'codeudor/direccionRefFamiliar',
                      "SBREFERENCIAPERSONAL_COD" VARCHAR2(200) PATH
                      'codeudor/referenciaPersonal',
                      "SBTELEFONOREFEPERSO_COD" VARCHAR2(20) PATH
                      'codeudor/telefonoRefPersonal',
                      "SBMOVILREFEPERSO_COD" VARCHAR2(20) PATH
                      'codeudor/movilRefPersonal',
                      "NUADDRESSREFEPERSO_COD" NUMBER PATH
                      'codeudor/direccionRefPersonal',
                      "SBREFERENCIACOMERCIAL_COD" VARCHAR2(200) PATH
                      'codeudor/referenciaComercial',
                      "SBTELEFONOREFECOMER_COD" VARCHAR2(20) PATH
                      'codeudor/telefonoRefComercial',
                      "SBMOVILREFECOMER_COD" VARCHAR2(20) PATH
                      'codeudor/movilRefComercial',
                      "NUADDRESSREFECOMER_COD" NUMBER PATH
                      'codeudor/direccionRefComercial',
                      "SBEMAIL_COD" VARCHAR2(100) PATH 'codeudor/email',
                      "NUCATEGORY_COD" NUMBER PATH 'codeudor/idCategoria',
                      "NUSUBCATEGORY_COD" NUMBER PATH
                      'codeudor/idSubcategoria',
                      "NUTIPOCONTRACT_COD" NUMBER PATH
                      'codeudor/tipoContrato',
                      "SBAPELLIDOS_COD" VARCHAR2(100) PATH
                      'codeudor/apellido',
                      "SBFLAGDEUDORSOLI_COD" VARCHAR2(1) PATH
                      'codeudor/esDeudorSolidario',
                      "NUCAUSALDEUSOLI_COD" NUMBER PATH
                      'codeudor/causalDeudorSolidario',
                      "SBDIRECCION_COD" VARCHAR2(200) PATH
                      'codeudor/direccionParseada',
                      "NUVALORAPROXSEG" NUMBER PATH 'valorAproxSeguro',
                      "NUCUOTAAPROXMEN" NUMBER PATH 'cuotaAproxMensual',
                      "NUCUOTAAPROXMENSEG" NUMBER PATH
                      'cuotaAproxMensualSeguro',
                      "NUTOTALVENTA" NUMBER PATH 'valorVenta',
                      "SBFLAGTRASLADOCUPO" VARCHAR(1) PATH 'trasladoCupo') AS DATOS;
  
    CURSOR CUVALXML(VAL CLOB, TAG LDCI_OPERACION.TAG%TYPE) IS
      SELECT DATOS.IDENTIFICADOR_DEL_ARTICULO,
             DATOS.VALOR_UNITARIO,
             DATOS.CANTIDAD_DE_ARTICULOS,
             DATOS.NUMERO_DE_CUOTAS,
             DATOS.FECHA_DE_PRIMERA_CUOTA,
             DATOS.CODIGO_DEL_PLAN_DE_DIFERIDO,
             DATOS.IVA,
             DATOS.NUCUPOEXTRAID,
             --Inicio Cambio solicitado por el Ing. Eduardo Aguera
             DATOS.NUCUPOEXTRAUSADO
      --Inicio Cambio solicitado por el Ing. Eduardo Aguera
        FROM XMLTABLE(TAG PASSING XMLTYPE(VAL) COLUMNS
                      IDENTIFICADOR_DEL_ARTICULO NUMBER PATH 'idArticulo',
                      VALOR_UNITARIO NUMBER PATH 'valor',
                      CANTIDAD_DE_ARTICULOS NUMBER PATH 'cantidad',
                      NUMERO_DE_CUOTAS NUMBER PATH 'cuotas',
                      FECHA_DE_PRIMERA_CUOTA VARCHAR(100) PATH
                      'fechaPrimeraCuota',
                      CODIGO_DEL_PLAN_DE_DIFERIDO NUMBER PATH
                      'idPlanFinaciacion',
                      IVA NUMBER PATH 'iva',
                      NUCUPOEXTRAID NUMBER PATH 'idCupoExtra',
                      NUCUPOEXTRAUSADO NUMBER PATH 'cupoExtraUsado') AS DATOS;
  
    CURSOR cuVendedor(Punto cc_orga_area_seller.organizat_area_id%type) IS
      SELECT person_id
        FROM cc_orga_area_seller
       WHERE IS_current = 'Y'
         and organizat_area_id = Punto
         AND rownum = 1;
  
    ----------------------
    --Variables.
    ----------------------
    rgXmlArti CUVALXML%ROWTYPE; --Para manejar los articulos
  
    TagDatos   VARCHAR2(100) := '/venta'; --Tag para partir los datos
    SubTagArti VARCHAR2(100) := '/venta/articulos/articulo'; -- Tag para sacar los articulos [Grupo]
    TagUnArti  VARCHAR2(100) := '/articulo'; --Tag para sacar los articulos [Uno a Uno]
  
    ISBREQUESTXML    VARCHAR2(32767); --Para almacenar el XML principal
    SBXMLARTICULOS   VARCHAR2(32767); -- Para almacenar el XML de Articulos
    NUVENTADUPLICADA NUMBER := NULL; -- Para validar venta duplicadas
  
    --Caso 200-2375 DVM
    nuTitularVeri number;
    v_id_registro number;
    vlrFinanciar  number;
    numDet        number;
  
  BEGIN
  
    /*Seteo de variables*/
    rgXML := null;
    NUEXTRAQUOTA     := null;
    NUEXTRAQUOTAUSED := null;
    ONUPACKAGEID     := null;
    ONUPACKAGEIDPU   := null;
    ONUMOTIVEID      := null;
    NUPROMISSORY_ID  := null;
    SBUSEDPAGAREU    := FALSE;
    NUCANTCUOTAS     := null;
    ISBREQUESTXML    := null;
    SBXMLARTICULOS   := null;
    NUVENTADUPLICADA := null;
    nuTitularVeri    := null;
    v_id_registro    := null;
    vlrFinanciar     := null;
    numDet           := null;
  
    BEGIN
      --Se saca los datos principales del XML General
      OPEN cuXML(isbXML, TagDatos);
      FETCH cuXML
        INTO rgXML; -- se asigna a variable general tipo tabla.
      IF cuXML%NOTFOUND THEN
        onuErrorCodi := -1;
        osbErrorMsg  := UPPER('No se encontraron datos en el mensaje de la venta');
        RAISE EX.CONTROLLED_ERROR;
      END IF;
      CLOSE cuXML;
    EXCEPTION
      WHEN OTHERS THEN
        onuErrorCodi := -1;
        osbErrorMsg  := UPPER('Error deserializando el mensaje de la venta: ' ||
                              SQLERRM);
        RAISE EX.CONTROLLED_ERROR;
    END;
  
    /*
    --Se comenta bajo el caso 200-2480, para evitar que registre un vendedor aleatoreamente.
    --Obtiene el vendedor asociado al punto de venta
    open cuVendedor(rgXML.NUPUNTOVENTA);
    fetch cuVendedor
      INTO rgXML.NUVENDEDORID;
    close cuVendedor;
    */
    --SE REALIZA VALIDACION DE CAMPOS
    proValidaCampos(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    ----------------------
    --Armado XML.
    ----------------------
  
    ISBREQUESTXML := '<?xml version= "1.0" encoding= "ISO-8859-1" ?>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML ||
                     '<P_VENTA_FNB_100264 ID_TIPOPAQUETE= "100264">' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CONTRACT>' || rgXML.NUCONTRACTID ||
                     '</CONTRACT>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<IDENTIFICADOR_DEL_CLIENTE>' ||
                     rgXML.NUCLIENTEID || '</IDENTIFICADOR_DEL_CLIENTE>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CUPO_DE_CREDITO >' ||
                     rgXML.NUCUPOCREDITO || '</CUPO_DE_CREDITO>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CUPO_USADO >' || rgXML.NUCUPOUSADO ||
                     '</CUPO_USADO>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<EXTRA_CUPO_USADO >' ||
                     rgXML.NUCUPOEXTRAUSADO || '</EXTRA_CUPO_USADO>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CUPO_MANUAL_USADO >' ||
                     rgXML.NUCUPOMANUALUSADO || '</CUPO_MANUAL_USADO>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML ||
                     '<IDENTIFICADOR_DE_LA_PRIMERA_FACTURA >' ||
                     rgXML.NUFACTID1 ||
                     '</IDENTIFICADOR_DE_LA_PRIMERA_FACTURA>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML ||
                     '<IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA >' ||
                     rgXML.NUFACTID2 ||
                     '</IDENTIFICADOR_DE_LA_SEGUNDA_FACTURA>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<OPERATING_UNIT_ID >' ||
                     rgXML.NUPUNTOVENTA || '</OPERATING_UNIT_ID>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<SALE_CHANNEL_ID>' ||
                     rgXML.NUCANALVENTA || '</SALE_CHANNEL_ID >' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<ID>' || rgXML.NUVENDEDORID ||
                     '</ID>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<VENDEDOR >' || rgXML.NUVENDEDORID ||
                     '</VENDEDOR>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<FECHA_DE_VENTA>' ||
                     TO_DATE(TO_CHAR(TO_DATE(rgXML.DTFECHAVENTA,
                                             'DD/MM/YYYY HH24:MI:SS'),
                                     'DD/MM/YYYY HH24:MI:SS'),
                             'DD-MM-YYYY HH24:MI:SS') ||
                     '</FECHA_DE_VENTA>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<FECHA_DE_SOLICITUD>' ||
                     TO_DATE(TO_CHAR(SYSDATE, 'DD/MM/YYYY HH24:MI:SS'),
                             'DD-MM-YYYY HH24:MI:SS') ||
                     '</FECHA_DE_SOLICITUD>' || chr(10);
  
    --Caso 200-2375
    --validacion de titularidad del Deudor en contrato
    --Data XML no siempre corresponde
    select count(1)
      into nuTitularVeri
      from suscripc s, ge_subscriber g
     where s.susccodi = rgXML.NUCONTRACTID
       and s.suscclie = rgXML.NUCLIENTEID
       and g.subscriber_id = s.suscclie
       and g.identification = rgXML.SBINDENTIFICACION;
    --Validacion sobre los caso de No titularidad
    --21/02/2019
    if nuTitularVeri = 0 then
      IF rgXML.SBFLAGTITULAR = 'Y' THEN
        nuTitularVeri := 1;
      end if;
    end if;
    ---
  
    /*Se realizan validaciones correspondientes a los pagare*/
  
    IF rgXML.NUPAGAREM IS NOT NULL THEN
      ISBREQUESTXML   := ISBREQUESTXML ||
                         '<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL/>' || chr(10);
      ISBREQUESTXML   := ISBREQUESTXML ||
                         '<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>' ||
                         rgXML.NUPAGAREM ||
                         '</ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>' ||
                         chr(10);
      NUPROMISSORY_ID := rgXML.NUPAGAREM;
    
      -- Se valida que este asociado al proveedor.
      proValidateNumberFNB(onuErrorCodi, osbErrorMsg);
    
      -------------------------------------
      --Si es titular se crea pagare unico.
      -------------------------------------
      --IF rgXML.SBFLAGTITULAR = 'Y' THEN
      --200-2375 se reemplaza la condicion de titular por la nueva validacion
      if nuTitularVeri > 0 then
        --Valida existencia del Pagare Unico
        proValidaPagare2(rgXML.NUPAGAREM, onuErrorCodi, osbErrorMsg);
      
        -- 0 Valido para venta.
        -- -1 No es valido para venta(por estado) y/o Error del proceso
        -- 1 El pagare no existe por tanto se crea.
      
        IF onuErrorCodi NOT IN (0, 1) THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        IF onuErrorCodi = 1 THEN
        
          --Crear Pagare
          proRegistraSolicitudPagare(rgXML.NUPAGAREM,
                                     onuErrorCodi,
                                     osbErrorMsg);
        
          IF onuErrorCodi <> 0 THEN
            RAISE EX.CONTROLLED_ERROR;
          END IF;
        
        END IF;
      
        IF onuErrorCodi <> 0 THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        SBUSEDPAGAREU := TRUE; --Se indica que se uso pagare unico para previo registro
      ELSE
        null;
      END IF;
      -------------------------------------
      --Fin creacion Pagare Unico.
      -------------------------------------
    
    ELSIF rgXML.NUPAGAREUNICO IS NOT NULL THEN
    
      ISBREQUESTXML := ISBREQUESTXML ||
                       '<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL/>' || chr(10);
      ISBREQUESTXML := ISBREQUESTXML ||
                       '<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>' ||
                       rgXML.NUPAGAREUNICO ||
                       '</ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL>' || chr(10);
    
      NUPROMISSORY_ID := rgXML.NUPAGAREUNICO;
    
      --Caso 200-2375
      --se agrega la solicitud de creacion del pagare
      -------------------------------------
      --Si es titular se crea pagare unico.
      -------------------------------------
      --IF rgXML.SBFLAGTITULAR = 'Y' THEN
      --200-2375 se reemplaza la condicion de titular por la nueva validacion
      if nuTitularVeri > 0 then
        --Valida existencia del Pagare Unico
        proValidaPagare2(rgXML.NUPAGAREUNICO, onuErrorCodi, osbErrorMsg);
      
        -- 0 Valido para venta.
        -- -1 No es valido para venta(por estado) y/o Error del proceso
        -- 1 El pagare no existe por tanto se crea.
      
        IF onuErrorCodi NOT IN (0, 1) THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        IF onuErrorCodi = 1 THEN
        
          --Crear Pagare
          proRegistraSolicitudPagare(rgXML.NUPAGAREUNICO,
                                     onuErrorCodi,
                                     osbErrorMsg);
        
          IF onuErrorCodi <> 0 THEN
            RAISE EX.CONTROLLED_ERROR;
          END IF;
        
        END IF;
      
        IF onuErrorCodi <> 0 THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        SBUSEDPAGAREU := TRUE; --Se indica que se uso pagare unico para previo registro
      ELSE
        null;
      END IF;
      -------------------------------------
      --Fin creacion Pagare Unico.
      -------------------------------------
      ---
    
    ELSIF rgXML.NUPAGARED IS NOT NULL THEN
      ISBREQUESTXML   := ISBREQUESTXML ||
                         '<ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>' ||
                         rgXML.NUPAGARED ||
                         '</ID_DEL_CONSECUTIVO_PAGARE_DIGITAL>' || chr(10);
      ISBREQUESTXML   := ISBREQUESTXML ||
                         '<ID_DEL_CONSECUTIVO_DE_PAGARE_MANUAL/>' ||
                         chr(10);
      NUPROMISSORY_ID := rgXML.NUPAGARED;
    
      -------------------------------------
      --Si es titular se crea pagare unico.
      -------------------------------------
      --IF rgXML.SBFLAGTITULAR = 'Y' THEN
      --200-2375 se reemplaza la condicion de titular por la nueva validacion
      if nuTitularVeri > 0 then
        --Valida existencia del Pagare Unico
        --Caso 200-2375
        --Se modifico el pagare Unico
        proValidaPagare2(rgXML.NUPAGARED, onuErrorCodi, osbErrorMsg);
      
        -- 0 Valido para venta.
        -- -1 No es valido para venta(por estado) y/o Error del proceso
        -- 1 El pagare no existe por tanto se crea.
      
        IF onuErrorCodi NOT IN (0, 1) THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        IF onuErrorCodi = 1 THEN
        
          --Crear Pagare
          --Caso 200-2375
          --Se modifico el Pagare
          proRegistraSolicitudPagare(rgXML.NUPAGARED,
                                     onuErrorCodi,
                                     osbErrorMsg);
        
          IF onuErrorCodi <> 0 THEN
            RAISE EX.CONTROLLED_ERROR;
          END IF;
        
        END IF;
      
        IF onuErrorCodi <> 0 THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      
        SBUSEDPAGAREU := TRUE; --Se indica que se uso pagare unico para previo registro
      ELSE
        null;
      END IF;
      -------------------------------------
      --Fin creacion Pagare Unico.
      -------------------------------------
    END IF;
  
    /*Se continua con el armado*/
  
    ISBREQUESTXML := ISBREQUESTXML || '<RECEPTION_TYPE_ID>' ||
                     rgXML.NUMEDIORECEPID || '</RECEPTION_TYPE_ID>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CONTACT_ID >' || rgXML.NUCLIENTEID ||
                     '</CONTACT_ID>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<ADDRESS_ID>' || rgXML.NUADRESSID ||
                     '</ADDRESS_ID>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<TOMO_EL_PERIODO_DE_GRACIA>' ||
                     rgXML.SBFLAGPERIGRA || '</TOMO_EL_PERIODO_DE_GRACIA>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<ENTREGA_EN_PUNTO>' ||
                     rgXML.SBFLAGENTREGPUNT || '</ENTREGA_EN_PUNTO>' ||
                     chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<CUOTA_INICIAL>' || rgXML.NUCUOTAINI ||
                     '</CUOTA_INICIAL>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<COMMENT_>' ||
                     '[FIFAP - PORTAL BRILLA]' || rgXML.SBCOMMENT ||
                     '</COMMENT_>' || chr(10);
    ISBREQUESTXML := ISBREQUESTXML || '<USUARIO_DEL_SERVICIO>' ||
                     rgXML.NUCLIENTEID || '</USUARIO_DEL_SERVICIO>' ||
                     chr(10);
  
    --------------------------
    --Armado XML de Articulos.
    --------------------------
  
    /*Se saca el XML de articulos del XML General*/
    FOR REGDET IN CUDIVXML(isbXML, SubTagArti) LOOP
      BEGIN
        /*Se obtiene cada uno de los XML correspondiente a cada articulo*/
        OPEN CUVALXML(REGDET.SUBXML.GETSTRINGVAL(), TagUnArti);
        FETCH CUVALXML
          INTO rgXmlArti; -- se asignan los datos obtenidos de los articulos a la variable.
        IF CUVALXML%NOTFOUND THEN
          onuErrorCodi := -1;
          osbErrorMsg  := UPPER('No se encontraron datos en el registro de articulos');
          RAISE EX.CONTROLLED_ERROR;
        END IF;
        CLOSE CUVALXML;
      EXCEPTION
        WHEN OTHERS THEN
          onuErrorCodi := -1;
          osbErrorMsg  := UPPER('Error deserializando el registro de articulos: ' ||
                                SQLERRM);
          RAISE EX.CONTROLLED_ERROR;
      END;
    
      /*Se empieza armado del XML por cada articulo*/
    
      SBXMLARTICULOS := SBXMLARTICULOS || '<M_INSTALACION_DE_GAS_100271>' ||
                        chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<IDENTIFICADOR_DEL_MOTIVO />' ||
                        chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS ||
                        '<ID_DE_LA_SOLICITUD_DE_FINANCIACION_NO_BANCARIA />' ||
                        chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<IDENTIFICADOR_DEL_ARTICULO>' ||
                        rgXmlArti.IDENTIFICADOR_DEL_ARTICULO ||
                        '</IDENTIFICADOR_DEL_ARTICULO>' || chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<VALOR_UNITARIO>' ||
                        rgXmlArti.VALOR_UNITARIO || '</VALOR_UNITARIO>' ||
                        chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<CANTIDAD_DE_ARTICULOS>' ||
                        rgXmlArti.CANTIDAD_DE_ARTICULOS ||
                        '</CANTIDAD_DE_ARTICULOS>' || chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<NUMERO_DE_CUOTAS>' ||
                        rgXmlArti.NUMERO_DE_CUOTAS || '</NUMERO_DE_CUOTAS>' ||
                        chr(10);
    
      --Se asigna el numero de cuotas
      IF rgXmlArti.NUMERO_DE_CUOTAS > NUCANTCUOTAS THEN
        NUCANTCUOTAS := rgXmlArti.NUMERO_DE_CUOTAS;
      END IF;
    
      SBXMLARTICULOS := SBXMLARTICULOS || '<FECHA_DE_PRIMERA_CUOTA>' ||
                        TRUNC(TO_DATE(TO_CHAR(TO_DATE(rgXmlArti.FECHA_DE_PRIMERA_CUOTA,
                                                      'DD/MM/YYYY'),
                                              'DD/MM/YYYY'),
                                      'DD-MM-YYYY')) ||
                        '</FECHA_DE_PRIMERA_CUOTA>' || chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<CODIGO_DEL_PLAN_DE_DIFERIDO>' ||
                        rgXmlArti.CODIGO_DEL_PLAN_DE_DIFERIDO ||
                        '</CODIGO_DEL_PLAN_DE_DIFERIDO>' || chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '<IVA>' || rgXmlArti.IVA ||
                        '</IVA>' || chr(10);
      SBXMLARTICULOS := SBXMLARTICULOS || '</M_INSTALACION_DE_GAS_100271>' ||
                        chr(10);
    
      /*REGISTRO DE CUPO EXTRA POR ARTICULO*/
      IF rgXmlArti.NUCUPOEXTRAID IS NOT NULL THEN
        BEGIN
          LD_BONONBANKFINANCING.REGISTEREXTRAQUOTAFNB(rgXmlArti.NUCUPOEXTRAID,
                                                      rgXML.NUCONTRACTID,
                                                      --Inicio Cambio solicitado por el Ing. Eduardo Aguera
                                                      rgXmlArti.Nucupoextrausado --'Y'
                                                      --Inicio Cambio solicitado por el Ing. Eduardo Aguera
                                                      );
        EXCEPTION
          WHEN OTHERS THEN
            onuErrorCodi := -1;
            osbErrorMsg  := UPPER('Error registrando cupo extra por articulo');
            RAISE EX.CONTROLLED_ERROR;
        END;
        -- Se asigna ultimo CupoExtra obtenido a la variable general.
        NUEXTRAQUOTA := rgXmlArti.NUCUPOEXTRAID;
        --Inicio Cambio solicitado por el Ing. Eduardo Aguera
        NUEXTRAQUOTAUSED := rgXmlArti.Nucupoextrausado;
        --Inicio Cambio solicitado por el Ing. Eduardo Aguera
      END IF;
    
    END LOOP; --Fin LOOP de articulos.
  
    /*Se concatena el XML de articulos al XML General*/
  
    ISBREQUESTXML := ISBREQUESTXML || SBXMLARTICULOS;
  
    ISBREQUESTXML := ISBREQUESTXML || '</P_VENTA_FNB_100264>' || chr(10);
  
    ----------------------
    --Fin Armado XML.
    ----------------------
  
    ------------------------------------------------------------------------
    --REGISTRO DE VENTA.
    --Se envia el XML armado en la venta y se retorna el ID de la solicitud
    ------------------------------------------------------------------------
  
    OS_RegisterRequestWithXML(ISBREQUESTXML,
                              ONUPACKAGEID,
                              ONUMOTIVEID,
                              onuErrorCodi,
                              osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
    --Se asigna solicitud a la variable de salida.
    onuPackage := ONUPACKAGEID;
  
    --------------------------
    -- FIN REGISTRO DE VENTA.
    --------------------------
  
    ------------------------------------------------------------------------------
    /**********************PROCESOS ADICIONALES EN LA VENTA**********************/
    ------------------------------------------------------------------------------
  
    --VALIDACION DE VENTAS DUPLICADAS.
    NUVENTADUPLICADA := LDC_FNUREALIZAVENTA(ONUPACKAGEID);
  
    IF NUVENTADUPLICADA = 0 THEN
      onuErrorCodi := -1;
      osbErrorMsg  := 'VENTA DUPLICADA';
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --REGISTRO DE CUPO EXTRA
    IF (NUEXTRAQUOTA IS NOT NULL) THEN
      proRegistraExtraCupo(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
    END IF;
  
    --INSTALACION DE ARTICULOS.
    --proRegistraInstalArticulo(onuErrorCodi, osbErrorMsg);
    --IF onuErrorCodi <> 0 THEN
    --  RAISE EX.CONTROLLED_ERROR;
    --END IF;
  
    ------------------------------------------------------------------------------
    /*******************REGISTRO DE DATOS DEL DEUDOR Y CODEUDOR******************/
    ------------------------------------------------------------------------------
  
    --REGISTRO DEL DEUDOR.
    proRegistraDeudor(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --ACTUALIZA EL DEUDOR
    proActualizaDeudor(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --SI EXISTE IDENTIFICACION DEL CODEUDOR REGISTRA Y ACTUALIZA LOS DATOS
    IF rgXML.SBINDENTIFICACION_COD IS NOT NULL THEN
      --REGISTRA CODEUDOR
      proRegistraCodeudor(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
      --ACTUALIZA CODEUDOR
      proActualizaCodeudor(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
      --REGISTRA RELACION DEUDOR CODEUDOR
      proRegistraDeudorCodeudor(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
    END IF;
  
    ------------------------------------------------------------------------------
    /**********************PROCESOS ADICIONALES EN LA VENTA**********************/
    ------------------------------------------------------------------------------
  
    --FECHA DE POSIBLE ENTREGA DEL ART?CULO.
    proRegistraFechaEntrega(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --DATOS ADICIONALES DE LA VENTA.
    proRegistraDatosAdicionales(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --ACTUALIZACI?N DE DATOS DE LA VENTA.
    proActualizaDatosAdicionales(onuErrorCodi, osbErrorMsg);
    IF onuErrorCodi <> 0 THEN
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    --REGISTRO DE INFORMACION ADICONAL PARA EL PAGARE UNICO
    IF SBUSEDPAGAREU = TRUE THEN
      proRegistraInformacionPagare(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
      onuErrorCodi := null;
      osbErrorMsg  := null;
      proRegistraDeudorPU(onuErrorCodi, osbErrorMsg);
      IF onuErrorCodi <> 0 THEN
        RAISE EX.CONTROLLED_ERROR;
      END IF;
      onuErrorCodi := null;
      osbErrorMsg  := null;
      IF rgXML.SBINDENTIFICACION_COD IS NOT NULL THEN
        proRegistraCodeudorPU(onuErrorCodi, osbErrorMsg);
        IF onuErrorCodi <> 0 THEN
          RAISE EX.CONTROLLED_ERROR;
        END IF;
      end if;
    END IF;
  
    /*********************************FIN DEL PROCESO*********************************/
    IF onuErrorCodi IS NULL OR onuErrorCodi = 0 THEN
      onuErrorCodi := 0;
      osbErrorMsg := 'Venta registrada - Id de solicitud := [' ||
                     onuPackage || ']';
      COMMIT; --200-2375 se pasa al final
    
      --Caso 200-2375
      --Registros de Voucher
      /*if rgXML.NUVOUCHER is not null then
      
        select count(1)
          into numDet
          from open.ldc_pagunidet p
         where p.pagare_id = NUPROMISSORY_ID
           and voucher = rgXML.NUVOUCHER
           and package_id_sale = onuPackage;
      
        if numDet = 0 then
      
          vlrFinanciar  := rgXML.NUTOTALVENTA - rgXML.NUCUOTAINI;
          v_id_registro := SEQ_LDC_PAGUNIDET.Nextval;
      
          insert into open.ldc_pagunidet
            (id_registro,
             pagare_id,
             voucher,
             package_id_sale,
             fecha_venta,
             total_financiar,
             total_cuotas,
             cuota_inicial,
             costo_seguro)
          values
            (v_id_registro,
             NUPROMISSORY_ID,
             rgXML.NUVOUCHER,
             onuPackage,
             TO_DATE(TO_CHAR(TO_DATE(rgXML.DTFECHAVENTA,
                                     'DD/MM/YYYY HH24:MI:SS'),
                             'DD/MM/YYYY HH24:MI:SS'),
                     'DD-MM-YYYY HH24:MI:SS'),
             vlrFinanciar,
             NUCANTCUOTAS,
             rgXML.NUCUOTAINI,
             rgXML.NUVALORAPROXSEG);
        end if;
        commit;
      end if;*/
      ---
    END IF;
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ROLLBACK;
      ERRORS.SETERROR;
      onuPackage := null;
    WHEN OTHERS THEN
      ROLLBACK;
      onuErrorCodi := -1;
      osbErrorMsg  := UPPER('Error general: ' || SQLERRM);
      ERRORS.SETERROR;
      onuPackage := null;
      RAISE EX.CONTROLLED_ERROR;
    
  END proRegistraVenta;

end LDCI_PKVENTABRILLA;
/
