create or replace PACKAGE ADM_PERSON.LDCI_PKOSSSOLICITUD AS
  /**************************************************************************************************************************************
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

           PAQUETE : LDCI_PKCRMSOLICITUD
           AUTOR   : Hector Fabio Dominguez
           FECHA   : 26/05/2013
           RICEF   :
     DESCRIPCION   : Paquete de interfaz que contiene todas las funcionalidades para
                     la creacion de solicitudes de servicios de ingeniería.

   Historia de Modificaciones

   Autor           Fecha        Descripcion.
   epenao          31/10/2023   OSF-1759:
                                Ajustes proyecto organización:
                                +Modificación de la sentencia select into
                                para que se haga a través de un cursor 
                                y utilizando la función regexp_substr
                                en lugar del método: ldc_boutilities.splitstrings.
                                +Ajuste gestión de traza con el paquete personalizado. 
                                +Ajuste gestión de errores con el paquete personalizado.
                                +Cambio llamado del método damo_packages.fnugetreception_type_id
                                por pkg_bcsolicitudes.fnuGetMedioRecepcion. 
                                +Cambio llamado del método damo_packages.fnugetperson_id por
                                pkg_bcsolicitudes.fnuGetPersona.
                                +Cambio llamado de dapr_product.fnugetsubscription_id por
                                pkg_bcproducto.fnuContrato.
                                +Cambio llamdo OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                +Cambio llamado pktblsuscripc.fnugetsuscclie por pkg_bccontrato.fnuidcliente
                                +Cambio llamado OS_RegisterRequestWithXML por API_RegisterRequestByXML
                                +Cambio del tipo de dato de la variable sbRequestXML para que sea del tipo
                                personalizado: constants_per.tipo_xml_sol%type.
   
   eaguera         08/05/2018   proSolicitudVSI: Si el punto de atencion viene en null, lo toma de un parametro y no de la solicitud
   KBaquero        26/05/2015   Creacion del paquete
   
  **************************************************************************************************************************************/  

  --Obtiene el id de la actividad para el order activity
  FUNCTION funGetActivity(inuactivity in or_order_activity.activity_id%type)
    return numbeR;

  --Crea solicitud: servicios de ingenería.  
  PROCEDURE proSolicitudVSI(inuSuscCodi     IN SUSCRIPC.SUSCCODI%TYPE,
                            inuTipoRecep    IN NUMBER,
                            nuProductId     IN NUMBER,
                            nuPersonId      IN NUMBER,
                            nuPtoAtncn      IN NUMBER,
                            inuoper         IN NUMBER,
                            dtFecha         IN DATE,
                            sbComment       IN VARCHAR2,
                            inuContactId    IN NUMBER,
                            inuIdAddress    IN NUMBER,
                            nuAddressIdSV   IN NUMBER,
                            nuActividad     IN number,
                            nupack          IN number,
                            nuMotiveId      IN OUT NUMBER,
                            nuPackageId     OUT NUMBER,
                            NUORDER_ID      OUT NUMBER,
                            ONUERRORCODE    IN OUT NUMBER,
                            OSBERRORMESSAGE IN OUT VARCHAR2);

