CREATE OR REPLACE PACKAGE personalizaciones.ldc_pkgapprovedRequests
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> ldc_pkgapprovedRequests </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Paquete de gestión para desviculación de ordenes
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="10-02-2023" Inc="OSF-882" Empresa="GDC">
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
    (
        inuContrato     open.suscripc.susccodi%TYPE
    )
    RETURN constants_per.tyrefcursor ;
    
    PROCEDURE prProcess
    (
        inuPackageId    IN  open.mo_packages.package_id%TYPE,
        isbObservation  IN  open.ge_message.description%TYPE
    );

END ldc_pkgapprovedRequests;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.ldc_pkgapprovedRequests
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> ldc_pkgapprovedRequests </Unidad>
    <Autor> felipe.valencia </Autor>
    <Fecha> 10-02-2023 </Fecha>
    <Descripcion> 
        Paquete de gestión para desvinculación de ordenes
    </Descripcion>
    <Historial>
           <Modificacion Autor="felipe.valencia" Fecha="10-02-2023" Inc="OSF-882" Empresa="GDC">
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
    gsbErrMsg           open.GE_ERROR_LOG.DESCRIPTION%TYPE;
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
        Función que permite otener las solicitudes que se desean aprobar
    </Descripcion>
    <Retorno Nombre="Cursor" Tipo="constants_per.tyrefcursor">
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
    (
        inuContrato     open.suscripc.susccodi%TYPE
    )
    RETURN constants_per.tyrefcursor 
    IS
        rfresult constants_per.tyrefcursor;

        sbSolicitudes   VARCHAR2(4000) := personalizaciones.ldc_bcconsgenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID', 'TIPO_SOL_REQ_APROB_ANUL');

        sbTaskTypeId   varchar2(2000);
            
    BEGIN
        ut_trace.trace('Inicia ldc_pkgapprovedRequests.frfgetSolicitudesAprobar', 10);
        
        ut_trace.trace('Contrato inuContrato'||inuContrato, 11);

        sbTaskTypeId := personalizaciones.ldc_bcconsgenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID', 'ID_TT_VALIDA_VENTA');
        
        OPEN rfresult FOR 
        SELECT  mp.package_id "Solicitud",
                mt.motive_id "Motivo",
                mt.subscription_id "Contrato",
                mp.request_date  "Fecha Solicitud",
                (
                    SELECT  motive_status_id ||'-'||description 
                    FROM    open.PS_MOTIVE_STATUS 
                    WHERE   moti_status_type_id = 2
                    AND     motive_status_id =mp.motive_status_id
                ) "Estado Solicitud",
                (
                    SELECT  package_type_id||' - '|| description 
                    FROM    open.ps_package_type 
                    WHERE   package_type_id = mp.package_type_id
                ) "Tipo Solicitud"
        FROM    OPEN.MO_PACKAGES mp,
                open.mo_motive mt
        WHERE   mp.package_id = mt.package_id
        AND     mt.subscription_id in (inuContrato)
        AND     (
                    SELECT COUNT(1)
                    FROM (
                            SELECT to_number(regexp_substr(sbSolicitudes,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS packages_
                            FROM dual
                            CONNECT BY regexp_substr(sbSolicitudes, '[^,]+', 1, LEVEL
                                                    ) IS NOT NULL
                         )
                    WHERE packages_ = mp.package_type_id
                ) > 0
        AND mp.motive_status_id = 13
        AND EXISTS (
            SELECT  oo.order_id
            FROM    open.or_order oo,
                    open.or_order_activity oa,
                    open.ge_causal gc,
                    open.ge_class_causal cc
             WHERE  oo.order_id = oa.order_id
             AND    oo.causal_id = gc.causal_id
             AND    oa.package_id = mp.package_id
             AND     cc.class_causal_id = gc.class_causal_id 
             AND    cc.class_causal_id = 1
             AND    oo.task_type_id in (12149,12151,12150,12152,12162)
        )
        AND NOT EXISTS (
                
                        SELECT  package_id 
                        FROM    personalizaciones.LDC_APPROVED_REQUESTS
                        WHERE   package_id = mp.package_id
                    );

        ut_trace.trace('Fin ldc_pkgapprovedRequests.frfgetSolicitudesAprobar', 10);
        return rfresult;

	EXCEPTION
		When ex.CONTROLLED_ERROR then
			raise ex.CONTROLLED_ERROR;
		When others then
			Errors.setError;
			raise ex.CONTROLLED_ERROR;
    END frfgetSolicitudesAprobar;
    
    PROCEDURE prProcess
    (
        inuPackageId    IN  open.mo_packages.package_id%TYPE,
        isbObservation  IN  open.ge_message.description%TYPE
    ) 
    IS
        nuErrorCode         NUMBER;
        sbErrorMesse        VARCHAR2(4000);
        
        CURSOR cuInfoSolicitud
        (
            inuSolcitud   IN open.mo_packages.package_id%TYPE
        )   
        IS
        SELECT  s.motive_status_id, m.package_id,m.product_id, m.motive_id
        FROM    open.mo_motive m,
                open.mo_packages s
        WHERE   m.package_id = s.package_id
        AND     s.package_id = inuSolcitud;
        
        CURSOR cuEstadoProducto
        (
            inuProducto IN open.pr_product.product_id%TYPE
        )
        IS
        SELECT product_status_id,sesuesco 
        FROM open.pr_product p, open.servsusc c 
        WHERE product_id = sesunuse and product_id = inuProducto;
        
        rcSolicitud cuInfoSolicitud%ROWTYPE;
        rcProducto cuEstadoProducto%ROWTYPE;

        cnuNULL_ATTRIBUTE constant number := 2741;
    BEGIN
        ut_trace.trace('Inicia ldc_pkgapprovedRequests.prProcess', 10);

        ut_trace.trace('Solicitud No.'||inuPackageId, 10);
        
        OPEN cuInfoSolicitud(inuPackageId);
        FETCH cuInfoSolicitud  INTO rcSolicitud;
        CLOSE cuInfoSolicitud;
        
        OPEN cuEstadoProducto(rcSolicitud.product_id);
        FETCH cuEstadoProducto  INTO rcProducto;
        CLOSE cuEstadoProducto;

        IF (rcProducto.product_status_id != 15) THEN
            Errors.SetError (cnuNULL_ATTRIBUTE, 'No se puede realizar la aprobación a productos en estado diferente de 15 - Pendiente por instalación');
            raise ex.CONTROLLED_ERROR;
        END IF;

        INSERT INTO personalizaciones.ldc_approved_requests
        VALUES (
            inuPackageId,
            sysdate,
            isbObservation,
            USER,
            USERENV('TERMINAL')
        );
        
        ut_trace.trace('Fin ldc_pkgapprovedRequests.prProcess', 10);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN others THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END prProcess;

END ldc_pkgapprovedRequests;
/