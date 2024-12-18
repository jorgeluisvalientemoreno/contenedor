CREATE OR REPLACE PACKAGE adm_person.ldc_uiapprovedRequests
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> ldc_uiapprovedRequests </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Paquete ui de pb LDCAPANUL hace integración con personalizaciones
    </Descripcion>
    <Historial>    
           <Modificacion Autor="paola.acosta" Fecha="25-06-2024" Inc="OSF-2878" Empresa="GDC">
               Cambio de esquema ADM_PERSON
           </Modificacion>
           <Modificacion Autor="felipe.valencia" Fecha="14-03-2023" Inc="OSF-882" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="10-02-2023" Inc="OSF-882" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;


    FUNCTION frfgetSolicitudesAprobar 
    RETURN constants.tyrefcursor ;
    
    PROCEDURE prProcess
    (
        isbPackage      IN VARCHAR2,
        inucurrent      IN NUMBER,
        inutotal        IN NUMBER,
        onuerrorcode    OUT ge_error_log.message_id%TYPE,
        osberrormess    OUT ge_error_log.description%TYPE
    );

END ldc_uiapprovedRequests;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ldc_uiapprovedRequests
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> ldc_uiapprovedRequests </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 14-03-2023 </Fecha>
    <Descripcion> 
        Paquete ui de pb LDCAPANUL hace integración con personalizaciones
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="14-03-2023" Inc="OSF-882" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes VERSION DEL PAQUETE
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-882';
    
    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    gsbErrMsg           GE_ERROR_LOG.DESCRIPTION%TYPE;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="10-02-2023" Inc="OSF-882" Empresa="GDC"> 
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

    /**************************************************************************
    <Procedure Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> frfgetSolicitudesAprobar </Unidad>
    <Autor> Luis Felipe Valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Función que permite otener la ordenes legalizadas con exitos que se pueden
        vincular
    </Descripcion>
    <Retorno Nombre="Cursor" Tipo="constants.tyrefcursor">
        Cursor Referenciado
    </Retorno>   
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="10-02-2023" Inc="OSF-882" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </Procedure>
    **************************************************************************/
    FUNCTION frfgetSolicitudesAprobar 
    RETURN constants.tyrefcursor 
    IS
        rfresult constants.tyrefcursor;

        cnuNULL_ATTRIBUTE constant number := 2741;

        sbContrato      ge_boInstanceControl.stysbValue;
        nuContrato      NUMBER;
    BEGIN
        ut_trace.trace('Inicia ldc_uiapprovedRequests.frfgetSolicitudesAprobar', 10);
        
        sbContrato := ge_boInstanceControl.fsbGetFieldValue ('SUSCRIPC', 'SUSCCODI');
        
        IF (sbContrato IS NULL) THEN
            Errors.SetError (cnuNULL_ATTRIBUTE, 'El contrato no puede estar vacia');
            raise ex.CONTROLLED_ERROR;
        END IF;
        
        nuContrato := TO_NUMBER(sbContrato);
        
        ut_trace.trace('Contrato sbContrato'||sbContrato, 11);
        
        rfresult := personalizaciones.ldc_pkgapprovedRequests.frfgetSolicitudesAprobar(nuContrato);

        ut_trace.trace('Fin ldc_uiapprovedRequests.frfgetSolicitudesAprobar', 10);
        return rfresult;
    EXCEPTION
        WHEN Login_Denied OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE;
    WHEN EX.CONTROLLED_ERROR THEN
        PKERRORS.POP;
        RAISE;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GSBERRMSG);
        PKERRORS.POP;
        Raise_Application_Error(PKCONSTANTE.NUERROR_LEVEL2, GSBERRMSG);
    END frfgetSolicitudesAprobar;
    
    PROCEDURE prProcess
    (
        isbPackage      IN VARCHAR2,
        inucurrent      IN NUMBER,
        inutotal        IN NUMBER,
        onuerrorcode    OUT ge_error_log.message_id%TYPE,
        osberrormess    OUT ge_error_log.description%TYPE
    ) 
    IS
        nuSolicitud         NUMBER; 
        nuErrorCode         NUMBER;
        sbErrorMesse        VARCHAR2(4000);

        cnuNULL_ATTRIBUTE constant number := 2741;

        sbObservation      ge_boInstanceControl.stysbValue;
    BEGIN
        ut_trace.trace('Inicia ldc_uiapprovedRequests.prProcess', 10);

        sbObservation := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER_COMMENT', 'ORDER_COMMENT');
        
        IF (sbObservation IS NULL) THEN
            Errors.SetError (cnuNULL_ATTRIBUTE, 'La observación no puede estar vacia');
            raise ex.CONTROLLED_ERROR;
        END IF;

        nuSolicitud := TO_NUMBER(isbPackage);
        ut_trace.trace('Solicitud No.'||isbPackage, 10);
   
        personalizaciones.ldc_pkgapprovedRequests.prProcess(nuSolicitud, sbObservation);

        ut_trace.trace('Fin ldc_uiapprovedRequests.prProcess', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END prProcess;

END ldc_uiapprovedRequests;
/
PROMPT Otorgando permisos de ejecucion a LDC_UIAPPROVEDREQUESTS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_UIAPPROVEDREQUESTS', 'ADM_PERSON');
END;
/