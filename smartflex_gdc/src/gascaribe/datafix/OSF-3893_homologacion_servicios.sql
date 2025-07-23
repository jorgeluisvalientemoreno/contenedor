DECLARE

    -- OSF-3893    
    CURSOR cuHomologaciones
    IS
    SELECT
        'OPEN' esquema_Origen,
        UPPER('rc_boannulpayments.collectingannul') servicio_origen,
        'Anula el pago de un cupon' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('PKG_BOGESTION_PAGOS.prcAnulaPago') servicio_destino,
        'Anula el pago de un cupon' descripcion_destino,
        NULL observacion
    FROM DUAL
    
    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('pktblReportes.insRecord') servicio_origen,
        'Inserta el encabezado de un reporte' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('PKG_REPORTES_INCO.fnuCrearCabeReporte') servicio_destino,
        'Inserta el encabezado de un reporte' descripcion_destino,
        NULL observacion
    FROM DUAL
    
    UNION ALL

    SELECT
        'OPEN' esquema_Origen,
        UPPER('pktblRepoInco.insRecord') servicio_origen,
        'Inserta un registro al detalle de un reporte' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('PKG_REPORTES_INCO.prCrearDetalleRepo') servicio_destino,
        'Inserta un registro al detalle de un reporte' descripcion_destino,
        NULL observacion
    FROM DUAL
    
    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('pkTraslatePositiveBalance.SetBatchProcessData') servicio_origen,
        'Define datos del proceso de traslado de saldo a favor' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('PKG_BOGESTION_FACTURACION.prDefDatosTrasladoSaldo') servicio_destino,
        'Define datos del proceso de traslado de saldo a favor' descripcion_destino,
        NULL observacion
    FROM DUAL

    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('pkTraslatePositiveBalance.TRANSLATEBYDEPOSIT') servicio_origen,
        'Traslada valor de saldo a favor entre productos' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('PKG_BOGESTION_FACTURACION.prTrasladaSaldoAfavor') servicio_destino,
        'Traslada valor de saldo a favor entre productos' descripcion_destino,
        NULL observacion
    FROM DUAL    


    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('CC_BODefToCurTransfer.GLOBALINITIALIZE') servicio_origen,
        'Inicializa variables globales del proceso de diferido a corriente' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('pkg_bogestion_financiacion.prIniciaVariablesGlobales') servicio_destino,
        'Inicializa variables globales del proceso de diferido a corriente' descripcion_destino,
        NULL observacion
    FROM DUAL    

    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('CC_BODefToCurTransfer.ADDDEFERTOCOLLECTFIN') servicio_origen,
        'Agrega un diferido al traslado a corriente para cobro de financiacion' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('pkg_bogestion_financiacion.prAgregaDifCobrFinanciacion') servicio_destino,
        'Agrega un diferido al traslado a corriente para cobro de financiacion' descripcion_destino,
        NULL observacion
    FROM DUAL   

    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('CC_BODefToCurTransfer.TRANSFERDEBT') servicio_origen,
        'Convierte deuda diferida a deuda corriente' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('pkg_bogestion_financiacion.prConvDeudaDiferidaEnCorriente') servicio_destino,
        'Convierte deuda diferida a deuda corriente' descripcion_destino,
        NULL observacion
    FROM DUAL   

    UNION ALL
    
    SELECT
        'OPEN' esquema_Origen,
        UPPER('CC_BODefToCurTransfer.AddDeferToCollect') servicio_origen,
        'Agrega un diferido para convertirlo en deuda corriente' descripcion_origen,
        'ADM_PERSON' esquema_destino,
        UPPER('pkg_bogestion_financiacion.prAgregaDiferidoConvCorriente') servicio_destino,
        'Agrega un diferido para convertirlo en deuda corriente' descripcion_destino,
        NULL observacion
    FROM DUAL   

    ;

    PROCEDURE prInsHomologacion
    (
        irgHomologacion cuHomologaciones%ROWTYPE
    )
    IS
        
        CURSOR cuhomologacion_servicios
        IS
        SELECT *
        FROM homologacion_servicios
        WHERE esquema_origen = irgHomologacion.Esquema_Origen
        AND servicio_origen = irgHomologacion.Servicio_Origen;
        
        rchomologacion_servicios    cuhomologacion_servicios%ROWTYPE;

    Begin

        rchomologacion_servicios    := NULL;
        
        OPEN cuhomologacion_servicios;
        FETCH cuhomologacion_servicios INTO rchomologacion_servicios;
        CLOSE cuhomologacion_servicios;
        
        IF rchomologacion_servicios.servicio_origen IS NULL THEN
        
            BEGIN
            
                insert into homologacion_servicios
                values
                irgHomologacion                  
                ;

                COMMIT;

                dbms_output.put_line('INFO: ['|| irgHomologacion.esquema_origen || '.' || irgHomologacion.servicio_origen || '][OK]');
                
                EXCEPTION
                    WHEN OTHERS THEN
                        dbms_output.put_line('ERROR['|| irgHomologacion.esquema_origen || '.' || irgHomologacion.servicio_origen || ']['|| sqlerrm || ']');
                        ROLLBACK;
                        
            END;            

        ELSE
            dbms_output.put_line('INFO: Ya existe['|| irgHomologacion.esquema_origen || '.' || irgHomologacion.servicio_origen || ']');
        END IF;
        
    END prInsHomologacion;
    
BEGIN
    FOR rg IN cuHomologaciones LOOP
        prInsHomologacion( rg );
    END LOOP;
END;
/