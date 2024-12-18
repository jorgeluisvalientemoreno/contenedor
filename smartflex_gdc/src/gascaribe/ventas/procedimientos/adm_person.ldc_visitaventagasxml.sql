create or replace PROCEDURE ADM_PERSON.LDC_VISITAVENTAGASXML(OPERATING_UNIT_ID   IN MO_PACKAGES.OPERATING_UNIT_ID%TYPE,
                                                  RECEPTION_TYPE_ID   IN MO_PACKAGES.RECEPTION_TYPE_ID%TYPE,
                                                  CONTACT_ID          IN MO_PACKAGES.CONTACT_ID%TYPE,
                                                  ADDRESS_ID          IN MO_PACKAGES.ADDRESS_ID%TYPE,
                                                  REFER_MODE_ID       IN MO_PACKAGES.REFER_MODE_ID%TYPE,
                                                  COMMENT_            IN MO_PACKAGES.COMMENT_%TYPE,
                                                  ROLE_ID             IN MO_SUBS_TYPE_MOTIV.ROLE_ID%TYPE,
                                                  DIRECCION_DE_VISITA IN MO_PACKAGES.ADDRESS_ID%TYPE,
                                                  TIPO_DE_PREDIO      IN LD_FA_INFOADIC_REFERIDO.TIPOPREDIO%TYPE,
                                                  USUARIO_REFERENTE   IN LD_FA_INFOADIC_REFERIDO.SUSCCODI%TYPE,
                                                  NUPACKAGE_ID        OUT MO_PACKAGES.PACKAGE_ID%TYPE,
                                                  NUMOTIVE_ID         OUT NUMBER,
                                                  NUORDER_ID          OUT NUMBER,
                                                  NUERROR             OUT NUMBER,
                                                  SBMENSAJEERROR      OUT VARCHAR2) IS

  /*******************************************************************************************************************
  METODO: LDC_VISITAVENTAGASXML
  DESCRIPCION:  GENERA EL TRAMITE XML DE VISITA DE VENTA DE GAS
  AUTOR: JORGE VALIENTE
  FECHA: 11 JULIO 2014


  HISTORIA DE MODIFICACIONES
  FECHA             AUTOR             MODIFICACION
  =========       =========           ====================
  15/02/2018      KBaquero            CA 200-1489: Se modifica el mensaje de salida, para que en el momento en
                                      que se genere la solicitud, sea un mensaje de éxito con el numero de la solicitud
                                      si no se genera la orden.
  10/10/2023      Adrianavg           OSF-1707: Se requiere realizar cambios al procedimiento LDC_VISITAVENTAGASXML,
                                      esto con el fin de centralizar los llamados a objetos de producto en un solo objeto
                                      personalizado, especialmente los API.
                                      Se declara SBREQUESTXML1 de tipo constants_per.tipo_xml_sol, antes VARCHAR2(32767)
                                      Se retira la exception NO_GENERO_ORDEN, no se está usando.
                                      Se añade gestión de trazas pkg_traza
                                      Se reemplaza el RAISE EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                      Se reemplaza el OS_RegisterRequestWithXML por la personalizada API_RegisterRequestByXML
                                      Se reemplaza el armado del XML del tramite P_LDC_VISITA_VENTA_GAS_XML_100268 por el que se encuentra en el
                                      paquete pkg_xml_soli_venta.getSolicitudVisitaVentaGas. Se declaran los parametros de entrada al XML: INUCONTRATOID
                                      y INUCAUSAL. Se reemplaza OS_ASSIGN_ORDER por API_ASSIGN_ORDER
                                      Se declara constante cnuErrorCode para definir el código de error por defecto en lugar del -2 asignado en la lógica
                                      Se añade en WHEN pkg_error.Controlled_Error el pkg_error.setErrorMessage, pkg_error.geterror
                                      Se añade en WHEN OTHERS el pkg_error.setError y pkg_error.geterror
  09/05/2024      Paola Acosta        OSF-2672: Cambio de esquema ADM_PERSON                                       
  ********************************************************************************************************/
    --Variables para gestión de traza
    csbMetodo      CONSTANT VARCHAR2(50) := $$PLSQL_UNIT;--Constante nombre método
    csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzApi;

    cnuErrorCode   CONSTANT NUMBER(6)    := pkg_error.CNUGENERIC_MESSAGE;
    NUERRORCODE    NUMBER;
    SBERRORMESSAGE VARCHAR2(4000);
    NUPACKAGEID    MO_PACKAGES.PACKAGE_ID%TYPE;
    NUMOTIVEID     MO_MOTIVE.MOTIVE_ID%TYPE;
    SBREQUESTXML1  constants_per.tipo_xml_sol%type;
    INUCONTRATOID  suscripc.susccodi%TYPE;
    INUCAUSAL      ge_causal.causal_id%TYPE;

    --MEDIO POR EL CUAL SE ENTERO PARA LA COMPRA DEL SERVICIO DE GAS PARA XML
    CURSOR CULD_FA_PARAGENE IS
    SELECT X.PAGEVANU
      FROM LD_FA_PARAGENE X
     WHERE X.PAGEDESC = DALD_PARAMETER.fsbGetValue_Chain('MEDIO_DE_REFERENCIA_XML', NULL);
    NUPAGEVANU LD_FA_PARAGENE.PAGEVANU%TYPE;

    --TIPO PREDIO
    CURSOR CUAB_PREMISE_TYPE IS
    SELECT COUNT(1)
      FROM AB_PREMISE_TYPE
     WHERE AB_PREMISE_TYPE.PREMISE_TYPE_ID = TIPO_DE_PREDIO;
    NUCANTIDAD NUMBER;

    --MEDIO DE RECEPCION
    CURSOR CUGE_RECEPTION_TYPE(NURECEPTION_TYPE_ID GE_RECEPTION_TYPE.RECEPTION_TYPE_ID%TYPE) IS
    SELECT COUNT(R.RECEPTION_TYPE_ID)
      FROM GE_RECEPTION_TYPE R, OR_OPE_UNI_RECE_TYPE O, OR_OPERATING_UNIT U
     WHERE R.RECEPTION_TYPE_ID = NURECEPTION_TYPE_ID
       AND R.RECEPTION_TYPE_ID = O.RECEPTION_TYPE_ID
       AND O.OPERATING_UNIT_ID = U.OPERATING_UNIT_ID
     GROUP BY R.RECEPTION_TYPE_ID, R.DESCRIPTION;
    NURECEPTION_TYPE_ID NUMBER;

    --SUSCRIPTOR
    CURSOR CUGE_SUBSCRIBER IS
    SELECT GS.*
      FROM SUSCRIPC S, GE_SUBSCRIBER GS
     WHERE S.SUSCCODI = USUARIO_REFERENTE
       AND S.SUSCCLIE = GS.SUBSCRIBER_ID
       AND ROWNUM = 1;
    TEMPCUGE_SUBSCRIBER CUGE_SUBSCRIBER%ROWTYPE;
    NOMBRE              VARCHAR2(4000) := NULL;
    APELLIDO            VARCHAR2(4000) := NULL;
    DIRECCION           VARCHAR2(4000) := NULL;
    TELEFONO            VARCHAR2(4000) := NULL;

    --ORDEN
    CURSOR CUOR_ORDER_ACTIVITY(INUPACKAGE_ID MO_PACKAGES.PACKAGE_ID%TYPE) IS
    SELECT OOA.ORDER_ID
      FROM OR_ORDER_ACTIVITY OOA
     WHERE OOA.PACKAGE_ID = INUPACKAGE_ID
       AND ROWNUM = 1;
    INUORDER_ID OR_ORDER.ORDER_ID%TYPE;

BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
    pkg_error.prinicializaerror(NUERROR,SBMENSAJEERROR );
    pkg_traza.trace('Unidad Operativa: '||OPERATING_UNIT_ID||', '||
                    ' Medio De Recepcion: '||RECEPTION_TYPE_ID||', '||
                    ' Información del solicitante: '||CONTACT_ID||', '||
                    ' Direccion de respuesta: '||ADDRESS_ID||', '||
                    ' Medio por el que se entero: '||REFER_MODE_ID||', '||
                    ' Observacion: '||COMMENT_||', '||
                    ' Relacion del Solicitante con el predio: '||ROLE_ID||', '||
                    ' Direccion de visita: '||DIRECCION_DE_VISITA||', '||
                    ' Tipo de predio: '||TIPO_DE_PREDIO||', '||
                    ' Suscripcion del usuario referente: '||USUARIO_REFERENTE, csbNivelTraza);

    IF RECEPTION_TYPE_ID IS NULL THEN 
	   NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'EL MEDIO DE RECEPCION NO PUEDE SER NULO';
       RAISE pkg_error.Controlled_Error;
    ELSIF RECEPTION_TYPE_ID IS NOT NULL THEN
        OPEN CUGE_RECEPTION_TYPE(RECEPTION_TYPE_ID);
       FETCH CUGE_RECEPTION_TYPE
        INTO NURECEPTION_TYPE_ID;
       CLOSE CUGE_RECEPTION_TYPE;
       IF NURECEPTION_TYPE_ID = 0 THEN
          NUERRORCODE    := cnuErrorCode;
          SBERRORMESSAGE := 'EL MEDIO DE RECEPCION NO EXISTE O NO ESTA ASOCIADO A NINGUNA UNIDAD OPERATIVA. VALIDE CON EL ADMINISTADOR';
          RAISE pkg_error.Controlled_Error;
       END IF;
    END IF;

    IF CONTACT_ID IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'EL INFORMACION DEL SOLICITANTE NO PUEDE SER NULO';
       RAISE pkg_error.Controlled_Error;
    END IF;

    IF REFER_MODE_ID IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'EL MEDIO POR EL QUE SE ENTERO NO PUEDE SER NULO';
       RAISE pkg_error.Controlled_Error;
    END IF;

    IF COMMENT_ IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'LA OBSERVACION NO PUEDE SER NULA';
       RAISE pkg_error.Controlled_Error;
    END IF;

    IF ROLE_ID IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'LA RELACION DEL SOLICITANTE CON EL PREDIO NO PUEDE SER NULA';
       RAISE pkg_error.Controlled_Error;
    END IF;

    IF DIRECCION_DE_VISITA IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'LA DIRECCION DE VISITA NO PUEDE SER NULA';
       RAISE pkg_error.Controlled_Error;
    END IF;

    IF TIPO_DE_PREDIO IS NULL THEN
       NUERRORCODE    := cnuErrorCode;
       SBERRORMESSAGE := 'EL TIPO DE PREDIO NO PUEDE SER NULO';
       RAISE pkg_error.Controlled_Error;
    ELSIF TIPO_DE_PREDIO IS NOT NULL THEN
        OPEN CUAB_PREMISE_TYPE;
       FETCH CUAB_PREMISE_TYPE
        INTO NUCANTIDAD;
       CLOSE CUAB_PREMISE_TYPE;
       IF NUCANTIDAD = 0 THEN
          NUERRORCODE    := cnuErrorCode;
          SBERRORMESSAGE := 'EL TIPO DE PREDIO NO EXISTE';
          RAISE pkg_error.Controlled_Error;
       END IF;
    END IF;

     OPEN CULD_FA_PARAGENE;
    FETCH CULD_FA_PARAGENE
     INTO NUPAGEVANU;
    CLOSE CULD_FA_PARAGENE;

    IF NUPAGEVANU <> REFER_MODE_ID THEN
        IF USUARIO_REFERENTE IS NOT NULL THEN
           NUERRORCODE    := cnuErrorCode;
           SBERRORMESSAGE := 'SI EL MEDIO POR EL CUAL SE ENTERO NO ES REFERIDO, POR FAVOR NO INGRESE EL CONTRATO REFERENTE';
           RAISE pkg_error.Controlled_Error;
        END IF;
    ELSIF NUPAGEVANU = REFER_MODE_ID THEN
        IF USUARIO_REFERENTE IS NULL THEN
           NUERRORCODE    := cnuErrorCode;
           SBERRORMESSAGE := 'SI EL MEDIO POR EL CUAL SE ENTERO ES REFERIDO, POR FAVOR INGRESE EL CONTRATO REFERENTE';
           RAISE pkg_error.Controlled_Error;
        ELSIF USUARIO_REFERENTE IS NOT NULL THEN
          IF PKLD_FA_GENERALRULES.FNC_VALIDAVENTASEFECTIVAS(USUARIO_REFERENTE) = 1 THEN
             NUERRORCODE    := cnuErrorCode;
             SBERRORMESSAGE := 'EL CONTRATO HA SUPERADO LA CANTIDAD LIMITE DE VENTAS EFECTIVAS';
             RAISE pkg_error.Controlled_Error;
          ELSIF USUARIO_REFERENTE = CONTACT_ID THEN
             NUERRORCODE    := cnuErrorCode;
             SBERRORMESSAGE := 'EL REFERENTE NO PUEDE SER IGUAL AL REFERIDO';
             RAISE EX.CONTROLLED_ERROR;
          ELSE
             OPEN CUGE_SUBSCRIBER;
            FETCH CUGE_SUBSCRIBER
             INTO TEMPCUGE_SUBSCRIBER;
                IF CUGE_SUBSCRIBER%FOUND THEN
                   NOMBRE    := NVL(TEMPCUGE_SUBSCRIBER.SUBSCRIBER_NAME, 0);
                   APELLIDO  := NVL(TEMPCUGE_SUBSCRIBER.SUBS_LAST_NAME, 0);
                   DIRECCION := NVL(TEMPCUGE_SUBSCRIBER.ADDRESS, 0);
                   TELEFONO  := NVL(TEMPCUGE_SUBSCRIBER.PHONE, 0);
                ELSIF CUGE_SUBSCRIBER%FOUND THEN
                   NUERRORCODE    := cnuErrorCode;
                   SBERRORMESSAGE := 'EL REFERENTE NO EXISTE';
                   RAISE pkg_error.Controlled_Error;
                END IF;
            CLOSE CUGE_SUBSCRIBER;
          END IF;
        END IF;
    END IF;

    SBREQUESTXML1 := pkg_xml_soli_venta.getSolicitudVisitaVentaGas
                        (OPERATING_UNIT_ID, RECEPTION_TYPE_ID, CONTACT_ID, ADDRESS_ID, REFER_MODE_ID,
                         COMMENT_, INUCONTRATOID, ROLE_ID, INUCAUSAL, ADDRESS_ID, TIPO_DE_PREDIO,
                         USUARIO_REFERENTE, NOMBRE, APELLIDO, ADDRESS_ID, TELEFONO);

    pkg_traza.trace('API_RegisterRequestByXML', csbNivelTraza);

    API_RegisterRequestByXML(SBREQUESTXML1,
                            NUPACKAGEID,
                            NUMOTIVEID,
                            NUERRORCODE,
                            SBERRORMESSAGE);

    pkg_traza.trace(' Xml: '||SBREQUESTXML1, csbNivelTraza);
    pkg_traza.trace(' Paquete: '||NUPACKAGEID||', '||
                    ' Motivo: '||NUMOTIVEID||', '||
                    ' Salida onuerrorcode: '||NUERRORCODE||', '||
                    ' Salida osberrormess: '||SBERRORMESSAGE, csbNivelTraza);

    pkg_traza.trace('Termina API_RegisterRequestByXML', csbNivelTraza);

    IF NUERRORCODE <> 0 THEN
       NUERROR        := NUERRORCODE;
       SBMENSAJEERROR := SBERRORMESSAGE;
       ROLLBACK;
       RAISE pkg_error.Controlled_Error;
    ELSE
       COMMIT;
       SBMENSAJEERROR := SBERRORMESSAGE || 'Solicitud ' || NUPACKAGEID || ' generada de manera exitosa. ';
       pkg_traza.trace(SBMENSAJEERROR, csbNivelTraza);
       DBMS_LOCK.Sleep(10);
       NUPACKAGE_ID := NUPACKAGEID;
       NUMOTIVE_ID  := NUMOTIVEID;
        OPEN CUOR_ORDER_ACTIVITY(NUPACKAGE_ID);
       FETCH CUOR_ORDER_ACTIVITY
        INTO INUORDER_ID;
       CLOSE CUOR_ORDER_ACTIVITY;
       NUORDER_ID := NVL(INUORDER_ID, 0);
     IF NUORDER_ID > 0 THEN -- Validamos que se haya generado la orden para poder asignarla
        API_ASSIGN_ORDER(INUORDER_ID, OPERATING_UNIT_ID, NUERRORCODE, SBERRORMESSAGE);
        pkg_traza.trace('API_ASSIGN_ORDER', csbNivelTraza);
        pkg_traza.trace('INUORDER_ID: '||INUORDER_ID||', '||
                        ' OPERATING_UNIT_ID: '||OPERATING_UNIT_ID||', '||
                        ' NUERRORCODE: '||NUERRORCODE||', '||
                        ' SBERRORMESSAGE: '||SBERRORMESSAGE, csbNivelTraza);
        IF NUERRORCODE <> 0 THEN
           NUERROR        := NUERRORCODE;
           SBMENSAJEERROR := SBMENSAJEERROR || SBERRORMESSAGE;
           ROLLBACK;
           RAISE pkg_error.Controlled_Error;
        ELSE
           COMMIT;
        END IF;
     ELSE
         SBMENSAJEERROR := SBMENSAJEERROR ||'Orden de trabajo no generada.';
         pkg_traza.trace(SBMENSAJEERROR, csbNivelTraza);
     END IF;
    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
  WHEN pkg_error.Controlled_Error THEN
       ROLLBACK;    
       NUERROR        := NUERRORCODE;
       SBMENSAJEERROR := SBERRORMESSAGE; 
       pkg_error.setErrorMessage(NUERROR, SBMENSAJEERROR);
       pkg_error.geterror(NUERROR,SBMENSAJEERROR); 
       pkg_traza.trace(csbMetodo||' - '||NUERROR||' - '||SBMENSAJEERROR, csbNivelTraza, pkg_traza.csbFIN_ERC);     
  WHEN OTHERS THEN
       ROLLBACK;  
       pkg_error.setError;
       pkg_error.geterror(NUERROR,SBMENSAJEERROR);
       pkg_traza.trace(csbMetodo||' - '||NUERROR||' - '||SBMENSAJEERROR,  csbNivelTraza, pkg_traza.csbFIN_ERR);
END LDC_VISITAVENTAGASXML;
/
PROMPT Otorgando permisos de ejecucion a LDC_VISITAVENTAGASXML
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_VISITAVENTAGASXML', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_VISITAVENTAGASXML para reportes
GRANT EXECUTE ON adm_person.LDC_VISITAVENTAGASXML TO rexereportes;
/