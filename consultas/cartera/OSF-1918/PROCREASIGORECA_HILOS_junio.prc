CREATE OR REPLACE PROCEDURE ADM_PERSON.PROCREASIGORECA_HILOS (inuHilo   NUMBER,
                                                   inuSesion NUMBER) IS
  /*****************************************************************
    Autor       : Horbath
    Fecha       : 2019-10-22
    Ticket      : 141
    Descripcion : Proceso que obtiene los productos y unidad operativa asociada, cargado por archivo plano,
                  para crear ordenes y asignar ordenes de seguimiento de cartera llamado por cada hilo.
    Valor de entrada

    inuHilo   : NUMERO DE HILO
    inuSesion : VALOR DE LA SESION ACTIVA

    Historial de Modificaciones
    Fecha             Autor             Modificacion
    =========       =========           ====================
    22/10/2019      HORBATH (EHG)       OPTIMAZACION DE PROCESO PROCREASIGORECA OK++
    22/11/2019      HORBATH (EHG)       REVISION Y VERSION FINAL OK++
	06/10/2020      HORBATH             ca846:Se modifica para generargenerar las ordenes con la actividad 4000844 - GESTI??N DE COBRO PREJUR??DICO,
										sin importar si el producto actual ya tiene una orden con esta misma actividad
	09/05/2022		CGONZALEZ			OSF-266: Se modifica para crear la orden con la actividad nueva configurada en el parametro ACT_GC_CASTIGADOS
												 si el producto se encuentra en estado financiero Castigado
	12/12/2022		CGONZALEZ			OSF-741: Se modifica para crear la orden de acuerdo a la actividad diligenciada
												 en el archivo plano
    08/02/2024		jpinedc			    OSF-2130:   * Ajustes migracion a V8
                                                    * Uso de pkg_gestionArchivos.
    08/03/2024		jpinedc			    OSF-2130_2:  Se quita la actualizacion de
                                                    or_order_activity  - Secciones H4A,H4B,H4C
  ******************************************************************/
    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT ||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PROCREASIGORECA';

    SUBTYPE STYSIZELINE   IS VARCHAR2(32000);
    nuRecord              NUMBER;

    sbErrorLine           STYSIZELINE;

    nuProductId           PR_PRODUCT.PRODUCT_ID%TYPE;
    inuActivity           NUMBER;
    nuActividadCast       NUMBER;
    inuParsedAddressId    NUMBER;
    ionuOrderId           OR_ORDER.ORDER_ID%type;
    nuErrorCode           NUMBER;
    sbErrorMessage        VARCHAR2(2000);

    nuOperatingUnitId     OR_ORDER.OPERATING_UNIT_ID%TYPE;
    nuActividad     		NUMBER;

    nuCriteGestCob VARCHAR2(100) :=  dald_parameter.fnuGetNumeric_Value('PARAM_CONFIG_CRITERIO',NULL);
    cantidad_ref_ultimos_12_meses NUMBER(8);
    dtfechainicial                DATE;
    dtfechafinal                  DATE;

    NANO  NUMBER;
    NMES  NUMBER;

    CANT_REG NUMBER;

    nuContrato                  NUMBER;
    nuCliente                   NUMBER;
    nuNewOrderActivityId        NUMBER;

    --Cursor que obtiene datos del producto almacenados en LDC_OSF_SESUCIER
    CURSOR   CU_DAT_PROD (ProductId PR_PRODUCT.PRODUCT_ID%TYPE, ANO NUMBER,MES NUMBER) IS
    SELECT   CLIENTE ,
          CONTRATO,
          EDAD,
          (DEUDA_CORRIENTE_NO_VENCIDA+DEUDA_CORRIENTE_VENCIDA+DEUDA_NO_CORRIENTE) AS TOTAL,
          DEUDA_CORRIENTE_NO_VENCIDA,
          DEUDA_CORRIENTE_VENCIDA,
          DEUDA_NO_CORRIENTE,
          nvl(VALOR_CASTIGADO,0) VALOR_CASTIGADO,
          SESUSAPE
    FROM   LDC_OSF_SESUCIER
    WHERE PRODUCTO=ProductId AND NUANO= 2024 /*ANO*/  AND NUMES= 6 /*MES*/;

    NUCANTORDEN NUMBER;

    /*Cursor de hilos, se consultan los registros cargados del archivo plano a la tabla temporal LDC_TMP_FPORDERSDATA T,
    teniendo en cuenta el valor del hilo.*/
    CURSOR CUHILOS IS
    SELECT T.NUTPRODUCTID, T.NUTOPERATINGUNITID, T.NUSESION, T.ESTADO_PR, T.OBSERVACION, T.ACTIVITY_ID
    FROM   LDC_TMP_FPORDERSDATA T
    WHERE  NUSESION = inuSesion
    AND    SUBSTR(TO_CHAR(NUTPRODUCTID), LENGTH(TO_CHAR(NUTPRODUCTID)-1),1) = TO_CHAR(inuHilo)
    ;
BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    XLOGPNO_EHG('[PROCREASIGORECA_HILOS ] INICIO DEL HILO # '||inuHilo, inuSesion);

    --Se obtiene el parametro de la actividad
    inuActivity := dald_parameter.fnuGetNumeric_Value('PARAM_CONFIG_ACTIVIDAD', null);
    nuActividadCast := dald_parameter.fnuGetNumeric_Value('ACT_GC_CASTIGADOS', null);

    --Se actualiza a estado (P = Procesado) los registros del hilo
    UPDATE LDC_TEMP_GCORECA_HILOS
    SET   STATUS   = 'P'
    WHERE NUSESION = inuSesion
    AND   HILO     = inuHilo;
    COMMIT;

    -- recorre los productos que sean del hilo
    FOR CH IN CUHILOS LOOP
        BEGIN
            nuProductId       := CH.NUTPRODUCTID;
            nuOperatingUnitId := CH.NUTOPERATINGUNITID;
            nuActividad := NVL(CH.ACTIVITY_ID, inuActivity);

            --Se valida que el dato correspondiente al producto y a la unidad operativa no venga null
            IF nuProductId IS NOT NULL AND nuOperatingUnitId IS NOT NULL THEN

                XLOGPNO_EHG('[H1 - INICIA TRABAJO DEL HILO: '||inuHilo||' + PRODUCTO: '||nuProductId||' + UNIDAD OPERATIVA: '||nuOperatingUnitId||' + ACTIVIDAD: '||nuActividad, inuSesion);

                NUCANTORDEN := 0;

                IF  NUCANTORDEN = 0 THEN

                    SAVEPOINT ASIGNA;

                    --Se obtiene la direccion asociada al producto
                    inuParsedAddressId  := pkg_bcProducto.fnuIDDIRECCINSTALACION(nuProductId);
                    ionuOrderId             := NULL;
                    nuErrorCode             := NULL;
                    sbErrorMessage          := NULL;
                    nuContrato              := pkg_bcProducto.fnuCONTRATO( nuProductId );
                    nuCliente               := pkg_bcContrato.fnuIdCliente( nuContrato );
                    nuNewOrderActivityId    := NULL;

                    --Se crea la orden con los items de actividad correspondiente al tipo de trabajo (5005)
                    XLOGPNO_EHG('H2A - INICIA EJECUTANDO EL METODO [API_CREATEORDER] PARA EL HILO '||inuHilo||' - '||'Producto ['||nuProductId||'] UNIDAD OPERATIVA '||nuOperatingUnitId, inuSesion);

                    BEGIN
                        --Si el producto se encuentra en estado financiero Castigado, se crea la orden con la actividad del parametro ACT_GC_CASTIGADOS
                        IF (pkg_BCProducto.fsbEstadoFinanciero(nuProductId) = 'C') THEN
                            api_createorder
                            (
                                inuitemsid          => nuActividadCast,
                                inupackageid        => null,
                                inumotiveid         => null,
                                INUCOMPONENTID      => null,
                                INUINSTANCEID       => null,
                                INUADDRESSID        => inuParsedAddressId,
                                INUELEMENTID        => null,
                                INUSUBSCRIBERID     => nuCliente,
                                INUSUBSCRIPTIONID   => nuContrato,
                                InuProductId        => nuProductId,
                                INUOPERUNITID       => null,
                                IDTEXECESTIMDATE    => null,
                                INUPROCESSID        => null,
                                ISBCOMMENT          => 'Orden de seguimiento de cartera',
                                IBLPROCESSORDER     => null,
                                INUPRIORITYID       => null,
                                INUORDERTEMPLATEID  => null,
                                ISBCOMPENSATE       => null,
                                INUCONSECUTIVE      => null,
                                INUROUTEID          => null,
                                INUROUTECONSECUTIVE => null,
                                INULEGALIZETRYTIMES => 0,
                                ISBTAGNAME          => null,
                                IBLISACTTOGROUP     => null,
                                INUREFVALUE         => null,
                                INUACTIONID         => null,
                                IONUORDERID         => ionuOrderId,
                                IONUORDERACTIVITYID => nuNewOrderActivityId,
                                OnuErrorCode		   => nuErrorCode,
                                OsbErrorMessage	   => sbErrorMessage
							);
                        ELSE
                            api_createorder
                            (
                                inuitemsid          => nuActividad,
                                inupackageid        => null,
                                inumotiveid         => null,
                                INUCOMPONENTID      => null,
                                INUINSTANCEID       => null,
                                INUADDRESSID        => inuParsedAddressId,
                                INUELEMENTID        => null,
                                INUSUBSCRIBERID     => nuCliente,
                                INUSUBSCRIPTIONID   => nuContrato,
                                InuProductId        => nuProductId,
                                INUOPERUNITID       => null,
                                IDTEXECESTIMDATE    => null,
                                INUPROCESSID        => null,
                                ISBCOMMENT          => 'Orden de seguimiento de cartera',
                                IBLPROCESSORDER     => null,
                                INUPRIORITYID       => null,
                                INUORDERTEMPLATEID  => null,
                                ISBCOMPENSATE       => null,
                                INUCONSECUTIVE      => null,
                                INUROUTEID          => null,
                                INUROUTECONSECUTIVE => null,
                                INULEGALIZETRYTIMES => 0,
                                ISBTAGNAME          => null,
                                IBLISACTTOGROUP     => null,
                                INUREFVALUE         => null,
                                INUACTIONID         => null,
                                IONUORDERID         => ionuOrderId,
                                IONUORDERACTIVITYID => nuNewOrderActivityId,
                                OnuErrorCode		   => nuErrorCode,
                                OsbErrorMessage	   => sbErrorMessage
							);
                        END IF;
                        XLOGPNO_EHG('H2B - FINALIZA LA EJECUCION DEL METODO [API_CREATEORDER] PARA EL HILO '||inuHilo||' - '||'Producto ['||nuProductId||'] UNIDAD OPERATIVA '||nuOperatingUnitId, inuSesion);
                        EXCEPTION
					WHEN OTHERS THEN
						XLOGPNO_EHG('H2C - ALERTA. FALLA LA EJECUCION DEL METODO [API_CREATEORDER] '||' - ERROR: '||nuErrorCode||' - MENSAJE: '|| sbErrorMessage||' - HILO: '||inuHilo ||' - PRODUCTO: '|| nuProductId || ' - UNIDAD OPERATIVA: '||nuOperatingUnitId ||' - SESION: '||inuSesion, inuSesion);
						--Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
						UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1, OBSERVACION = 'ERROR EN API_CREATEORDER '
						WHERE  NUSESION     = inuSesion
						AND    NUTPRODUCTID = nuProductId;
						COMMIT;
                    END;

                    IF nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS THEN
                        sbErrorLine := nuProductId ||' '|| nuErrorCode ||'-'|| sbErrorMessage;
                        pkg_Traza.Trace('Producto ['||nuProductId||'] Error '||nuErrorCode||'-'|| sbErrorMessage);
                        XLOGPNO_EHG('H3A - ERROR EN LINE 140 -> nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS - '||'HILO '||inuHilo||' - '||' Producto ['||nuProductId||'] Error '||nuErrorCode||'-'|| sbErrorMessage, inuSesion);

                        sbErrorLine := NULL;
                        ROLLBACK TO ASIGNA;

                        XLOGPNO_EHG('H3B - INICIA [UPDATE LDC_TMP_FPORDERSDATA], ACTUALIZA CON ERROR LDC_TMP_FPORDERSDATA Y ESTABLECE ESTADO = 1 HILO '||inuHilo||' - '||' Producto ['||nuProductId||'] Error '||nuErrorCode||'-'|| sbErrorMessage, inuSesion);
                        --Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
                        UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1, OBSERVACION = 'ERROR EN [PROCREASIGORECA_HILOS ], VALIDACI?N: nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS '
                        WHERE  NUSESION     = inuSesion
                        AND    NUTPRODUCTID = nuProductId;
                        COMMIT;

                    ELSE

                        nuErrorCode    := NULL;
                        sbErrorMessage := NULL;

                        --Se realiza la asignacion de la orden a la unidad operativa correspondiente
                        XLOGPNO_EHG('H5A - INICIA EJECUTANDO EL METODO [API_ASSIGN_ORDER] PARA EL HILO '||inuHilo||' - '||'Producto ['||nuProductId||'] UNIDAD OPERATIVA '||nuOperatingUnitId, inuSesion);
                        BEGIN
                            API_ASSIGN_ORDER(ionuOrderId, nuOperatingUnitId, nuErrorCode, sbErrorMessage);
                            XLOGPNO_EHG('H5B - FINALIZA LA EJECUCION DEL METODO [API_ASSIGN_ORDER] PARA EL HILO '||inuHilo||' - '||'Producto ['||nuProductId||'] UNIDAD OPERATIVA '||nuOperatingUnitId, inuSesion);
                        EXCEPTION
                            WHEN OTHERS THEN
                            XLOGPNO_EHG('H5C - ALERTA EN LA ASIGNACION. FALLA LA EJECUCION DEL METODO [API_ASSIGN_ORDER] - ERROR: '||nuErrorCode||' - MENSAJE: '|| sbErrorMessage||' - HILO: '||inuHilo||' - '||' - PRODUCTO: ['||nuProductId||'] - UNIDAD OPERATIVA: '||nuOperatingUnitId, inuSesion);
                            --Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
                            UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1, OBSERVACION = 'ERROR EN API_ASSIGN_ORDER '
                            WHERE  NUSESION     = inuSesion
                            AND    NUTPRODUCTID = nuProductId;
                            COMMIT;
                        END;

                        IF nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS THEN--#2
                            XLOGPNO_EHG('H6A - INICIA #2 [nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS ]'||' - HILO '||inuHilo||' - NUMERO DE PRODUCTO: '||nuProductId||' - ERROR NUMERO: '||nuErrorCode||' - MENSAJE ERROR: '|| sbErrorMessage, inuSesion);

                            sbErrorLine := '['||nuRecord ||']['|| ionuOrderId ||']['|| nuProductId ||'] '|| nuErrorCode ||'-'|| sbErrorMessage;
                            pkg_Traza.Trace('Error '||nuErrorCode||'-'|| sbErrorMessage);

                            XLOGPNO_EHG('H6B - FINALIZA ERROR #2 [nuErrorCode <> GE_BOCONSTANTS.CNUSUCCESS ]'||' - HILO: '||inuHilo||' - ERROR NUMERO: '||nuErrorCode||' - MENSAJE ERROR: '||SUBSTR(sbErrorLine,1,1800), inuSesion);

                            sbErrorLine := NULL;
                            ROLLBACK TO ASIGNA;

                        ELSE
                            XLOGPNO_EHG('H7A - ENTRA AL (ELSE) PARA HACER EL SELECT COUNT(d.difecofi) - HILO: '||inuHilo||' - '||' - PRODUCTO: ['||nuProductId||'] - UNIDAD OPERATIVA: '||nuOperatingUnitId, inuSesion);
                            dtfechainicial                := to_date(to_char(add_months(SYSDATE,-12),'dd/mm/yyyy')||' 00:00:00','dd/mm/yyyy hh24:mi:ss');
                            dtfechafinal                  := to_date(to_char(SYSDATE,'dd/mm/yyyy')||' 23:59:59','dd/mm/yyyy hh24:mi:ss');
                            cantidad_ref_ultimos_12_meses := 0;

                            --Se obtiene la cantidad de referidos en los ultimos 12 meses
                            XLOGPNO_EHG('H7B - INICIA SELECT COUNT(d.difecofi) - HILO: '||inuHilo||' - '||' - PRODUCTO: ['||nuProductId||'] - UNIDAD OPERATIVA: '||nuOperatingUnitId, inuSesion);
                            BEGIN
                                SELECT   COUNT(DISTINCT(d.difecofi)) INTO cantidad_ref_ultimos_12_meses
                                FROM   diferido d
                                WHERE d.difenuse = nuProductId
                                AND   d.difefein BETWEEN  dtfechainicial AND dtfechafinal
                                AND   d.difeprog = 'GCNED';
                                XLOGPNO_EHG('H7C - FINALIZA SELECT COUNT(d.difecofi) - HILO: '||inuHilo||' - '||' - PRODUCTO: ['||nuProductId||'] - UNIDAD OPERATIVA: '||nuOperatingUnitId, inuSesion);
                            EXCEPTION
                                WHEN OTHERS THEN
                                    XLOGPNO_EHG('H7D - ALERTA. ERROR CONTROLADO EN SELECT COUNT(d.difecofi)  - HILO: '||inuHilo||' - '||' - PRODUCTO: ['||nuProductId||'] - UNIDAD OPERATIVA: '||nuOperatingUnitId, inuSesion);
                                    NULL;
                            END;

                            --Se obtiene el mes anterior a la fecha actual para pasarlo como par?!metro
                            nAno := 2024 /*to_number(to_char(add_months(sysdate, -1),'yyyy'))*/;
                            nMes := 6 /*to_number(to_char(add_months(sysdate, -1),'mm'))*/;

                            CANT_REG :=0;

                            --Se obtiene el mes anterior a la fecha actual
                            FOR rc IN CU_DAT_PROD(nuProductId,nAno,nMes) LOOP
                                CANT_REG := CANT_REG + 1;
                                XLOGPNO_EHG('H8A - INICIA CURSOR [ CU_DAT_PROD ], '||' - REG.# ('||CANT_REG||'), INSERTANDO EN GC_COLL_MGMT_PRO_DET - HILO: '||inuHilo ||' - NUMERO DE PRODUCTO: '||nuProductId||' - ORDER_ID: '||ionuOrderId||' - COLL_MGMT_PROC_CR_ID: '||nuCriteGestCob||' - '||' - REFINANCI_TIMES: '||cantidad_ref_ultimos_12_meses, inuSesion);
                                --Se inserta en la tabla gc_coll_mgmt_pro_det
                                BEGIN
                                    INSERT INTO GC_COLL_MGMT_PRO_DET (COLL_MGMT_PRO_DET_ID,
                                       ORDER_ID,
                                      EXEC_PROCESS_NAME,
                                      COLL_MGMT_PROC_CR_ID,
                                      IS_LEVEL_MAIN,
                                      SUBSCRIBER_ID,
                                      SUBSCRIPTION_ID,
                                      PRODUCT_ID,
                                      DEBT_AGE,
                                      TOTAL_DEBT,
                                      OUTSTANDING_DEBT,
                                      OVERDUE_DEBT,
                                      DEFERRED_DEBT,
                                      PUNI_OVER_DEBT,
                                      REFINANCI_TIMES,
                                      FINANCING_PLAN_ID,
                                      TOTAL_DEBT_CURRENT)
                                    VALUES (seq_gc_coll_mgmt_pr_275315.nextval,
                                      ionuOrderId,
                                      'GCORECA',
                                      nuCriteGestCob,
                                      'N',
                                      rc.CLIENTE,
                                      rc.CONTRATO,
                                      nuProductId,
                                      rc.EDAD,
                                      rc.TOTAL,
                                      rc.DEUDA_CORRIENTE_NO_VENCIDA,
                                      rc.DEUDA_CORRIENTE_VENCIDA,
                                      rc.DEUDA_NO_CORRIENTE,
                                      rc.VALOR_CASTIGADO,
                                      cantidad_ref_ultimos_12_meses,
                                      NULL,
                                      rc.SESUSAPE
                                      );
                                    XLOGPNO_EHG('H8B - FINALIZA CURSOR [ CU_DAT_PROD ], '||' - REG.#'||CANT_REG||', INSERTANDO EN GC_COLL_MGMT_PRO_DET - HILO: '||inuHilo ||' - NUMERO DE PRODUCTO: '||nuProductId||' - SESION: '||inuSesion||' - ORDER_ID: '||ionuOrderId||' - COLL_MGMT_PROC_CR_ID: '||nuCriteGestCob||' - '||' - REFINANCI_TIMES: '||cantidad_ref_ultimos_12_meses, inuSesion);
                                EXCEPTION
                                    WHEN OTHERS THEN
                                        XLOGPNO_EHG('H8C - ALERTA ERROR EN CURSOR [ CU_DAT_PROD ], '||' - REG.#'||CANT_REG||', INSERTANDO EN GC_COLL_MGMT_PRO_DET - HILO: '||inuHilo ||' - NUMERO DE PRODUCTO: '||nuProductId||' - SESION: '||inuSesion||' - ORDER_ID: '||ionuOrderId||' - COLL_MGMT_PROC_CR_ID: '||nuCriteGestCob||' - '||' - REFINANCI_TIMES: '||cantidad_ref_ultimos_12_meses, inuSesion);
                                        NULL;
                                END;

                            END LOOP;

                            COMMIT;

                        END IF;

                    END IF;

                ELSE

                    --Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
                    sbErrorLine := '['||nuRecord ||']  YA EXISTE UNA ORDEN RELACIONADA CON EL PRODUCTO '||nuProductId||'';

                    BEGIN
                        UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1, OBSERVACION = SUBSTR(sbErrorLine,1,2000)
                        WHERE  NUSESION     = inuSesion
                        AND    NUTPRODUCTID = nuProductId;
                                COMMIT;
                    EXCEPTION
                        WHEN OTHERS THEN
                            XLOGPNO_EHG('H9B - ALERTA. ERROR FALLA ACTUALIZANDO LDC_TMP_FPORDERSDATA - HILO: '||inuHilo ||' - NUMERO DE PRODUCTO: '||nuProductId||' - SESION: '||inuSesion, inuSesion);
                            NULL;
                    END;

                END IF;

            END IF;

        EXCEPTION
            WHEN OTHERS THEN
                sbErrorLine := SQLERRM;
                XLOGPNO_EHG('H10X - ALERTA. ERROR CONTROLADO: '||inuHilo ||' - NUMERO DE PRODUCTO: '||nuProductId||' - SESION: '||inuSesion||' - ERROR: '||SUBSTR(sbErrorLine,1,1800), inuSesion);
                UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1,
                                                OBSERVACION = SUBSTR(sbErrorLine,1,1800)
                                                ||'- H10X - ALERTA. ERROR CONTROLADO: '||inuHilo
                                                ||' - NUMERO DE PRODUCTO: '||nuProductId
                                                ||' - SESION: '||inuSesion
                WHERE  NUSESION     = inuSesion
                AND    NUTPRODUCTID = nuProductId;
                COMMIT;
        END;

    END LOOP;

    XLOGPNO_EHG('H11A - INICIA ACTUALIZACION DE LOS REGISTROS DE LA TABLA [LDC_TEMP_GCORECA_HILOS] - HILO: ['||inuHilo||']'||' - SESION: ['||inuSesion ||']', inuSesion);
    --Actualiza el estado de los registros procesados en la tabla temporal de Hilos y los establece en T (Terminado).*/
    UPDATE LDC_TEMP_GCORECA_HILOS SET STATUS = 'T',
                                    OBSERVACION = 'TERMINADO OK PROCREASIGORECA_HILOS.',
                                    FECHA_FINAL = sysdate
    WHERE  NUSESION = inuSesion
    AND    HILO = inuHilo;
    COMMIT;
    XLOGPNO_EHG('H11B - FINALIZA ACTUALIZACION DE LOS REGISTROS DE LA TABLA [LDC_TEMP_GCORECA_HILOS] - HILO: ['||inuHilo||']'||' - SESION: ['||inuSesion ||']', inuSesion);

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

