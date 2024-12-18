create or replace PROCEDURE ADM_PERSON.LDC_CREA_TRAMITE_SER_ING AS
    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     :  LDC_CREA_TRAMITE_SER_ING
    Descripcion :  Procedimiento que crea el tramite de Venta Servicios de Ingenieria por medio de XML
                 nuPtoAtncn: Punto de atencion del usuario logueado a SF.
                 nuProductId, nuContratoId: producto y contrato del producto basado en la orden
                 sbRequestXML1: Tag del xml para crear el tramite
    Autor       : Alvaro Zapata
    Fecha       : 24-10-2013

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
   09-12-2013         Sayra Ocoro       * Se modifica el cursor cuOrderComment para que obtenga un unico registro.
                                        * Se adiciona marcado del tramite para rastrear la OT de ADC que le dio origen.
                                        * Soluciona NC 1534.
   17-12-2013         Sayra Ocoro       * Soluciona NC 1534_3
   12-08-2014         agordillo         * Solucion NC 1041,1042,1042 se modica el usuario definico como '800167643'  por
                                          el parametro COD_USER_CREA_TRAMITE_SER_ING variable sbIdentUsuario
   23-08-2020         OL SOFTWARE       * caso 473, se quitan los rollback y se ajustan las EXCEPTIONs
   08-11-2023         Adrianavg         OSF 1738 Se retira nombre de esquema OPEN antepuesto a GE_PERSON cursor cuPersonId y GE_SUBSCRIBER 
                                        del cursor cuSubscriberId. Se reemplaza el tipo de dato varchar2(32767) por constants_per.tipo_xml_sol%type
                                        para la variable sbRequestXML1. Se reemplaza OR_BOORDER.FNUGETORDERCAUSAL por Pkg_Bcordenes.fnuObtieneCausal
                                        Se reemplaza ut_session.getsessionid por pkg_session.fnuGetSesion. Se reemplaza OR_BOLEGALIZEORDER.FNUGETCURRENTORDER
                                        por PKG_BCORDENES.FNUOBTENEROTINSTANCIALEGAL. Se reemplaza 2741 y Ld_Boconstans.cnuGeneric_Error por PKG_ERROR.CNUGENERIC_MESSAGE
                                        Se reemplaza GI_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.SETERRORMESSAGE. Se reemplaza Errors.setError por PKG_ERROR.SETERROR
                                        Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR. Se reemplaza UT_TRACE y dbms_output.put_line por PKG_TRACE
                                        Se declaran Constantes para el control de la traza. Se reemplaza el armado del XML por pkg_xml_soli_vsi.getSolicitudVSI
                                        Se reemplaza SELECT-INTO por cursor cuAddress. Se retira código comentado
    02/05/2024       PACOSTA            OSF-2638: Se crea el objeto en el esquema adm_person                                           
    **************************************************************************/

    nuErrorCode         NUMBER;
    sbErrorMessage      VARCHAR2(4000);
    SbMensaj            Varchar(2000);
    nuPackageId         mo_packages.package_id%type;
    nuMotiveId          mo_motive.motive_id%type;
    sbRequestIdExtern   varchar2(2000);
    sbRequestXML1       varchar2(32767);
    nuorden             or_order.order_id%type;
    dtFecha             DATE:=SYSDATE;
    nuPersonId          ge_person.person_id%type;
    nuPtoAtncn          number;
    sbComment           VARCHAR2(2000);
    nuProductId         number;
    nuContratoId        number;
    nuTaskTypeId        number;
    nuAddressId         number;
    nuActividad         number;
    sbSubscriberId      number;
    nuCausalOrder       number;
    sbPlugin            VARCHAR2(50);
    EX_ERROR            exception;
    sbIdentUsuario      varchar2(100);


    --Cursor que obtiene el producto, el contrato del producto y el tipo de trabajo de acuerdo a la orden instanciada
    CURSOR cuProducto(nuorden number) IS
    SELECT PRODUCT_ID, SUBSCRIPTION_ID, TASK_TYPE_ID
      FROM OR_ORDER_ACTIVITY
     WHERE ORDER_ID = nuorden
       AND ROWNUM = 1;

    CURSOR cuPersonId IS
    SELECT PERSON_ID
      FROM GE_PERSON
     WHERE IDENT_TYPE_ID = 110
       AND NUMBER_ID = sbIdentUsuario;

    --Cursor que obtiene el punto de atencion del usuario logueado al sistema
    CURSOR cuAreaOrganizat (nuPersonId ge_person.person_id%type) IS
    SELECT ORGANIZAT_AREA_ID
      FROM CC_ORGA_AREA_SELLER
     WHERE PERSON_ID = nuPersonId
       AND IS_CURRENT = 'Y';

    CURSOR cuOrderComment (nuorden number) IS
    SELECT ORDER_COMMENT
      FROM OR_ORDER_COMMENT
     WHERE ORDER_ID = nuorden
       AND ROWNUM = 1;

    --cursor que obtiene el subscriber_id del cliente
    CURSOR cuSubscriberId IS
    SELECT SUBSCRIBER_ID
      FROM GE_SUBSCRIBER
     WHERE IDENTIFICATION = sbIdentUsuario --USUARIO SOLICITUDES INTERNAS
       AND IDENT_TYPE_ID  = 1;

    --Consulta el codigo de la direccion del producto
    CURSOR cuAddress (p_nuProductId PR_PRODUCT.PRODUCT_ID%TYPE) IS    
    SELECT ADDRESS_ID 
      FROM PR_PRODUCT
     WHERE PRODUCT_ID = p_nuProductId;    

      -- Constantes para el control de la traza
      csbMetodo      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.'; --Constante nombre método
      csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef; 
BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    --Obtener el identificador de la orden  que se encuentra en la instancia
    nuorden:= pkg_bcordenes.fnuobtenerotinstancialegal;
    pkg_traza.trace(csbMetodo||' Numero de la Orden: ' || nuorden, csbNivelTraza);     

    --Obtiene actividad seleccionada en la legalizacion
    nuActividad:= to_number(ldc_boordenes.fsbDatoAdicTmpOrden(nuorden,5001382, 'ACTIVIDAD_VSI'));

    pkg_traza.trace(csbMetodo||' variable actividad: ' || nuActividad, csbNivelTraza); 

    -- Inicio 12/08/2014 NC 1041 agordillo
    -- Se consulta el usuario configurado en el parametro COD_USER_SOLICITUDES_INTERNAS
    sbIdentUsuario := DALD_PARAMETER.fsbGetValue_Chain('COD_USER_SOLICITUDES_INTERNAS',NULL);

    -- Se valida si el parametro viene null
    IF (sbIdentUsuario is null) then
        SbMensaj:='No existe configurado usuario en el parametro COD_USER_SOLICITUDES_INTERNAS';
        RAISE EX_ERROR;
    END IF;
    
    pkg_traza.trace(csbMetodo||' sbIdentUsuario: ' || sbIdentUsuario, csbNivelTraza); 
    -- Fin 12/08/2014 NC 1041 agordillo

    OPEN cuProducto(nuorden);
         FETCH cuProducto INTO nuProductId, nuContratoId, nuTaskTypeId;
             IF cuProducto%NOTFOUND THEN
              SETERRORDESC('El cursor cuProducto no arrojo datos con el # de orden'||nuorden);
              SbMensaj:='El cursor cuProducto no arrojo datos con el # de orden'||nuorden;
              RAISE PKG_ERROR.CONTROLLED_ERROR;
             END IF;
    CLOSE cuProducto;

    pkg_traza.trace(csbMetodo||' Salio cursor cuProducto, nuProductId: ' || nuProductId
                                                        ||' nuContratoId: '|| nuContratoId
                                                        ||' nuTaskTypeId: '|| nuTaskTypeId, csbNivelTraza);        

    OPEN cuPersonId;
         FETCH cuPersonId INTO nuPersonId;
             IF cuPersonId%NOTFOUND THEN
             SbMensaj:='No se encontro nuPersonId para la identificacion '||sbIdentUsuario;
             RAISE EX_ERROR;
             END IF;
    CLOSE cuPersonId;

    pkg_traza.trace(csbMetodo||' Salio cursor cuPersonId, nuPersonId: ' || nuPersonId , csbNivelTraza);

    OPEN cuAreaOrganizat(nuPersonId);
         FETCH cuAreaOrganizat INTO nuPtoAtncn;
             IF cuAreaOrganizat%NOTFOUND THEN
             SbMensaj:='El cursor cuAreaOrganizat no arrojo datos con el person_id #'||nuPersonId;
             RAISE EX_ERROR;
             END IF;
    CLOSE cuAreaOrganizat;

    pkg_traza.trace(csbMetodo||' Salio cursor cuAreaOrganizat, nuPtoAtncn: ' || nuPtoAtncn , csbNivelTraza);    

    OPEN cuSubscriberId;
         FETCH cuSubscriberId INTO sbSubscriberId;
             IF cuSubscriberId%NOTFOUND THEN
             SbMensaj:='No se encontro susbcriber_id para la identificacion '||sbIdentUsuario;
             RAISE EX_ERROR;
             END IF;
    CLOSE cuSubscriberId;

    pkg_traza.trace(csbMetodo||' Salio cursor cuSubscriberId, sbSubscriberId: ' || sbSubscriberId , csbNivelTraza);    


    OPEN cuOrderComment(nuorden);
         FETCH cuOrderComment INTO sbComment;
             IF cuOrderComment%NOTFOUND THEN
             SbMensaj:='El cursor cuOrderComment no arrojo datos para la orden#'||nuorden;
             RAISE EX_ERROR;
             END IF;
    CLOSE cuOrderComment;

    pkg_traza.trace(csbMetodo||' Salio cursor cuOrderComment, sbComment: ' || sbComment , csbNivelTraza);    

   --Consulta el codigo de la direccion del producto
   OPEN cuAddress(nuProductId);
   FETCH cuAddress INTO nuAddressId;
   CLOSE cuAddress; 

    /*VALIDACION QUE GARANTIZA CREAR EL TRAMITE SI SE HA SELECCIONADO LA CAUSAL CONFIGURADA EN PLUGIN*/

    nuCausalOrder:= Pkg_Bcordenes.fnuObtieneCausal(nuorden);

    pkg_traza.trace(csbMetodo||' Causal de la Orden, nuCausalOrder: ' || nuCausalOrder , csbNivelTraza);    

    sbPlugin:= LDC_BOUTILITIES.FSBGETVALORCAMPOSTABLA('LDC_PROCEDIMIENTO_OBJ', 'TASK_TYPE_ID', 'PROCEDIMIENTO', nuTaskTypeId, 'CAUSAL_ID', nuCausalOrder);

    pkg_traza.trace(csbMetodo||' sbPlugin: ' || sbPlugin , csbNivelTraza);    

          IF nuActividad IS NULL AND sbPlugin != '-1' THEN
             SbMensaj:='Debe seleccionar la Actividad de Servicio de Ing. de acuerdo al Resultado seleccionado';
             RAISE EX_ERROR;
          END IF;

    --Modificacion 09-12-2013
    sbComment := sbComment||' OT ADC NO. '||nuorden;
    --Fin modificacion 09-12-2013

    pkg_traza.trace(csbMetodo||' sbComment: ' || sbComment , csbNivelTraza); 

    sbRequestXML1 := pkg_xml_soli_vsi.getSolicitudVSI(nuContratoId,         --inuProductoId
                                                     10,                    --inuMedioRecepcionId
                                                     sbComment,             --isbComentario
                                                     nuProductId,           --inuProductoId
                                                     sbSubscriberId,           --inuClienteId
                                                     nuPersonId,            --inuPersonID
                                                     nuPtoAtncn,            --inuPuntoAtencionId
                                                     dtFecha,               --idtFechaSolicitud
                                                     nuAddressId,           --inuAddressId
                                                     nuAddressId,           --inuTrabajosAddressId
                                                     nuActividad            --inuActividadId
                                                     );                         

    pkg_traza.trace(csbMetodo||' INICIO: ' , csbNivelTraza);    
    pkg_traza.trace(csbMetodo||' Fecha Inicial 1: '||sysdate , csbNivelTraza);  
    pkg_traza.trace(csbMetodo||' Sesion: '||pkg_session.fnuGetSesion , csbNivelTraza);   
    api_registerRequestByXml(sbRequestXML1, nuPackageId, nuMotiveId,  nuErrorCode, sbErrorMessage);

    if nuErrorCode <> 0 then
         PKG_ERROR.SETERRORMESSAGE(PKG_ERROR.CNUGENERIC_MESSAGE,'ERROR, '||sbErrorMessage);
    END if;

    pkg_traza.trace(csbMetodo||' Fecha final 1: '||sysdate , csbNivelTraza); 
    pkg_traza.trace(csbMetodo||' Paquete: ' || nuPackageId, csbNivelTraza);
    pkg_traza.trace(csbMetodo||' Motivo: ' || nuMotiveId, csbNivelTraza);  
    pkg_traza.trace(csbMetodo||' SALIDA onuErrorCode: ' || nuErrorCode, csbNivelTraza);     
    pkg_traza.trace(csbMetodo||' SALIDA osbErrorMess: ' || sbErrorMessage, csbNivelTraza); 
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
EXCEPTION
    WHEN EX_ERROR THEN
         pkg_traza.trace(csbMetodo||' EX_ERROR [' || PKG_ERROR.CNUGENERIC_MESSAGE || '] - [' || SbMensaj || ']',  csbNivelTraza, pkg_traza.csbFIN_ERC);    
         PKG_ERROR.SETERRORMESSAGE(PKG_ERROR.CNUGENERIC_MESSAGE, SbMensaj);
    WHEN PKG_ERROR.CONTROLLED_ERROR THEN
         pkg_traza.trace(csbMetodo||' [' ||nuErrorCode || '] - [' || sbErrorMessage || ']',  csbNivelTraza, pkg_traza.csbFIN_ERC);    
         RAISE PKG_ERROR.CONTROLLED_ERROR;
         dbms_output.put_line('ERROR CONTROLLED ');
         dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
         dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);
    WHEN OTHERS THEN
         pkg_traza.trace(csbMetodo||' - '||PKG_ERROR.CNUGENERIC_MESSAGE||' - '||sqlerrm,  csbNivelTraza, pkg_traza.csbFIN_ERR);    
         PKG_ERROR.SETERROR;
         RAISE PKG_ERROR.CONTROLLED_ERROR;
         dbms_output.put_line('ERROR OTHERS ');
         dbms_output.put_line('error onuErrorCode: '||nuErrorCode);
         dbms_output.put_line('error osbErrorMess: '||sbErrorMessage);

END LDC_CREA_TRAMITE_SER_ING;
/
PROMPT Otorgando permisos de ejecucion a LDC_CREA_TRAMITE_SER_ING
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_CREA_TRAMITE_SER_ING', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_CREA_TRAMITE_SER_ING para reportes
GRANT EXECUTE ON adm_person.LDC_CREA_TRAMITE_SER_ING TO rexereportes;
/