END LDCI_PKOSSSOLICITUD;
/
create or replace PACKAGE BODY ADM_PERSON.LDCI_PKOSSSOLICITUD AS

    csbNOMPKG    	CONSTANT VARCHAR2(35):= $$PLSQL_UNIT||'.'; -- Constantes para el control de la traza

  ---------------------------------------------------------------------------
  ---------------------------------------------------------------------------

  FUNCTION funGetActivity(inuactivity in or_order_activity.activity_id%type)
    return number IS

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : funGetActivity
    Descripcion    : Se obtiene la actividad de la orden a generar
                     desde un paramtro
    Autor          : Sincecomp/Karem Baquero
    Fecha          : 27/05/2015
    RICEF          : IXXX
    Parametros              Descripcion
    ============         ===================
    ENTRADA
     inuproveed             Identificador del proveedor.

    Historia de Modificaciones
    Fecha             Autor               Modificacion
    =========         =========           ====================
    31/10/2023         epenao              OSF-1759:
                                           +Modificación de la sentencia select into
                                           para que se haga a través de un cursor 
                                           y utilizando la función regexp_substr
                                           en lugar del método: ldc_boutilities.splitstrings.
                                           +Ajuste gestión de traza con el paquete personalizado. 
                                           +Ajuste gestión de errores con el paquete personalizado.

    ******************************************************************/
       csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'funGetActivity'; --Nombre del método en la traza   
       nuok        number;
    
       sbACTIVITY_ASIG  ld_parameter.value_chain%type;
       cursor cuValActividad is 
       select count(1) 
         from (SELECT to_number(regexp_substr(sbACTIVITY_ASIG,'[^,]+', 1, LEVEL)) AS vlrColumna
                 FROM dual
              CONNECT BY regexp_substr(sbACTIVITY_ASIG, '[^,]+', 1, LEVEL) IS NOT NULL                  
              )
        where vlrColumna = inuactivity;     


  BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
        pkg_traza.trace('inuactivity['||inuactivity||']',pkg_traza.cnuNivelTrzDef);
    
        --Obtiene valor del parámetro para la comparación               
        sbACTIVITY_ASIG := DALD_PARAMETER.fsbGetValue_Chain('COD_ACTIVITY_ASIG',NULL);     
        open cuValActividad;
            fetch cuValActividad into nuok;
        close cuValActividad;     


        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);
        return nuok;

  EXCEPTION
    when PKG_ERROR.CONTROLLED_ERROR then
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);
      raise PKG_ERROR.CONTROLLED_ERROR;
    when others then
      PKG_ERROR.setError;
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
      raise PKG_ERROR.CONTROLLED_ERROR;
  END funGetActivity;

  /*********************************************************************************************************
     PROCEDIMIENTO : proSolicitudGeneral
     AUTOR         : Hector Fabio Dominguez
     FECHA         : 26/02/2013
     RICEF         : I041
     DESCRIPCION   : Permite generar una solicitud de atencion
           General

    Historia de Modificaciones
    Autor   Fecha      Descripcion
    epenao  31/10/2023  OSF-1759:
                        +Creación del cursor cuAddress para reemplazar el select into que 
                        estaba dentro del código.
                        +Ajuste gestión de traza con el paquete personalizado. 
                        +Ajuste gestión de errores con el paquete personalizado.
                        +Cambio llamado del método damo_packages.fnugetreception_type_id
                        por pkg_bcsolicitudes.fnuGetMedioRecepcion. 
                        +Cambio llamado del método damo_packages.fnugetperson_id por
                        pkg_bcsolicitudes.fnuGetPersona.
                        +Cambio llamado de dapr_product.fnugetsubscription_id por
                        pkg_bcproducto.fnuContrato.
                        +Cambio llamdo OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                        +Cambio llamado pktblsuscripc.fnugetsuscclie por pkg_bccontrato.fnuidcliente
                        +Cambio llamado OS_RegisterRequestWithXML por API_RegisterRequestByXML
                        +Cambio del tipo de dato de la variable sbRequestXML para que sea del tipo
                        personalizado: constants_per.tipo_xml_sol%type.

    eaguera 08/05/2018 Si el punto de atencion viene en null, lo toma de un parametro y no de la solicitud
    
  *********************************************************************************************************/

  PROCEDURE proSolicitudVSI(inuSuscCodi     IN SUSCRIPC.SUSCCODI%TYPE,
                            inuTipoRecep    IN NUMBER,
                            nuProductId     IN NUMBER,
                            nuPersonId      IN NUMBER,
                            nuPtoAtncn      IN NUMBER,
                            inuoper         IN NUMBER,
                            dtFecha         IN DATE,
                            sbComment       IN VARCHAR2,
                            inuContactId    IN NUMBER,
                            inuIdAddress    IN NUMBER,
                            nuAddressIdSV   IN NUMBER,
                            nuActividad     IN number,
                            nupack          IN number,
                            nuMotiveId      IN OUT NUMBER,
                            nuPackageId     OUT NUMBER,
                            NUORDER_ID      OUT NUMBER,
                            ONUERRORCODE    IN OUT NUMBER,
                            OSBERRORMESSAGE IN OUT VARCHAR2) AS

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'proSolicitudVSI'; --Nombre del método en la traza                            

    sbRequestXML        constants_per.tipo_xml_sol%type;
    sbObserva           MO_PACKAGES.COMMENT_%TYPE;
    dtFechasol          date;
    nuPtoAtncndsol      MO_PACKAGES.Pos_Oper_Unit_Id%type;
    nuPersonIdsol       MO_PACKAGES.PERSON_ID%type;
    inuTipoRecepsol     MO_PACKAGES.Reception_Type_Id%type;
    inuSuscCodiprod     servsusc.sesususc%type;
    inuContactIdsol     suscripc.suscclie%type;
    nuoK                NUMBER := 0;

    nuoract             number;
    
    nuAdressPr          number;
    nuAddressIdSV2      number;
    sbPtoAtencion       ge_organizat_area.organizat_area_id%type;
    nuIdPerson          ge_person.person_id%type;

    --INICIO CURSOR ORDEN
    CURSOR CUOR_ORDER_ACTIVITY(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
      SELECT OOA.ORDER_ID, ooa.order_activity_id
        FROM OR_ORDER_ACTIVITY OOA
       WHERE OOA.PACKAGE_ID = INUPACKAGE_ID            
         AND ROWNUM = 1;

    INUORDER_ID OR_ORDER.ORDER_ID%TYPE;    

    cursor cuAddress(inuproduct in pr_product.product_id%type ) is
    select pr.address_id 
      from pr_product pr
    where pr.product_id = inuproduct;

  BEGIN
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);

        --Se convierte a Observación 
        sbObserva := convert(sbComment, 'UTF8');

        --Se verifica si el suscriptor viene null
        if inuSuscCodi is null and nuProductId is not null then

        inuSuscCodiprod :=  pkg_bcproducto.fnuContrato(nuProductId);
        
        else
        inuSuscCodiprod := inuSuscCodi;
        end if;

        --Se verifica si la fecha de solicitud viene null
        if dtFecha is null then
        dtFechasol := to_date(sysdate,'dd/mm/yyyy HH24:MI:SS');
        else
        dtFechasol := to_date(dtFecha,'dd/mm/yyyy HH24:MI:SS');
        end if;

        --Verifica la información del cliente viene null
        if inuContactId is null and inuSuscCodiprod is not null then
        inuContactIdsol := pkg_bccontrato.fnuidcliente(inuSuscCodiprod);
        else
        inuContactIdsol := inuContactId;
        end if;

        --Verifica la información del tipo de recepción viene null
        if inuTipoRecep is null and nupack is not null then        
            inuTipoRecepsol := pkg_bcsolicitudes.fnuGetMedioRecepcion(nupack);
        else
        inuTipoRecepsol := inuTipoRecep;
        end if;

        --Verifica la información de la persona del trámite viene null
        if nuPersonId is null and nupack is not null then
        nuIdPerson := Dald_parameter.fsbGetValue_Chain('LDCI_PERSON_VSI',null);
        if nuIdPerson is null then                         
            nuIdPerson := pkg_bcsolicitudes.fnuGetPersona(nupack);
        end if;
        nuPersonIdsol := nuIdPerson;
        else
        nuPersonIdsol := nuPersonId;
        end if;

        --Verifica la información del punto de atención viene null
        if nuPtoAtncn is null and nupack is not null then
        sbPtoAtencion := Dald_parameter.fsbGetValue_Chain('LDCI_PTO_ATENCION',null);
        if sbPtoAtencion is null then
            sbPtoAtencion := damo_packages.fnugetpos_oper_unit_id(nupack);
        end if;  
        nuPtoAtncndsol := sbPtoAtencion;
        else
        nuPtoAtncndsol := nuPtoAtncn;
        end if;

        nuAdressPr :=0;
        nuAddressIdSV2 :=nuAddressIdSV;
        --Verificar si la información de nuAddressIdSV viene null
        if nuAddressIdSV is null and nuProductId is not null then

            open cuAddress(nuProductId);
                fetch cuAddress into nuAdressPr;
            close cuAddress;   

            nuAddressIdSV2 := nuAdressPr;

        end if;

        sbRequestXML := pkg_xml_soli_vsi.getSolicitudVSI
                                        (inuContratoID       => inuSuscCodiprod,
                                        inuMedioRecepcionId  => inuTipoRecepsol,
                                        isbComentario        => sbObserva, 
                                        inuProductoId        => nuProductId, 
                                        inuClienteId         => inuContactIdsol, 
                                        inuPersonaID         => nuPersonIdsol,
                                        inuPuntoAtencionId   => nuPtoAtncndsol,
                                        idtFechaSolicitud    => dtFechasol, 
                                        inuAddressId         => inuIdAddress,
                                        inuTrabajosAddressId => nuAddressIdSV2, 
                                        inuActividadId       => nuActividad 
                                        );
       pkg_traza.trace(sbRequestXML,pkg_traza.cnuNivelTrzDef);                           


        --Ejecuta el XML creado*/
        API_RegisterRequestByXML(sbRequestXML,
                                nuPackageId,
                                nuMotiveId,
                                ONUERRORCODE,
                                OSBERRORMESSAGE);

        IF ONUERRORCODE <> 0 THEN
        pkg_traza.trace('ROLLBACK proSolicitudVSI',pkg_traza.cnuNivelTrzDef);
        ROLLBACK;
        raise PKG_ERROR.CONTROLLED_ERROR;
        ELSE
        COMMIT;
        pkg_traza.trace('COMMIT DESpUEs DE GENERAR TRAMITE proSolicitudVSI',pkg_traza.cnuNivelTrzDef);
        DBMS_LOCK.Sleep(10);

        --Se valida si la actividad se encuentra en el parametro
        nuoK := funGetActivity(nuActividad);

        OPEN CUOR_ORDER_ACTIVITY(nuPackageId);
        FETCH CUOR_ORDER_ACTIVITY
            INTO INUORDER_ID, nuoract;
        CLOSE CUOR_ORDER_ACTIVITY;
        NUORDER_ID := NVL(INUORDER_ID, 0);

        IF nuoK = 1 THEN
        --Se procede asignar la orden de la actividad que se encuentra en el parametro
            IF NVL(inuoper, 0) <> 0 THEN 
                API_ASSIGN_ORDER(INUORDER_ID,
                                 inuoper,
                                 ONUERRORCODE,
                                 OSBERRORMESSAGE);

            IF ONUERRORCODE <> 0 THEN
                ROLLBACK;
                raise PKG_ERROR.CONTROLLED_ERROR;
            ELSE                
                pkg_traza.trace('COMMIT DESPUES DE ASIGNAR UNIDAD OPERATIVA proSolicitudVSI',pkg_traza.cnuNivelTrzDef);
                COMMIT;
            END IF;
            END IF;
        END IF;
        END IF;

        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN);

  EXCEPTION
    WHEN PKG_ERROR.CONTROLLED_ERROR   then
      ROLLBACK;
      PKG_ERROR.geterror(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('onuErrorCode ['||onuErrorCode||
                      '] osbErrorMessage:'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERC);                      
    WHEN OTHERS THEN
      osbErrorMessage := 'Error creando la solicitud: ' ||
                         DBMS_UTILITY.FORMAT_ERROR_BACKTRACE;
      PKG_ERROR.seterror;
      PKG_ERROR.geterror(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('onuErrorCode ['||onuErrorCode||
                    '] osbErrorMessage:'||osbErrorMessage,pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbFIN_ERR);
  END proSolicitudVSI;

END LDCI_PKOSSSOLICITUD;
/

PROMPT Asignación de permisos para el método
begin
  pkg_utilidades.prAplicarPermisos('LDCI_PKOSSSOLICITUD', 'ADM_PERSON');
end;
/
GRANT EXECUTE on ADM_PERSON.LDCI_PKOSSSOLICITUD to REXEINNOVA;
/