EXCEPTION
    WHEN  pkg_Error.CONTROLLED_ERROR THEN
        pkg_Error.getError(nuErrorCode, sbErrorMessage);
        ROLLBACK;

        UPDATE LDC_TEMP_GCORECA_HILOS SET STATUS = 'T',
                                        OBSERVACION = ' -----(pkg_Error.CONTROLLED_ERROR) TERMINADO CON ERROR - '|| sbErrorMessage,
                                        FECHA_FINAL = sysdate

        WHERE  NUSESION = inuSesion
        AND    HILO = inuHilo;
        COMMIT;

        XLOGPNO_EHG('H13 - (pkg_Error.CONTROLLED_ERROR.) TERMINADO CON ERROR - HILO: '||inuHilo ||' - PRODUCTO:[ '||nuProductId||' ] - ' ||SUBSTR(sbErrorMessage,1,1800), inuSesion);

        --Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
        UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1,
                                      OBSERVACION = '-----pkg_Error.CONTROLLED_ERROR '||sbErrorMessage
        WHERE  NUSESION     = inuSesion
        AND    NUTPRODUCTID = nuProductId;
        COMMIT;

        RAISE pkg_Error.CONTROLLED_ERROR;

    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuErrorCode, sbErrorMessage);
        sbErrorMessage := sbErrorMessage || '(Error no controlado) ';
        ROLLBACK;

        UPDATE LDC_TEMP_GCORECA_HILOS
        SET STATUS = 'T',
        OBSERVACION = '(WHEN OTHERS DIRECT.) TERMINADO CON ERROR - HILO: '||inuHilo ||' - PRODUCTO:[ '||nuProductId||' ] - ' ||sbErrorMessage
        WHERE  NUSESION = inuSesion
        AND    HILO = inuHilo;
        COMMIT;

        XLOGPNO_EHG('H14 - (WHEN OTHERS DIRECT.) TERMINADO CON ERROR - HILO: '||inuHilo ||' - PRODUCTO:[ '||nuProductId||' ] - ' ||sbErrorMessage, inuSesion);

        --Actualiza el estado del registro con error, estableciendo estado = 1 en la tabla LDC_TMP_FPORDERSDATA
        UPDATE LDC_TMP_FPORDERSDATA SET ESTADO_PR = 1, OBSERVACION = '(WHEN OTHERS DIRECT.)'||sbErrorMessage
        WHERE  NUSESION     = inuSesion
        AND    NUTPRODUCTID = nuProductId;
        COMMIT;
        RAISE pkg_Error.CONTROLLED_ERROR;
END PROCREASIGORECA_HILOS;
/
