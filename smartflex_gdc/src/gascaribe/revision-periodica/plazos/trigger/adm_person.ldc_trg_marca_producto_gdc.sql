CREATE OR REPLACE TRIGGER adm_person.ldc_trg_marca_producto_gdc
    /*****************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : ldc_trg_marca_producto_gdc
    Descripcion    : Disparador que elimina el registro asociado 
                     al producto cada vez que se actualiza la tabla
                     ldc_plazos_cert
    Autor          : Sayra Ocoro
    Fecha          : 14/05/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    27-04-2023        felipe.valencia   Refactoring de codigo y anulación de solicitudes
                                        centralizada
    28-03-2023        felipe.valencia   Se realiza modificación para cuando se anule la solicitud se anule
                                        la iteración.
    18/07/2019        ESANTIAGO         (Horbath) CASO:14 actualizara el campo REGISTER_POR_DEFECTO con N de la tabla
                                        ldc_marca_producto,dependiendo del producto que se ste validando,
                                        si cumple con la condicion de la validacion del aplica entrega
                                        y si es una unidad operativa interna.
    09/05/2019        ELAL              ca 200-2440 se quita registro de cambio de estado de la orden doble, dejando el que tiene el proceso
                                        LDC_CANCEL_ORDER
    22-08-2018        lsalazar          Caso 200-2095: Agregar validacion de aplicacion en empresa, para borrar el doble cobro

    18/07/2018      dsaltarin        Caso 200-2042: Se elimina el llamado al paquete ldc_pkg_changstatesolici
    12/07/2017        Jorge Valiente    Caso 200-1320: Se cambia la logica del CASO 200-529 y se validara dentro de cada
                                                       logica asignada a cada gasera.
                                                       Se adciono nueva logica silicitada por el funcionario de GDC para que
                                                       ademas de la logica NO permitir anular y atender solcitude.
                                                       Se debe validar unidad opertaiva asiganda a la orden
    20/12/2016        Jorge Valiente    Caso 200-529: Se tomara el TRIGGER fuente de EFIGAS y a este
                                                      se le unificara el codigo existente en el fuente de GDC.
                                                      Se modificaran los cursores para identificar que todas las ordenes
                                                      en estado 0 o 5. Anulan la solicitud.
                                                      En caso de haber almenos una orden en estado diferente a 0 o 5 la
                                                      solicitud sera atendida
    26-05-2015        Sergio Gomez      Se quitan las validaciones para que se cancelen las ordenes cuando se legalize
                                        una orden certificacion, se modifica la condicion y se agregan cursores
                                        para que la validacion cuando se ejecute el trigger sea efectiva. SAO 317066
    18-06-2014        Sayra Ocoro       Se incluye la anulacion de solicitudes de  Notificacion de Suspension
                                        por ausencia de certificado y el cierre de solicitud
    18-10-2024        Lubin Pineda      OSF-3383: Se migra a ADM_PERSON 
    ******************************************************************/
    AFTER INSERT OR UPDATE
    ON OPEN.LDC_PLAZOS_CERT
    FOR EACH ROW
