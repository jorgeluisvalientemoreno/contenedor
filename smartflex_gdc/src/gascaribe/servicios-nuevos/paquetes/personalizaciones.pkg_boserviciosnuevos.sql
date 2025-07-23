CREATE OR REPLACE PACKAGE personalizaciones.pkg_boserviciosnuevos IS
/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Paquete     :   pkg_boserviciosnuevos
    Autor       :   Lubin Pineda - GlobalMVM
    Fecha       :   09/01/2025
    Descripcion :   Paquete programas para Servicios Nuevos migrados de
                    LDC_PKGESTNUESQSERVNUE
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/01/2025  OSF-3828 Creacion
*******************************************************************************/

    -- Retorna Identificador del ultimo caso que hizo cambios en este archivo
    FUNCTION fsbVersion RETURN VARCHAR2;
    
    -- proceso que genera tramite de reconexion de servicio nuevo
    PROCEDURE prGeneOrdReco
    (
        inuOrden    IN  NUMBER,
        inuProducto IN  NUMBER ,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    );

    PROCEDURE prAnulOrdCerYsus(inuProducto IN pr_product.product_id%type);
    
END pkg_boserviciosnuevos;
/

CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boserviciosnuevos IS

    -- Identificador del ultimo caso que hizo cambios en este archivo
    csbVersion                 VARCHAR2(15) := 'OSF-3828';

    -- Constantes para el control de la traza
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe y Efigas
    Programa        : fsbVersion 
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete 
    Autor           : Lubin Pineda - MVM 
    Fecha           : 09/01/2025 
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     09/01/2025  OSF-3828 Creacion
    ***************************************************************************/    
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;
    
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2019-11-25
      Proceso     : prGeneOrdReco
      Ticket      : 19
      Descripcion : proceso que genera tramite de reconexion de servicio nuevo

      Parametros Entrada
        inuOrden      numero de la orden
        inuProducto   numero de producto
      Valor de salida
        onuError      codigo de error
        osbError      mensaje de error

      HISTORIA DE MODIFICACIONES
      FECHA        	AUTOR       	DESCRIPCION
	  ==========	=========		===================
	  24/07/2023	jerazomvm		CASO OSF-1261:
									1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
									2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
									3. Se reemplaza el API OS_RegisterRequestWithXML por el API api_registerRequestByXml.
  ***************************************************************************/                    
    PROCEDURE prGeneOrdReco
    (
        inuOrden    IN  NUMBER,
        inuProducto IN  NUMBER ,
        onuError    OUT NUMBER,
        osbError    OUT VARCHAR2
    ) 
    IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prGeneOrdReco';
        
        sbRequestXML  VARCHAR2(4000); --se almacena XMl para
        nuPackage_id NUMBER; --se almacena codigo de la solicitud
        nuMotiveId NUMBER; --se almacena codigo del motivo

        inuSUSPENSION_TYPE_ID NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIPOSUSPRECSN'); --se almacena el tipo de suspension
        nutipoCausal NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_TIPOCAURECSN'); --se almacena el tipo de causal
        nuCausal  NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CAUSSUSPRECSN'); --se almacena la causal de suspension
        nuCliente NUMBER; --se obtiene cliente de la orden de trabajo
        nuProducto NUMBER; --se obtiene producto de la orden de trabajo
        sbComment   VARCHAR2(4000); --se almacena comentario de la suspension
        nuPersona NUMBER; --se almacena persona que legaliza
        nuUnidadOpera number; --se almacena unidad operativa
        nuDireccion NUMBER;

        nuCausalLeg NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CAUSLEGRECOSN');
        nuCodigoAtrib NUMBER:= pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CODPALECT'); --se almacena codigo del parametro
        sbNombreoAtrib VARCHAR2(400) :=  pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_NOMBATRLECT'); --se almacena nombre del parametro
        nuLectura NUMBER; --se almacena lectura

        rcLDC_BLOQ_LEGA_SOLICITUD   pkg_LDC_BLOQ_LEGA_SOLICITUD.cuLDC_BLOQ_LEGA_SOLICITUD%ROWTYPE;

        rcLDC_ORDEASIGPROC          pkg_LDC_ORDEASIGPROC.cuLDC_ORDEASIGPROC%ROWTYPE;
        
        --Tipo de Recepcion 10 - Orden de procedimiento interno
        cnuTIPO_RECEP_PROC_INTERNO  ge_reception_type.reception_type_id%TYPE := 10;
        
    BEGIN
  
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
    
        pkg_Traza.Trace('inuOrden: ' || inuOrden|| ' inuProducto: '||inuProducto, csbNivelTraza);
      
        onuError := 0;
           
        IF inuOrden IS NOT NULL THEN
        
            nuUnidadOpera := PKG_BCORDENES.FNUOBTIENEUNIDADOPERATIVA(inuOrden); --unidad operativa
            nuPersona := PKG_BCORDENES.FNUOBTENERPERSONA( inuOrden ); -- persona que legaliza
          
            pkg_Traza.Trace('nuUnidadOpera '||nuUnidadOpera , csbNivelTraza);
            pkg_Traza.Trace('nuPersona '||nuPersona , csbNivelTraza);
        
            nuLectura := pkg_OR_TEMP_DATA_VALUES.fsbObtDATA_VALUE(inuOrden,nuCodigoAtrib,TRIM(sbNombreoAtrib)); 

            pkg_Traza.Trace('nuLectura '||nuLectura , csbNivelTraza);
                
            IF nuLectura  is null then
                onuError := -1;
                osbError := 'Proceso termino con errores : '||'No se ha digitado Lectura';
                RAISE PKG_ERROR.CONTROLLED_ERROR;
            END IF;
        END IF;
         
        --se carga producto y cliente        
        nuCliente := pkg_bcContrato.fnuIdCliente ( pkg_bcproducto.fnuContrato( inuProducto ) ); 
      
        nuDireccion := pkg_bcproducto.fnuIdDireccInstalacion( inuProducto );
        
		pkg_Traza.Trace('nuCliente '||nuCliente , csbNivelTraza);
		
        sbComment :='RECONEXION POR SERVICIO NUEVO OT LEGALIZADA['||inuOrden||']';
        
        IF inuOrden IS NULL THEN
            sbComment :='RECONEXION POR APROBACION DE CERTIFICACION';
        END IF;

        sbRequestXML :=pkg_xml_soli_serv_nuevos.fsbObtXMLSolReconexion
                        ( 

                            inuClienteId        => nuCliente ,
                            inuDireccionId      => nuDireccion,
                            isbComentario       => sbComment,
                            inuProducto         => inuProducto,
                            inuTipoSuspension   => inuSUSPENSION_TYPE_ID,
                            inuTipoRecepcion    => cnuTIPO_RECEP_PROC_INTERNO                 
                        ); 
                        
        pkg_Traza.Trace('sbRequestXML '||sbRequestXML , csbNivelTraza);
		 
        api_registerRequestByXml(sbRequestXML,
								 nuPackage_id,
								 nuMotiveId,
								 onuError,
								 osbError
								 );
								 
		pkg_Traza.Trace('api_registerRequestByXml nuPackage_id: ' || nuPackage_id || chr(10) ||
												'nuMotiveId: '   || nuMotiveId, csbNivelTraza);

        IF onuError <> 0 THEN
            raise PKG_ERROR.CONTROLLED_ERROR;
        ELSE
            IF nuUnidadOpera IS NOT NULL THEN
                pkg_Traza.Trace('insert orden asignar '||nuUnidadOpera , csbNivelTraza);
                
                rcLDC_BLOQ_LEGA_SOLICITUD.PACKAGE_ID_ORIG   := NULL;
                rcLDC_BLOQ_LEGA_SOLICITUD.PACKAGE_ID_GENE   := nuPackage_id;
                
                pkg_LDC_BLOQ_LEGA_SOLICITUD.prInsRegistro( rcLDC_BLOQ_LEGA_SOLICITUD );
                
                rcLDC_ORDEASIGPROC.ORAPORPA :=  inuOrden;
                rcLDC_ORDEASIGPROC.ORAPSOGE :=  nuPackage_id;    
                rcLDC_ORDEASIGPROC.ORAOPELE :=  nuPersona;
                rcLDC_ORDEASIGPROC.ORAOUNID :=  nuUnidadOpera;
                rcLDC_ORDEASIGPROC.ORAOCALE :=  nuCausalLeg;
                rcLDC_ORDEASIGPROC.ORAOITEM :=  nuLectura;
                rcLDC_ORDEASIGPROC.ORAOPROC :=  'RECOSENU';
                
                pkg_LDC_ORDEASIGPROC.prInsRegistro( rcLDC_ORDEASIGPROC );
                
            END IF;
            
        END IF;
        
        pkg_Traza.Trace('fin prGeneOrdReco onuError: ' || onuError || chr(10) || 
                                         'osbError: ' || osbError , csbNivelTraza);
      
      
    EXCEPTION
        when PKG_ERROR.CONTROLLED_ERROR then
           Pkg_error.getError(onuError, osbError);
        when OTHERS then
            Pkg_error.seterror;
            Pkg_error.getError(onuError, osbError);
            raise PKG_ERROR.CONTROLLED_ERROR;
    END prGeneOrdReco;

    /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2020-02-18
    Proceso     : prAnulOrdCerYsus
    Ticket      : 19
    Descripcion : proceso que anula ordenes de suspension y certificacion

    Parametros Entrada
     inuProducto  codigo del producto

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
    05/06/2020   HORBATH     CASO 19: Agregar servicio de anulacion de flujo y commentaria en COMMIT
	24/07/2023	 jerazomvm		CASO OSF-1261:
								1. Se reemplaza el manejo de errores ex y errors por Pkg_error.
								2. Se elimina la funcion fblAplicaEntregaxCaso, para la entrega la cual retorna true.
    ***************************************************************************/    
    PROCEDURE prAnulOrdCerYsus(inuProducto IN pr_product.product_id%type) IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'prAnulOrdCerYsus';
    
        nuerrorcode     NUMBER; -- se almacena codigo de error
        sberrormessage  VARCHAR2(4000); --se almacena mensaje de error
        nuCausal        NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('LDC_CAANUORDEN'); --se almacena causal de legalizacion
        cnuCommentType  NUMBER := 83;
        nuEstadoAnu     NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('ID_ESTADO_PKG_ANULADA');
        nuEstaAnuOt     NUMBER := pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_STATE_CANCEL_OT');
        nuPlanId        NUMBER;
       
        sbfrom          VARCHAR2(4000) := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER'); --  se coloca el emisor del correo
        sbsubject       VARCHAR2(4000) := 'Anulacion de ordenes de Servicio Nuevo';
        sbmsg           VARCHAR2(4000) := 'Se anulo orden [';
        sbTipoSoli      VARCHAR2(200) :=  pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SOLCERTSENU');
        nuExistCert     NUMBER;
       
        tbOrdenServicio pkg_bcserviciosnuevos.tytbOrdenServicio;
            
        CURSOR cuExistCert ( inuTipoSolicitud   NUMBER)
        IS
        SELECT COUNT(1)
        FROM
        (
            SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tisol
            FROM   dual
            CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL
        )
        WHERE tisol =  inuTipoSolicitud ;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO); 
                
        pkg_bcserviciosnuevos.prcObtenerOrdenes( inuProducto => inuProducto, otbOrdenServicio =>  tbOrdenServicio );
        
        FOR i IN 1..tbOrdenServicio.count LOOP 
               
            nuExistCert := 0;
            
            IF tbOrdenServicio(i).ttcert = 1 THEN
            
                OPEN cuExistCert( tbOrdenServicio(i).tiposoli );
                FETCH cuExistCert INTO nuExistCert;
                CLOSE cuExistCert;
                 
            END IF;
            
            IF (nuExistCert = 1 and tbOrdenServicio(i).ttcert = 1) or tbOrdenServicio(i).ttcert = 0  THEN
                  
                SAVEPOINT ldccancelorder;
                
                ldc_cancel_order(
                            tbOrdenServicio(i).order_id,
                            nuCausal,
                            'Anulacion de orden por certificacion de servicio nuevo',
                            cnuCommentType,
                            nuerrorcode,
                            sberrormessage
                            );
  
                IF nuerrorcode <> 0 THEN
                
                    ROLLBACK TO SAVEPOINT ldccancelorder;
                    
                    pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
                    ( 
                        inuOrden        =>  NULL,
                        inuOrdenPadre   =>  tbOrdenServicio(i).order_id,
                        isbProceso      =>  upper('prAnulOrdCerYsus'),
                        isbMensaje      =>  sberrormessage,
                        idtFechaRegistro=>  SYSDATE,
                        isbUsuario      =>  USER
                    );
                                       
                ELSE
                    
                    pkg_Or_Order_Activity.prcActEstado_Orden( tbOrdenServicio(i).order_id  , 'F' ); 
                    
                    pkg_Or_Order.prAcORDER_STATUS_ID( tbOrdenServicio(i).order_id, nuEstaAnuOt );
                      
                    IF tbOrdenServicio(i).PACKAGE_ID IS NOT NULL  THEN

                        BEGIN
                                                                                                        
                            pkgManejoSolicitudes.pFullAnullPackages
                            (
                                tbOrdenServicio(i).PACKAGE_ID,
                                'Se anulo la orden [' ||tbOrdenServicio(i).order_id||'] por certificacion.',
                                nuerrorcode,
                                sberrormessage
                            );

                            IF nuerrorcode = 0 THEN
                            
                                if tbOrdenServicio(i).correo is not null then
                                
                                    begin
                                    
                                        sbmsg := sbmsg||tbOrdenServicio(i).order_id||'] por certificacion.';
                                        
                                        --se envia correo                           
                                        pkg_Correo.prcEnviaCorreo
                                        (
                                            isbRemitente        => sbfrom,
                                            isbDestinatarios    => tbOrdenServicio(i).correo,
                                            isbAsunto           => sbsubject,
                                            isbMensaje          => sbmsg
                                        );
                               
                                    exception
                                        when others then
                                            pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
                                            ( 
                                                inuOrden        =>  NULL,
                                                inuOrdenPadre   =>  tbOrdenServicio(i).order_id,
                                                isbProceso      =>  UPPER('prAnulOrdCerYsus'),
                                                isbMensaje      =>  sqlerrm,
                                                idtFechaRegistro=>  SYSDATE,
                                                isbUsuario      =>  USER
                                            );
                                             
                                    end;
                                end if;
                                
                            ELSE
                            
                                pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
                                ( 
                                    inuOrden        =>  NULL,
                                    inuOrdenPadre   =>  tbOrdenServicio(i).order_id,
                                    isbProceso      =>  UPPER('prAnulOrdCerYsus'),
                                    isbMensaje      =>  sberrormessage,
                                    idtFechaRegistro=>  SYSDATE,
                                    isbUsuario      =>  USER
                                );
                                
                                ROLLBACK TO SAVEPOINT ldccancelorder;
                            
                            END IF;
                      
                        EXCEPTION
                            WHEN OTHERS THEN
                                Pkg_error.SETERROR;
                                Pkg_error.GETERROR(nuerrorcode,sberrormessage);
                                ROLLBACK TO SAVEPOINT ldccancelorder;

                                pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
                                ( 
                                    inuOrden        =>  NULL,
                                    inuOrdenPadre   =>  tbOrdenServicio(i).order_id,
                                    isbProceso      =>  UPPER('prAnulOrdCerYsus'),
                                    isbMensaje      =>  sberrormessage,
                                    idtFechaRegistro=>  SYSDATE,
                                    isbUsuario      =>  USER
                                );

                        END;
                   
                    END IF;
  
                END IF;
                
            END IF;

        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
        
    EXCEPTION
        WHEN PKG_ERROR.controlled_error THEN
            Pkg_error.geterror(nuerrorcode, sberrormessage);
            
            pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
            ( 
                inuOrden        =>  NULL,
                inuOrdenPadre   =>  -1,
                isbProceso      =>  UPPER('prAnulOrdCerYsus'),
                isbMensaje      =>  sberrormessage,
                idtFechaRegistro=>  SYSDATE,
                isbUsuario      =>  USER
            );
            
            RAISE  PKG_ERROR.controlled_error;
        WHEN OTHERS THEN
            Pkg_error.seterror;
            Pkg_error.geterror(nuerrorcode, sberrormessage);

            pkg_LDC_LOGERRLEGSERVNUEV.prInsRegistro
            ( 
                inuOrden        =>  NULL,
                inuOrdenPadre   =>  -1,
                isbProceso      =>  UPPER('prAnulOrdCerYsus'),
                isbMensaje      =>  sberrormessage,
                idtFechaRegistro=>  SYSDATE,
                isbUsuario      =>  USER
            );
            
            RAISE PKG_ERROR.controlled_error;
    END prAnulOrdCerYsus;    
      
END pkg_boserviciosnuevos;
/

Prompt Otorgando permisos sobre personalizaciones.pkg_boserviciosnuevos
BEGIN
    pkg_Utilidades.prAplicarPermisos(upper('pkg_boserviciosnuevos'), 'personalizaciones');
END;
/

