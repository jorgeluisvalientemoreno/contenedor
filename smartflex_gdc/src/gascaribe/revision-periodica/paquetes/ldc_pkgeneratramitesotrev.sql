CREATE OR REPLACE PACKAGE OPEN.LDC_PKGENERATRAMITESOTREV AS
       PROCEDURE LDC_PRGENERAREVISION(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE);
       PROCEDURE LDC_PRGENERAREPARACION(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE);
       PROCEDURE LDC_PRGENERACERTIFICAC(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE);
	   FUNCTION  LDC_FNUVAL_TRAMITESRP(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE) RETURN NUMBER;
END LDC_PKGENERATRAMITESOTREV;


/

CREATE OR REPLACE PACKAGE BODY OPEN.LDC_PKGENERATRAMITESOTREV AS

      cnuRECORD_NOT_EXIST constant number(1) := 1;
      cnuAPPTABLEBUSSY constant number(4) := 6951;
    --Variables para gestión de traza
      csbNOMPKG      CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
      csbNivelTraza  CONSTANT NUMBER(2)    := pkg_traza.cnuNivelTrzDef;
    /**************************************************************************
      PROCEDURE BORRA_REGISTRO
      HISTORIA DE MODIFICACIONES
      FECHA         AUTOR       	 DESCRIPCION
      14/11/2023    Adrianavg        OSF-1765 Se retira esquema antepuesto a objeto: PR_PRODUCT.
                                     Añadir uso de traza para el proceso y declaración del csbMetodo
    ***************************************************************************/
       PROCEDURE BORRA_REGISTRO(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE,
                 	            INUPROCESO    IN NUMBER) IS
       csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'BORRA_REGISTRO';
       BEGIN
         pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
         pkg_traza.trace(csbMetodo||' inuProduct_id: '||INUPRODUCT_ID ||', inuProceso: '||INUPROCESO , csbNivelTraza);
         IF INUPROCESO = 1 THEN
            DELETE FROM LDC_OTREV WHERE PRODUCT_ID = INUPRODUCT_ID;
         ELSIF INUPROCESO = 2 THEN
            DELETE FROM LDC_OTREV_REPA WHERE PRODUCT_ID = INUPRODUCT_ID;
         ELSIF INUPROCESO = 3 THEN
            DELETE FROM LDC_OTREV_CERTIF WHERE PRODUCT_ID = INUPRODUCT_ID;
         END IF;
         pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
       END;

    /**************************************************************************
      Autor       : Luis Felipe Valencia
      Fecha       : 04/04/2023
      Ticket      : OSF-999
      Descripcion : Procedimiento que se encarga de bloquear los registros de
                    tabla  ldc_otrev para que no se creen solicitudes dobles

      Parametros Entrada
      inuProduct_id     Código del producto

      HISTORIA DE MODIFICACIONES
      FECHA         AUTOR       			  DESCRIPCION
      04/04/2023    felipe.valencia     Creación
      14/11/2023    Adrianavg           OSF-1765 Se reemplaza Errors.setError por PKG_ERROR.setError
                                        Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                        Se reemplaza Errors.setError por PKG_ERROR.setErrorMessage(cnuRECORD_NOT_EXIST, inuProduct_id )
                                        Añadir uso de traza para el proceso y declaración del csbMetodo. 
                                        Añadir en el when others PKG_ERROR.SETERROR y sqlerrm
    ***************************************************************************/
    PROCEDURE pLockByPkldc_otrev(inuProduct_id IN ldc_otrev.product_id%TYPE )
    IS

        CURSOR cuLockRcByPk(inuProduct_id IN ldc_otrev.product_id%TYPE )
        IS
        SELECT product_id
        FROM ldc_otrev
        WHERE  product_id = inuProduct_id
        FOR UPDATE NOWAIT;

        rcLD_otrev cuLockRcByPk%ROWTYPE;
        csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'PLOCKBYPKLDC_OTREV';
        NU NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
        pkg_traza.trace(csbMetodo||' inuProduct_id: '||inuProduct_id , csbNivelTraza);
        OPEN cuLockRcByPk(inuProduct_id);
        FETCH cuLockRcByPk INTO rcLD_otrev;
        IF cuLockRcByPk%notfound  THEN
            CLOSE cuLockRcByPk;
            RAISE NO_DATA_FOUND;
        END IF; 
        CLOSE cuLockRcByPk ;
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        pkg_traza.trace(csbMetodo||' NO_DATA_FOUND ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
          if cuLockRcByPk%isopen then
            close cuLockRcByPk;
          end if;
          PKG_ERROR.setErrorMessage(cnuRECORD_NOT_EXIST, inuProduct_id );
          raise PKG_ERROR.CONTROLLED_ERROR;
        WHEN ex.RESOURCE_BUSY THEN -- No reemplazar, soluciona error de concurrencia de ordenes duplicadas
            pkg_traza.trace(csbMetodo||' RESOURCE_BUSY ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
            IF cuLockRcByPk%isopen THEN
                close cuLockRcByPk;
            END IF;
            PKG_ERROR.setErrorMessage(cnuAPPTABLEBUSSY,'['||inuProduct_id ||']|'|| 'LDC_OTREV' );---***********VALIDAR ESTE
            RAISE PKG_ERROR.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo||' OTHERS '||sqlerrm , csbNivelTraza, pkg_traza.csbFIN_ERR);
            IF cuLockRcByPk%isopen THEN
                close cuLockRcByPk;
            END IF;
            PKG_ERROR.SETERROR;            
            RAISE;
    END pLockByPkldc_otrev;

    PROCEDURE LDC_PRGENERAREVISION(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE) IS

            /*****************************************************************
            PROPIEDAD INTELECTUAL DE PETI.

            UNIDAD         : LDC_REGISTRVISIIDENCERTIXOTREV
            DESCRIPCION    : GENERA TRAMITE DE VISITA DE IDENTIFICACION DE CERTIFICADO POR XML DESDE EL OTROV
            AUTOR          : EMIRO LEYVA H.
            FECHA          : 08/06/2014

            PARAMETROS              DESCRIPCION
            ============         ===================
            NUEXTERNALID:


            HISTORIA DE MODIFICACIONES
            FECHA             AUTOR             MODIFICACION
            =========       =========           ====================
            14/08/2018      DSALTARIN           200-2125 ANTES DE CREAR LA SOLICITUD SE VALIDA SI EXISTEN SOLICITUDES EN PROCESO
                                                CON LA FUNCION LDC_FNUVAL_TRAMITESRP

            03/04/2023      felipe.valencia     OSF-999 Se modififca para bloquear el producto
                                                antes de procesarlo y evitar que se creen
                                                solicitudes dobles
            14/11/2023       Adrianavg          OSF-1765 Se retira esquema antepuesto a objeto: PR_PRODUCT
                                                Se reemplaza tipo de dato VARCHAR2(32767)por Constants_Per.TIPO_XML_SOL para la variable SBREQUESTXML1
                                                Se reemplaza OS_REGISTERREQUESTWITHXML por API_RegisterRequestByXML. Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT
                                                por PKG_ERROR.SETERRORMESSAGE. Se reemplaza DAPR_PRODUCT.FNUGETADDRESS_ID por PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION
                                                Se reemplaza DAAB_ADDRESS.GETRECORD por PKG_BCDIRECCIONES.FRCGETRECORD, PKTBLSUSCRIPC.FNUGETSUSCCLIE por PKG_BCCONTRATO.FNUIDCLIENTE,
                                                PKTBLSERVSUSC.FNUGETCATEGORY(INUPRODUCT_ID) por PKG_BCPRODUCTO.FNUCATEGORIA, PKTBLSERVSUSC.FNUGETSESUSUCA(INUPRODUCT_ID) por
                                                PKG_BCPRODUCTO.FNUSUBCATEGORIA. Se reemplaza ex.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR, ERRORS.SETERROR por PKG_ERROR.SETERROR
                                                Se reemplaza DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID por PKG_BCPRODUCTO.FNUCONTRATO. Se reemplaza armado del XML por PKG_XML_SOLI_REV_PERIODICA.getSolicitudReparacionRp
                                                Se reemplaza Ld_Boconstans.cnuGeneric_Error por Pkg_Error.CNUGENERIC_MESSAGE. Añadir uso de traza para el proceso y declaración del csbMetodo
                                                Se retiran variables que no se usan NUADDRESS_ID, RCAB_ADDRESS, NUCATE, NUSUCA
            ******************************************************************/
            ONUERRORCODE     NUMBER;
            OSBERRORMESSAGE  VARCHAR2(4000);
            SBCOMMENT        VARCHAR2(2000) := 'SE GENERAN DESDE OTREV';
            SBREQUESTXML1    Constants_Per.TIPO_XML_SOL%TYPE;
            NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE;
            NUMOTIVEID       MO_MOTIVE.MOTIVE_ID%TYPE;
            NUSUBSCRIBERID   GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
            NUSUBSCRIPTIONID PR_PRODUCT.SUBSCRIPTION_ID%TYPE;
            SW1              NUMBER;
            SBAPLICAMARC     VARCHAR2(1);
            CURSOR CUBUSCAMARCA(NUPRODU LDC_MARCA_PRODUCTO.ID_PRODUCTO%TYPE) IS
              SELECT COUNT(1) FROM LDC_MARCA_PRODUCTO WHERE ID_PRODUCTO = NUPRODU;
			  NUCANTSOLICITUD NUMBER;

            deadlock_detected EXCEPTION;
            PRAGMA EXCEPTION_INIT(deadlock_detected, -60);
            csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'LDC_PRGENERAREVISION';
          BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
            pkg_traza.trace(csbMetodo||' inuProduct_id: '||inuProduct_id , csbNivelTraza);
             OPEN CUBUSCAMARCA(INUPRODUCT_ID);
            FETCH CUBUSCAMARCA
             INTO SW1;
            IF CUBUSCAMARCA%NOTFOUND THEN
              SW1 := 0;
            END IF;
            CLOSE CUBUSCAMARCA;
            pkg_traza.trace(csbMetodo||' SW1: '||SW1 , csbNivelTraza);
           --  BUSCO EL ADDRESS_ID DEL PRODUCTO
            IF SW1 = 0 THEN
                pLockByPkldc_otrev(INUPRODUCT_ID);

                NUCANTSOLICITUD := LDC_FNUVAL_TRAMITESRP(INUPRODUCT_ID);
                pkg_traza.trace(csbMetodo||' nuCantSolicitud: '||NUCANTSOLICITUD , csbNivelTraza);

                IF NUCANTSOLICITUD = 0 THEN

                  NUSUBSCRIPTIONID := PKG_BCPRODUCTO.FNUCONTRATO(INUPRODUCT_ID);
                  pkg_traza.trace(csbMetodo||' nusubscriptionid: '||NUSUBSCRIPTIONID , csbNivelTraza);
                  NUSUBSCRIBERID   := PKG_BCCONTRATO.FNUIDCLIENTE(NUSUBSCRIPTIONID);
                  pkg_traza.trace(csbMetodo||' nusubscriberid: '||NUSUBSCRIBERID , csbNivelTraza);

                  -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_PACKAGES
                  pkg_traza.trace(csbMetodo||' sbcomment: '||SBCOMMENT , csbNivelTraza);
                  SBREQUESTXML1 := PKG_XML_SOLI_REV_PERIODICA.getSolicitudRevisionRp
                                (10,            --inuMedioRecepcionId
                                 SBCOMMENT,     --isbComentario
                                 INUPRODUCT_ID, --inuProductoId
                                 NUSUBSCRIBERID --inuClienteId
                                 );

                  pkg_traza.trace(csbMetodo||' SBREQUESTXML1: '||SBREQUESTXML1 , csbNivelTraza);
                  API_RegisterRequestByXML(SBREQUESTXML1,
                                           NUPACKAGE_ID,
                                           NUMOTIVEID,
                                           ONUERRORCODE,
                                           OSBERRORMESSAGE);
                  pkg_traza.trace(csbMetodo||' nupackage_id: '||NUPACKAGE_ID , csbNivelTraza);
                  pkg_traza.trace(csbMetodo||' numotiveid: '||NUMOTIVEID , csbNivelTraza);

                  IF ONUERRORCODE = 0 THEN
                    UPDATE LDC_MARCA_PRODUCTO
                       SET INTENTOS = NVL(INTENTOS, 0) + 1
                     WHERE ID_PRODUCTO = INUPRODUCT_ID;
                    pkg_traza.trace(csbMetodo||' UPDATE LDC_MARCA_PRODUCTO ' , csbNivelTraza);
                    IF SQL%NOTFOUND THEN
                    INSERT INTO LDC_MARCA_PRODUCTO(ID_PRODUCTO, ORDER_ID, CERTIFICADO, FECHA_ULTIMA_ACTU, INTENTOS,  MEDIO_RECEPCION,
                            REGISTER_POR_DEFECTO, SUSPENSION_TYPE_ID)
                    VALUES(INUPRODUCT_ID,  NULL,  NULL, TRUNC(SYSDATE), 1, 'I',
                            'N', 101);
                    pkg_traza.trace(csbMetodo||' INSERT INTO LDC_MARCA_PRODUCTO ' , csbNivelTraza);
                    END IF;
                    ldc_prmarcaproductolog(INUPRODUCT_ID,NULL, 101 , 'Generacion tramite 1002347 OTREV');
                    pkg_traza.trace(csbMetodo||' Generacion tramite 1002347 OTREV ' , csbNivelTraza);
                    BORRA_REGISTRO(INUPRODUCT_ID , 1 );
                  ELSE
                    BORRA_REGISTRO(INUPRODUCT_ID , 1 );
                    pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE , csbNivelTraza);
                    PKG_ERROR.setErrorMessage(ONUERRORCODE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE);
                    RAISE PKG_ERROR.CONTROLLED_ERROR;
                  END IF;
                ELSE
                    BORRA_REGISTRO(INUPRODUCT_ID , 1 );
                    pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO' , csbNivelTraza);
                    PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO');
                    RAISE PKG_ERROR.CONTROLLED_ERROR;
                END IF;
            ELSE
              BORRA_REGISTRO(INUPRODUCT_ID , 1 );
              pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA ' , csbNivelTraza);
              PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA');
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
          EXCEPTION
            WHEN PKG_ERROR.CONTROLLED_ERROR THEN
              pkg_traza.trace(csbMetodo||' CONTROLLED_ERROR ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN ex.RESOURCE_BUSY THEN -- No reemplazar, soluciona error de concurrencia de ordenes duplicadas
                pkg_traza.trace(csbMetodo||' RESOURCE_BUSY ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
                PKG_ERROR.setErrorMessage(cnuAPPTABLEBUSSY,'['||inuProduct_id ||']|'|| 'LDC_OTREV - RESOURCE_BUSY'  );
                RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN DEADLOCK_DETECTED THEN
                pkg_traza.trace(csbMetodo||' DEADLOCK_DETECTED ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
                PKG_ERROR.setErrorMessage(cnuAPPTABLEBUSSY,'['||inuProduct_id ||']|'|| 'LDC_OTREV' );
                RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN OTHERS THEN
              pkg_traza.trace(csbMetodo||' OTHERS '||sqlerrm , csbNivelTraza, pkg_traza.csbFIN_ERR);
              PKG_ERROR.SETERROR;
              RAISE PKG_ERROR.CONTROLLED_ERROR;

       END LDC_PRGENERAREVISION;

       PROCEDURE LDC_PRGENERAREPARACION(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE) IS

            /*****************************************************************
            PROPIEDAD INTELECTUAL DE PETI.

            UNIDAD         : LDC_REGISTRVISIIDENCERTIXOTREV
            DESCRIPCION    : GENERA TRAMITE DE VISITA DE IDENTIFICACION DE CERTIFICADO POR XML DESDE EL OTROV
            AUTOR          : EMIRO LEYVA H.
            FECHA          : 08/06/2014

            PARAMETROS              DESCRIPCION
            ============         ===================
            NUEXTERNALID:


            HISTORIA DE MODIFICACIONES
            FECHA             AUTOR             MODIFICACION
            =========       =========           ====================
            14/08/2018      DSALTARIN           200-2125 ANTES DE CREAR LA SOLICITUD SE VALIDA SI EXISTEN SOLICITUDES EN PROCESO
                                                CON LA FUNCION LDC_FNUVAL_TRAMITESRP
            14/11/2023      Adrianavg           OSF-1765 Se retira esquema antepuesto a objeto: PR_PRODUCT.
                                                Se reemplaza tipo de dato VARCHAR2(32767)por Constants_Per.TIPO_XML_SOL para la variable SBREQUESTXML1.
                                                Se reemplaza DAPR_PRODUCT.FNUGETADDRESS_ID por PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION, DAAB_ADDRESS.GETRECORD
                                                por PKG_BCDIRECCIONES.FRCGETRECORD, DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID por PKG_BCPRODUCTO.FNUCONTRATO,
                                                PKTBLSUSCRIPC.FNUGETSUSCCLIE(NUSUBSCRIPTIONID) por PKG_BCCONTRATO.FNUIDCLIENTE, PKTBLSERVSUSC.FNUGETCATEGORY(INUPRODUCT_ID)
                                                por PKG_BCPRODUCTO.FNUCATEGORIA, PKTBLSERVSUSC.FNUGETSESUSUCA(INUPRODUCT_ID) por PKG_BCPRODUCTO.FNUSUBCATEGORIA
                                                Se reemplaza OS_REGISTERREQUESTWITHXML por API_RegisterRequestByXML
                                                Se reemplaza armado del XML por PKG_XML_SOLI_REV_PERIODICA.getSolicitudReparacionRp.
                                                Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT por PKG_ERROR.setErrorMessage, EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR
                                                , ERRORS.SETERROR por PKG_ERROR.SETERROR
                                                Se reemplaza Ld_Boconstans.cnuGeneric_Error por Pkg_Error.CNUGENERIC_MESSAGE.
                                                Añadir uso de traza para el proceso y declaración del csbMetodo
                                                Se retiran variables que no se usan NUADDRESS_ID, RCAB_ADDRESS, NUCATE, NUSUCA, 
                                                NUSALDODIFERIDO, SBAPLICAENTR, SBAPLICAMARC, DTPLAZOMINREV
            ******************************************************************/
            ONUERRORCODE     NUMBER;
            OSBERRORMESSAGE  VARCHAR2(4000);
            SBCOMMENT        VARCHAR2(2000) := 'SE GENERAN DESDE OTREV';
            SBREQUESTXML1    Constants_Per.TIPO_XML_SOL%TYPE;
            NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE;
            NUMOTIVEID       MO_MOTIVE.MOTIVE_ID%TYPE;
            NUSUBSCRIBERID   GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
            NUSUBSCRIPTIONID PR_PRODUCT.SUBSCRIPTION_ID%TYPE;
            SW1              NUMBER:=0;  
			NUCANTSOLICITUD	 NUMBER;
            csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'LDC_PRGENERAREPARACION';
          BEGIN

            pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
            pkg_traza.trace(csbMetodo||' inuProduct_id: '||inuProduct_id , csbNivelTraza);
            pkg_traza.trace(csbMetodo||' SW1: '||SW1 , csbNivelTraza);
           --  BUSCO EL ADDRESS_ID DEL PRODUCTO
            IF SW1 = 0 THEN
              NUCANTSOLICITUD := LDC_FNUVAL_TRAMITESRP(INUPRODUCT_ID);
              pkg_traza.trace(csbMetodo||' nucantsolicitud: '||NUCANTSOLICITUD , csbNivelTraza);
              IF NUCANTSOLICITUD = 0 THEN
                NUSUBSCRIPTIONID := PKG_BCPRODUCTO.FNUCONTRATO(INUPRODUCT_ID);
                pkg_traza.trace(csbMetodo||' nusubscriptionid: '||NUSUBSCRIPTIONID , csbNivelTraza);
                NUSUBSCRIBERID   := PKG_BCCONTRATO.FNUIDCLIENTE(NUSUBSCRIPTIONID);
                pkg_traza.trace(csbMetodo||' nusubscriberid: '||NUSUBSCRIBERID , csbNivelTraza);
                -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_PACKAGES
                pkg_traza.trace(csbMetodo||' inuMedioRecepcionId: '||dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP') , csbNivelTraza);
                pkg_traza.trace(csbMetodo||' sbcomment: '||SBCOMMENT , csbNivelTraza);
                SBREQUESTXML1 := PKG_XML_SOLI_REV_PERIODICA.getSolicitudReparacionRp
                               (dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_REPARACION_PRP'),  --inuMedioRecepcionId
                                SBCOMMENT,     --isbComentario
                                INUPRODUCT_ID, --inuProductoId
                                NUSUBSCRIBERID --inuClienteId
                                );
                pkg_traza.trace(csbMetodo||' SBREQUESTXML1: '||SBREQUESTXML1 , csbNivelTraza);
                API_RegisterRequestByXML(SBREQUESTXML1,
                                         NUPACKAGE_ID,
                                         NUMOTIVEID,
                                         ONUERRORCODE,
                                         OSBERRORMESSAGE);
                pkg_traza.trace(csbMetodo||' nupackage_id: '||NUPACKAGE_ID , csbNivelTraza);
                pkg_traza.trace(csbMetodo||' numotiveid: '||NUMOTIVEID , csbNivelTraza);

                IF ONUERRORCODE = 0 THEN
                    BORRA_REGISTRO(INUPRODUCT_ID , 2 );
                ELSE
                    BORRA_REGISTRO(INUPRODUCT_ID , 2 );
                    pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE , csbNivelTraza);
                    PKG_ERROR.setErrorMessage(ONUERRORCODE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE);
                RAISE PKG_ERROR.CONTROLLED_ERROR;
                END IF;
              ELSE
                  BORRA_REGISTRO(INUPRODUCT_ID , 2 );
                  pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO' , csbNivelTraza);
                  PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO');
                  RAISE PKG_ERROR.CONTROLLED_ERROR;
              END IF;
            ELSE
              BORRA_REGISTRO(INUPRODUCT_ID , 2 );
              pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA' , csbNivelTraza);
              PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA');
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
          EXCEPTION
            WHEN PKG_ERROR.CONTROLLED_ERROR THEN
              pkg_traza.trace(csbMetodo||' CONTROLLED_ERROR ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
              PKG_ERROR.SETERROR;
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN OTHERS THEN
              pkg_traza.trace(csbMetodo||' OTHERS '||sqlerrm , csbNivelTraza, pkg_traza.csbFIN_ERR);
              PKG_ERROR.SETERROR;
              RAISE PKG_ERROR.CONTROLLED_ERROR;

       END LDC_PRGENERAREPARACION;

       PROCEDURE LDC_PRGENERACERTIFICAC(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE) IS

            /*****************************************************************
            PROPIEDAD INTELECTUAL DE PETI.

            UNIDAD         : LDC_REGISTRVISIIDENCERTIXOTREV
            DESCRIPCION    : GENERA TRAMITE DE VISITA DE IDENTIFICACION DE CERTIFICADO POR XML DESDE EL OTROV
            AUTOR          : EMIRO LEYVA H.
            FECHA          : 08/06/2014

            PARAMETROS              DESCRIPCION
            ============         ===================
            NUEXTERNALID:


            HISTORIA DE MODIFICACIONES
            FECHA             AUTOR             MODIFICACION
            =========       =========           ====================
            14/08/2018      DSALTARIN           200-2125 ANTES DE CREAR LA SOLICITUD SE VALIDA SI EXISTEN SOLICITUDES EN PROCESO
                                                CON LA FUNCION LDC_FNUVAL_TRAMITESRP
            14/11/2023      Adrianavg           OSF-1765 Se retira esquema antepuesto a objeto: PR_PRODUCT. Se reemplaza tipo de dato
                                                VARCHAR2(32767)por Constants_Per.TIPO_XML_SOL para la variable SBREQUESTXML1. Se reemplaza
                                                DAPR_PRODUCT.FNUGETADDRESS_ID por PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION, DAAB_ADDRESS.GETRECORD
                                                por PKG_BCDIRECCIONES.FRCGETRECORD, DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID por PKG_BCPRODUCTO.FNUCONTRATO,
                                                PKTBLSUSCRIPC.FNUGETSUSCCLIE(NUSUBSCRIPTIONID) por PKG_BCCONTRATO.FNUIDCLIENTE, PKTBLSERVSUSC.FNUGETCATEGORY(INUPRODUCT_ID)
                                                por PKG_BCPRODUCTO.FNUCATEGORIA, PKTBLSERVSUSC.FNUGETSESUSUCA(INUPRODUCT_ID) por PKG_BCPRODUCTO.FNUSUBCATEGORIA
                                                Se reemplaza OS_REGISTERREQUESTWITHXML por API_RegisterRequestByXML
                                                Se reemplaza armado del XML por PKG_XML_SOLI_REV_PERIODICA.getXMSolicitudCertificacionRp. Se reemplaza GE_BOERRORS.SETERRORCODEARGUMENT
                                                por PKG_ERROR.setErrorMessage, EX.CONTROLLED_ERROR por PKG_ERROR.CONTROLLED_ERROR, ERRORS.SETERROR; por PKG_ERROR.SETERROR
                                                Se reemplaza Ld_Boconstans.cnuGeneric_Error por Pkg_Error.CNUGENERIC_MESSAGE. Añadir uso de traza para el proceso y declaración del csbMetodo
                                                Se retiran variables que no se usan NUADDRESS_ID, RCAB_ADDRESS, NUCATE, NUSUCA, NUSALDODIFERIDO,SBAPLICAMARC, SBAPLICAENTR, DTPLAZOMINREV
            ******************************************************************/
            ONUERRORCODE     NUMBER;
            OSBERRORMESSAGE  VARCHAR2(4000);
            SBCOMMENT        VARCHAR2(2000) := 'SE GENERAN DESDE OTREV';
            SBREQUESTXML1    Constants_Per.TIPO_XML_SOL%TYPE; 
            NUPACKAGE_ID     MO_PACKAGES.PACKAGE_ID%TYPE;
            NUMOTIVEID       MO_MOTIVE.MOTIVE_ID%TYPE;
            NUSUBSCRIBERID   GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE;
            NUSUBSCRIPTIONID PR_PRODUCT.SUBSCRIPTION_ID%TYPE; 
            SW1              NUMBER:=0; 
			NUCANTSOLICITUD	 NUMBER;
            csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'LDC_PRGENERACERTIFICAC';

          BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
            pkg_traza.trace(csbMetodo||' inuProduct_id: '||inuProduct_id , csbNivelTraza);
            pkg_traza.trace(csbMetodo||' SW1: '||SW1 , csbNivelTraza);
           --  BUSCO EL ADDRESS_ID DEL PRODUCTO
            IF SW1 = 0 THEN
                NUCANTSOLICITUD := LDC_FNUVAL_TRAMITESRP(INUPRODUCT_ID);
                pkg_traza.trace(csbMetodo||' nucantsolicitud: '||NUCANTSOLICITUD , csbNivelTraza);
                IF NUCANTSOLICITUD = 0 THEN
                  NUSUBSCRIPTIONID := PKG_BCPRODUCTO.FNUCONTRATO(INUPRODUCT_ID);
                  pkg_traza.trace(csbMetodo||' nusubscriptionid: '||NUSUBSCRIPTIONID , csbNivelTraza);
                  NUSUBSCRIBERID   := PKG_BCCONTRATO.FNUIDCLIENTE(NUSUBSCRIPTIONID);
                  pkg_traza.trace(csbMetodo||' nusubscriberid: '||NUSUBSCRIBERID , csbNivelTraza);
                  -- SE INICIALIZA EL REGISTRO PARA CREAR EL MO_PACKAGES
                  pkg_traza.trace(csbMetodo||' inuMedioRecepcionId: '||dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_CERT_PRP') , csbNivelTraza);
                  pkg_traza.trace(csbMetodo||' sbcomment: '||SBCOMMENT , csbNivelTraza);
                SBREQUESTXML1 := PKG_XML_SOLI_REV_PERIODICA.getXMSolicitudCertificacionRp
                               (dald_parameter.fnuGetNumeric_Value('MEDIO_RECEPCION_CERT_PRP'), --inuMedioRecepcionId
                                SBCOMMENT,     --isbComentario
                                INUPRODUCT_ID, --inuProductoId
                                NUSUBSCRIBERID --inuClienteId
                                );
                pkg_traza.trace(csbMetodo||' SBREQUESTXML1: '||SBREQUESTXML1 , csbNivelTraza);
                API_RegisterRequestByXML(SBREQUESTXML1,
                                         NUPACKAGE_ID,
                                         NUMOTIVEID,
                                         ONUERRORCODE,
                                         OSBERRORMESSAGE);
                pkg_traza.trace(csbMetodo||' nupackage_id: '||NUPACKAGE_ID , csbNivelTraza);
                pkg_traza.trace(csbMetodo||' numotiveid: '||NUMOTIVEID , csbNivelTraza);

                  IF ONUERRORCODE = 0 THEN
                    BORRA_REGISTRO(INUPRODUCT_ID , 3 );
                  ELSE
                  BORRA_REGISTRO(INUPRODUCT_ID , 3 );
                  pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE , csbNivelTraza);
                  PKG_ERROR.setErrorMessage(ONUERRORCODE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR:'||OSBERRORMESSAGE);
                  RAISE PKG_ERROR.CONTROLLED_ERROR;
                  END IF;
               ELSE
                BORRA_REGISTRO(INUPRODUCT_ID , 3 );
                pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO' , csbNivelTraza);
                PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE SOLICITUDES EN PROCESO');
                RAISE PKG_ERROR.CONTROLLED_ERROR;
               END IF;
            ELSE
              BORRA_REGISTRO(INUPRODUCT_ID , 3 );
              pkg_traza.trace(csbMetodo||' ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA' , csbNivelTraza);
              PKG_ERROR.setErrorMessage(Pkg_Error.CNUGENERIC_MESSAGE, 'ERROR PROCESANDO EL PRODUCTO: '||INUPRODUCT_ID||'. ERROR: EL PRODUCTO TIENE MARCA');
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            END IF;
          pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
          EXCEPTION
            WHEN PKG_ERROR.CONTROLLED_ERROR THEN
              pkg_traza.trace(csbMetodo||' CONTROLLED_ERROR ' , csbNivelTraza, pkg_traza.csbFIN_ERC);
              PKG_ERROR.SETERROR;
              RAISE PKG_ERROR.CONTROLLED_ERROR;
            WHEN OTHERS THEN
              pkg_traza.trace(csbMetodo||' OTHERS '||sqlerrm , csbNivelTraza, pkg_traza.csbFIN_ERR);
              PKG_ERROR.SETERROR;
              RAISE PKG_ERROR.CONTROLLED_ERROR;

       END LDC_PRGENERACERTIFICAC;


     FUNCTION  LDC_FNUVAL_TRAMITESRP(INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE) RETURN NUMBER IS
            /*****************************************************************
            PROPIEDAD INTELECTUAL DE PETI.

            UNIDAD         : LDC_FNUVAL_TRAMITESRP
            DESCRIPCION    : 200-2125 Se crea funcion para validar si el producto tiene tramites de RP en PROCESO
            AUTOR          : DSALTARIN
            FECHA          : 14/08/2018

            PARAMETROS              DESCRIPCION
            ============         ===================
            NUEXTERNALID:


            HISTORIA DE MODIFICACIONES
            FECHA             AUTOR             MODIFICACION
            =========       =========           ====================
            14/11/2023      Adrianavg        OSF-1765 Se retira esquema antepuesto a objeto: PR_PRODUCT.
                                             Se reemplaza la función ldc_boutilities.splitstrings por regexp_substr.
                                             Añadir uso de traza para el proceso y declaración del csbMetodo
            ******************************************************************/
	       CURSOR cuSolicitudes is
			 SELECT COUNT(DISTINCT P.PACKAGE_ID)
					FROM MO_PACKAGES P, MO_MOTIVE M
					WHERE P.PACKAGE_ID = M.PACKAGE_ID
					AND PACKAGE_TYPE_ID IN(SELECT regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_TIPO_PAQUETE_OTREV',NULL), '[^,]+', 1, LEVEL)AS tasks_type
                                             FROM dual
                                           CONNECT BY regexp_substr(DALD_PARAMETER.fsbGetValue_Chain('VAL_TIPO_PAQUETE_OTREV',NULL), '[^,]+', 1, LEVEL) IS NOT NULL)
					AND M.PRODUCT_ID = INUPRODUCT_ID
					AND P.MOTIVE_STATUS_ID NOT IN (14,32,51);
			nuCantSolicitudes number:=0;
           csbMetodo CONSTANT VARCHAR2(60) := csbNOMPKG||'LDC_PRGENERACERTIFICAC';
		BEGIN
            pkg_traza.trace(csbMetodo, csbNivelTraza,pkg_traza.csbINICIO);
            pkg_traza.trace(csbMetodo||' inuProduct_id: '||inuProduct_id , csbNivelTraza);

			IF cuSolicitudes%ISOPEN THEN
				CLOSE cuSolicitudes;
			END IF;
			OPEN cuSolicitudes;
			FETCH cuSolicitudes INTO nuCantSolicitudes;
			IF cuSolicitudes%NOTFOUND THEN
				nuCantSolicitudes :=0;
			END IF;
			CLOSE cuSolicitudes;
            pkg_traza.trace(csbMetodo||' nuCantSolicitudes: '||nuCantSolicitudes , csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
			RETURN nuCantSolicitudes;

	   EXCEPTION
		WHEN OTHERS THEN
          pkg_traza.trace(csbMetodo||' OTHERS '||sqlerrm , csbNivelTraza, pkg_traza.csbFIN_ERR);
		  return nuCantSolicitudes;
	   END;
END LDC_PKGENERATRAMITESOTREV;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENERATRAMITESOTREV
BEGIN
  pkg_utilidades.prAplicarPermisos('LDC_PKGENERATRAMITESOTREV','OPEN');
END;
/