DECLARE
    ----------------------------------------------------------------
    -- Variables y Constantes                                     --
    ----------------------------------------------------------------
    csbTG_NAME          CONSTANT VARCHAR2(100):= 'ldc_trg_marca_producto_gdc';
    cnuNVLTRC           CONSTANT NUMBER       :=  10;
    
    nuPackageId                  mo_packages.package_id%TYPE;
    eerrorexception              EXCEPTION;
    nulineaerror                 NUMBER (3);
    sbmensaje                    VARCHAR2 (2000);
    onuErrorCode                 NUMBER (18);
    osbErrorMessage              VARCHAR2 (2000);
    cnuCommentType      CONSTANT NUMBER := 83;
    nuOrderId                    NUMBER;
    nuSolicitudId                NUMBER;
    nUnitOperExter               NUMBER DEFAULT 0;

    numarcaantes                 ge_suspension_type.suspension_type_id%TYPE;
    numarca                      ge_suspension_type.suspension_type_id%TYPE;

    nuparano                     NUMBER (4);
    nuparmes                     NUMBER (2);
    nutsess                      NUMBER;
    sbparuser                    VARCHAR2 (2000);
    nuOrderAttend                NUMBER;
    nuOrderNoAnull               NUMBER;
    nuTieneOrdenes               NUMBER;
    nuCantAsingReg               NUMBER;
    nuCantCerradas               NUMBER;
    nuCantEjecutad               NUMBER;
    ----------------------------------------------------------------

    ----------------------------------------------------------------
    -- Cursorses                                                  --
    ----------------------------------------------------------------

    --El cursor cuOrdAnula busca las ordenes que se necesitan anular por medio de la solicitud
    CURSOR cuOrdAnula 
    (
        packageId IN NUMBER
    )
    IS
    SELECT  oa.*, ord.order_status_id estado_inicial
    FROM    or_order_activity oa, 
            or_order ord
    WHERE   oa.package_id = packageId
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG'), --0 Orden registrada
                                        dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_ASIGNADA_OT') --5 Orden Asignada
                                    );     

    CURSOR cuSolAnula
    (
        productoId IN NUMBER
    )
    IS
    SELECT  mp.package_id
    FROM    mo_packages        mp,
            mo_motive          mo,
            or_order_activity  oa,
            or_order           ord
    WHERE   mo.product_id = productoId
    AND     mp.motive_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('ID_ESTADO_PKG_ANULADA',NULL) --32. ESTADO ANULADO DE LA SOLICITUD
                                    )
    AND     mp.package_type_id  IN  (
                                        dald_parameter.fnuGetNumeric_Value ('LDC_SUSP_ADMIN_XML',NULL), --100156
                                        dald_parameter.fnuGetNumeric_Value ('LDC_SUSP_ADMIN',NULL), --100013
                                        dald_parameter.fnuGetNumeric_Value ('LDC_NOT_SUSP_CERTIFI',NULL) --100246 Tipos de Solicitudes para anular
                                    )
    AND     mp.package_id = mo.package_id
    AND     oa.package_id = mp.package_id
    AND     oa.task_type_id IN  (
                                    dald_parameter.fnuGetNumeric_Value ('LDC_TT_NOTIF_SUSP',NULL), --10449 SUSPENSION NO CERTIFICADO
                                    dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_SUSP_REVI_RP',NULL), --10450 SUSPENSION X REVISION DE RP
                                    dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_ACOM_CERT_RP',NULL) --12457 SUSPENSION NO CERTIFICADO --tipos de trabajo para anular
                                )
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG'), --0 Orden registrada
                                        dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_ASIGNADA_OT')       --5 Orden Asignada
                                    )
    UNION ALL
    SELECT  mp.package_id
    FROM    mo_packages        mp,
            mo_motive          mo,
            or_order_activity  oa,
            or_order           ord
    WHERE   mo.product_id = productoId
    AND     mp.motive_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('FNB_ESTADOSOL_REG',NULL)-- 13. Estado registrado de una solicitud
                                    )
    AND     mp.package_type_id IN   (
                                        dald_parameter.fnuGetNumeric_Value ('LDC_NOT_SUSP_CERTIFI',NULL)--100246 Tipos de Solicitudes para anular
                                    )
    AND     mp.package_id = mo.package_id
    AND     oa.package_id = mp.package_id
    AND     oa.task_type_id IN  (
                                    dald_parameter.fnuGetNumeric_Value ('LDC_TT_NOTIF_SUSP',NULL) --10449 SUSPENSION NO CERTIFICAD --tipos de trabajo para anular
                                )
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG'), --0 Orden registrada
                                        dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_ASIGNADA_OT')       --5 Orden Asignada
                                    )
    UNION ALL
    SELECT  mp.package_id
    FROM    mo_packages        mp,
            mo_motive          mo,
            or_order_activity  oa,
            or_order           ord
    WHERE   mo.product_id = productoId
    AND     mp.motive_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('FNB_ESTADOSOL_REG',NULL) -- 13. Estado registrado de una solicitud
                                    )
    AND     mp.package_type_id IN   (
                                        dald_parameter.fnuGetNumeric_Value ('LDC_SUSP_ADMIN_XML',NULL),--100156
                                        dald_parameter.fnuGetNumeric_Value ('LDC_SUSP_ADMIN',NULL)    -- 100153
                                    )
    AND     mp.package_id = mo.package_id
    AND     oa.package_id = mp.package_id
    AND     oa.task_type_id IN  (
                                    dald_parameter.fnuGetNumeric_Value('ID_TASKTYPE_SUSP_REVI_RP', NULL), --10450 SUSPENSION X REVISION DE RP
                                    dald_parameter.fnuGetNumeric_Value ('ID_TASKTYPE_ACOM_CERT_RP',NULL) --10449 SUSPENSION NO CERTIFICAD --tipos de trabajo para anular
                                )
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG')); --0 Orden registrada

    --Cursor para identificar solicitudes para ser anuladas
    CURSOR cusolicitudesanula 
    IS
    SELECT  DISTINCT mp.package_id
    FROM    mo_packages        mp,
            mo_motive          mo,
            or_order_activity  oa,
            or_order           ord
    WHERE   mo.product_id = :new.id_producto --productoId
    AND     mp.motive_status_id IN  (dald_parameter.fnuGetNumeric_Value ('FNB_ESTADOSOL_REG')) -- 13. Estado registrado de una solicitud
    AND     mp.package_type_id IN   (
                                        SELECT TO_NUMBER (COLUMN_VALUE)
                                        FROM TABLE (ldc_boutilities.splitstrings (dald_parameter.fsbgetvalue_chain ('COD_SOL_ANU_TRG_MAR_PRO',NULL),','))
                                    )
    AND     mp.package_id = mo.package_id
    AND     oa.package_id = mp.package_id
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG'), --0 Orden registrada
                                        dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_ASIGNADA_OT'));     --5 Orden Asignada

    
    --cursor para identificar las ordenes a anular del paquete de venta de servicio de ingenieria.
    CURSOR cuotanulasolicitud100101 
    IS
    SELECT DISTINCT mp.package_id
    FROM    mo_packages        mp,
            mo_motive          mo,
            or_order_activity  oa,
            or_order           ord
    WHERE   mo.product_id = :new.id_producto --productoId
    AND     mp.motive_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('FNB_ESTADOSOL_REG')) -- 13. Estado registrado de una solicitud
    AND     mp.package_type_id = 100101
    AND     mp.package_id = mo.package_id
    AND     oa.package_id = mp.package_id
    AND     oa.task_type_id IN  (
                                    SELECT TO_NUMBER (COLUMN_VALUE)
                                    FROM TABLE (ldc_boutilities.splitstrings (dald_parameter.fsbgetvalue_chain ('COD_TIP_TRA_SOL_VEN_SER_ING',NULL),','))
                                )
    AND     oa.order_id = ord.order_id
    AND     ord.order_status_id IN  (
                                        dald_parameter.fnuGetNumeric_Value ('COD_STATUS_REG'), --0 Orden registrada
                                        dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_ASIGNADA_OT')); --5 Orden Asignada


    --Cursor para identificar la solicitud de la OT legalizada
    CURSOR cuSolOTLeg 
    (
        NuOrden IN NUMBER
    )
    IS
    SELECT  ooa.*
    FROM    open.Or_Order_Activity ooa
    WHERE   ooa.order_id = NuOrden;

    CURSOR cuSolAnular 
    (
        nuProducto IN NUMBER
    )
    IS
    SELECT  p.PACKAGE_ID
    FROM    OPEN.MO_PACKAGES P, 
            OPEN.MO_MOTIVE M
    WHERE   P.PACKAGE_ID = M.PACKAGE_ID
    AND     PACKAGE_TYPE_ID IN (
                                    SELECT  TO_NUMBER (COLUMN_VALUE) AS tasks_type
                                    FROM    TABLE (open.ldc_boutilities.splitstrings (OPEN.DALD_PARAMETER.FSBGETVALUE_CHAIN ('VAL_TIPO_PAQUETE_OTREV'),','))
                                )
    AND     M.PRODUCT_ID = nuProducto
    AND     P.MOTIVE_STATUS_ID NOT IN (14, 32, 51);
    
    -- Obtenemos datos para realizar ejecucion
    CURSOR cuDataToExecute
    IS
    SELECT  TO_NUMBER (TO_CHAR (SYSDATE, 'YYYY')),
            TO_NUMBER (TO_CHAR (SYSDATE, 'MM')),
            USERENV ('SESSIONID'),
            USER
    FROM    DUAL;
    
    --Obtiene una unidada de trabajo es externa
    CURSOR cuOperatingUnit
    IS
    SELECT  COUNT (1)
    FROM    OPEN.LDC_UNIDAD_CERTIF C, 
            OPEN.OR_OPERATING_UNIT U
    WHERE   CONTRATO_ID = :NEW.ID_CONTRATO
    AND     C.OPERATING_UNIT_ID = U.OPERATING_UNIT_ID
    AND     U.CONTRACTOR_ID IS NULL
    AND     U.OPERATING_UNIT_ID != 1;
                                    
   
    CURSOR cuTieneOrdenes
    (
        inuPackageId IN or_order_activity.package_id%TYPE
    )
    IS
    SELECT 
            (
                SELECT  COUNT(oa.order_id)
                FROM    or_order_activity oa, or_order ord
                WHERE   oa.package_id = inuPackageId
                AND     oa.order_id = ord.order_id
            ) CantidadOTTodos,
            (
                SELECT COUNT(oa.order_id)
                FROM    or_order_activity oa, or_order ord
                WHERE   oa.package_id = inuPackageId
                AND     oa.order_id = ord.order_id
                AND     ord.order_status_id IN (
                                                dald_parameter.fnuGetNumeric_Value('COD_STATUS_REG'), --0 Orden registrada
                                                dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')
                                            )
            ) CantOTRegAsig,
            (
                SELECT COUNT(oa.order_id)
                FROM    or_order_activity oa, or_order ord
                WHERE   oa.package_id = inuPackageId
                AND     oa.order_id = ord.order_id
                AND     ord.order_status_id IN (
                                                dald_parameter.fnuGetNumeric_Value ('ESTADO_CERRADO')
                                            )
            ) CantOtCerradas,
            (
                SELECT  COUNT(oa.order_id)
                FROM    or_order_activity oa, or_order ord
                WHERE   oa.package_id = inuPackageId
                AND     oa.order_id = ord.order_id
                AND     ord.order_status_id IN (
                                                dald_parameter.fnuGetNumeric_Value ('COD_ESTADO_OT_EJE')
                                            )
            ) CantOtEjecutadas
    FROM dual;   

    CURSOR cuexluirexiste
    (
        packageId IN NUMBER
    ) 
    IS
    SELECT  COUNT(1) cantidad 
    FROM    open.Or_Order_Activity ooa, 
            or_order oo
    WHERE   ooa.package_id = packageId --9003916 --15409739
    AND     ooa.package_id IN (
                                SELECT  mp.package_id
                                FROM    open.mo_packages mp
                                WHERE   mp.package_type_id IN (
                                                                SELECT  column_value
                                                                FROM    TABLE(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_TIP_SOL_EXC_ANU'),','))
                                                              )
                                AND mp.motive_status_id = 13
                              )
    AND     oo.order_id = ooa.order_id
    AND     oo.order_status_id = dald_parameter.fnuGetNumeric_Value('COD_ESTADO_ASIGNADA_OT')
    AND     oo.operating_unit_id IN (
                                        SELECT column_value
                                        FROM table(ldc_boutilities.SPLITstrings(dald_parameter.fsbGetValue_Chain('COD_UNI_OPE_EXC_SOL_ANU'),','))
                                    );
  
    -------------------------------------------------------------------
    --      Records                                                  --
    -------------------------------------------------------------------
    rfcusolicitudesanula         cusolicitudesanula%ROWTYPE;
    rfcuotanulasolicitud100101   cuotanulasolicitud100101%ROWTYPE;
    rfcuSolOTLeg                 cuSolOTLeg%ROWTYPE;
    rfcuexluirexiste             cuexluirexiste%rowtype;
    -------------------------------------------------------------------
    
    PROCEDURE pAnnulorAtendPackages
    (
        inuPackages     IN 		open.mo_packages.package_id%TYPE,
        onuErrorCode    OUT 	open.ge_error_log.error_log_id%TYPE,
        osbMessageError OUT 	open.ge_error_log.description%TYPE
    ) 
    IS
        csbMT_NAME      VARCHAR2(30) := '.pAnnulorAtendPackages';
    BEGIN
        ut_trace.trace('Inicio ' || csbTG_NAME||csbMT_NAME, cnuNVLTRC);
        
        ut_trace.trace('Solicitud ['||inuPackages||']', cnuNVLTRC);
        
        OPEN cuTieneOrdenes(inuPackages);
        FETCH cuTieneOrdenes INTO nuTieneOrdenes, nuCantAsingReg, nuCantCerradas, nuCantEjecutad;
        CLOSE cuTieneOrdenes;
        
        IF (nuTieneOrdenes > 0) THEN

            --Si la solicitud tiene ordenes cerradas la solicitud sera atendida
            IF (nvl(nuTieneOrdenes,0) = nuCantCerradas) THEN
                -- Cambio estado de la solicitud atendida
                pkgManejoSolicitudes.pRespondRequest(inuPackages,onuErrorCode,osbErrorMessage);
            ELSE
                            
                IF (nvl(nuCantCerradas,0) = 0 AND nvl(nuCantEjecutad,0) = 0) THEN
                    pkgManejoSolicitudes.pFullAnullPackages
                    (
                        inuPackages,
                        'Anulacion de solicitud por certificación',
                        onuErrorCode,
                        osbErrorMessage
                    );
                ELSIF (nvl(nuCantCerradas,0) > 0 AND  nvl(nuCantEjecutad,0) = 0) THEN
                    pkgManejoSolicitudes.pRespondRequest(inuPackages,onuErrorCode,osbErrorMessage);
                END IF;

                IF (onuErrorCode = 0)THEN
                    FOR i IN cuOrdAnula(inuPackages) LOOP
                        ldc_cancel_order 
                        (
                            i.order_id,
                            dald_parameter.fnuGetNumeric_Value('CAUSAL_CANCELAR_OT_TERCEROS',NULL),
                            'Anulacion de orden por actualizacion sobre la tabla ldc_plazos_cert',
                            cnuCommentType,
                            onuErrorCode,
                            osbErrorMessage
                        );
                        LDC_NOTIFICA_CIERRE_OT (i.order_id, 'A');
                    END LOOP;
                END IF;
            END IF;
        ELSE 
            pkgManejoSolicitudes.pFullAnullPackages
            (
                inuPackages,
                'Anulacion de solicitud por certificación',
                onuErrorCode,
                osbErrorMessage
            );     
        END IF;

        ut_trace.trace('Fin ' || csbTG_NAME||csbMT_NAME, cnuNVLTRC);

    EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        Errors.setError;
        errors.geterror(onuErrorCode, osbMessageError);
		ut_trace.trace('onuCodigoError: '||onuErrorCode, cnuNVLTRC);
		ut_trace.trace('osbMessageError: '||osbMessageError, cnuNVLTRC);
    WHEN others THEN
        Errors.setError;
        errors.geterror(onuErrorCode, osbMessageError);
		ut_trace.trace('onuCodigoError: '||onuErrorCode, cnuNVLTRC);
		ut_trace.trace('osbMessageError: '||osbMessageError, cnuNVLTRC);
    END pAnnulorAtendPackages;
    
BEGIN
    ut_trace.trace('Inicia '||csbTG_NAME, cnuNVLTRC);
    
    nulineaerror := -1;
    
    OPEN cuDataToExecute;
    FETCH cuDataToExecute INTO nuparano,nuparmes,nutsess,sbparuser;
    CLOSE cuDataToExecute; 
    
    ut_trace.trace
    (
        'Linea datos para realizar ejecucion['||nulineaerror||']: nuparano: '
        ||' nuparmes: '||nuparmes||' nutsess: '||nutsess||' sbparuser: '||sbparuser, 
        cnuNVLTRC
    );
    
    -- Se inicia log del programa
    nulineaerror := -2;
    nutsess := :new.id_producto;
    
    ldc_proinsertaestaprog 
    (
        nuparano,
        nuparmes,
        csbTG_NAME,
        'En ejecucion',
        nutsess,
        sbparuser
    );
    
    ut_trace.trace('Linea - Se inicio el log del programa['||nulineaerror||']', cnuNVLTRC);

    IF (UPDATING AND :new.plazo_maximo > :old.plazo_maximo) OR INSERTING THEN
    
        nulineaerror := -3;
        
        BEGIN
            OPEN cuOperatingUnit;
            FETCH cuOperatingUnit INTO nUnitOperExter;
            CLOSE cuOperatingUnit;

            DELETE LDC_UNIDAD_CERTIF;
        EXCEPTION
            WHEN OTHERS
            THEN
                nUnitOperExter := 0;
        END;

        ut_trace.trace
        (
            'Linea - Unidad Operativa externa['||nulineaerror||']: '||'nUnitOperExter:['||nUnitOperExter||']', 
            cnuNVLTRC
        );

        --si unidada de trabajo es externa
        IF (nUnitOperExter > 0) THEN
            FOR s IN cuSolAnular(:new.id_producto) LOOP
            
                nulineaerror := -4;
                ut_trace.trace('Linea - El producto tiene solicitudes['||nulineaerror||']', cnuNVLTRC);
                
                pAnnulorAtendPackages
                (
                    s.package_id,
                    onuErrorCode,
                    osbErrorMessage
                );
                
                IF (onuErrorCode > 0) THEN
                    sbmensaje := 'ERROR LINE : '|| TO_CHAR (nulineaerror)|| ' PRODUCTO : '
                                || :new.id_producto|| ' pAnnulorAtendPackages : '
                                || TO_CHAR (s.package_id)|| ' - '|| SQLERRM;
                    RAISE eerrorexception;
                END IF;
            END LOOP;
            --borrar marca asociada al producto
            nulineaerror := -5;
            numarcaantes := ldc_fncretornamarcaprod(:new.id_producto);
            numarca := NULL;

            DELETE FROM ldc_marca_producto WHERE id_producto = :new.id_producto;

            ldc_prmarcaproductolog (:new.id_producto, numarcaantes,numarca,'Trigger marca_producto');
        END IF;

        IF  nUnitOperExter = 0 THEN
            UPDATE  ldc_marca_producto
            SET     REGISTER_POR_DEFECTO = 'N'
            WHERE   ID_PRODUCTO = :new.id_producto;
        END IF;

        --Se buscan las solicitudes que se deben anular
        FOR j IN cusolanula (:new.id_producto) LOOP
        
            nulineaerror := -6;
            nuPackageId := j.package_id;

            pAnnulorAtendPackages
            (
                nuPackageId,
                onuErrorCode,
                osbErrorMessage
            );

            IF (onuErrorCode > 0) THEN
                sbmensaje := 'ERROR LINE : '|| TO_CHAR (nulineaerror)|| ' PRODUCTO : '
                            || :new.id_producto|| ' pAnnulorAtendPackages : '
                            || TO_CHAR (nuPackageId)|| ' - '|| SQLERRM;
                RAISE eerrorexception;
            END IF;
        END LOOP;

        --Cusor para obtener los datos de la orden legalizada en especial la solicitud a la que esta asociada
        nulineaerror := -7;

        BEGIN
            nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
            
            OPEN cuSolOTLeg(nuOrderId);
            FETCH cuSolOTLeg INTO rfcuSolOTLeg;
            CLOSE cuSolOTLeg;

            nuSolicitudId := NVL (rfcusolotleg.package_id, 0);
        EXCEPTION
            WHEN OTHERS
            THEN
                nuSolicitudId := 0;
        END;

        FOR rfcusolicitudesanula IN cusolicitudesanula LOOP
            nulineaerror := -8;

            IF NVL (rfcusolicitudesanula.package_id, 0) <> NVL (nuSolicitudId, 0) THEN
                --Validar que el nuPackageId no sea null
                nulineaerror := -9;

                IF rfcusolicitudesanula.package_id IS NOT NULL THEN
                
                    OPEN cuexluirexiste(rfcusolicitudesanula.package_id);
                    FETCH cuexluirexiste INTO rfcuexluirexiste;
                    CLOSE cuexluirexiste;

                    IF nvl(rfcuexluirexiste.cantidad, 0) = 0 THEN
                        nulineaerror := -10;
                        pAnnulorAtendPackages
                        (
                            rfcusolicitudesanula.package_id,
                            onuErrorCode,
                            osbErrorMessage
                        );

                        IF (onuErrorCode > 0) THEN
                            sbmensaje := 'ERROR LINE : '|| TO_CHAR (nulineaerror)|| ' ORDEN : '
                                        || nuOrderId|| ' pAnnulorAtendPackages : '
                                        || TO_CHAR (rfcusolicitudesanula.package_id)|| ' - '|| SQLERRM;
                            RAISE eerrorexception;
                        END IF;
                    END IF; 
                END IF;
            END IF;
        END LOOP;

        nulineaerror := -11;

        FOR rfcuotanulasolicitud100101 IN cuotanulasolicitud100101 LOOP
            --Validar que el nuPackageId no sea null
            IF rfcuotanulasolicitud100101.package_id IS NOT NULL THEN
            
                OPEN cuexluirexiste(rfcuotanulasolicitud100101.package_id);
                FETCH cuexluirexiste INTO rfcuexluirexiste;
                CLOSE cuexluirexiste;
                
                IF nvl(rfcuexluirexiste.cantidad, 0) = 0 THEN
                    nulineaerror := -12;
                    pAnnulorAtendPackages
                    (
                        rfcuotanulasolicitud100101.package_id,
                        onuErrorCode,
                        osbErrorMessage
                    );

                    IF (onuErrorCode > 0) THEN
                        sbmensaje := 'ERROR LINE : '|| TO_CHAR (nulineaerror)|| ' pAnnulorAtendPackages : '
                                    || TO_CHAR (rfcuotanulasolicitud100101.package_id)|| ' - '|| SQLERRM;
                        RAISE eerrorexception;
                    END IF;
                END IF;
            END IF;
        END LOOP;
    END IF;
EXCEPTION
    WHEN eerrorexception THEN
        ldc_proactualizaestaprog(nutsess,sbmensaje,csbTG_NAME,'Termino con error.');
    WHEN OTHERS
    THEN
        sbmensaje := SQLERRM;
        ldc_proactualizaestaprog(nutsess,sbmensaje,csbTG_NAME,'Termino con error.');
END ldc_trg_marca_producto_gdc;
/