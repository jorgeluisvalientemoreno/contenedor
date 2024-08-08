PACKAGE BODY Or_bcRegeneraActivid AS































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO212000';

    
    
    
    BLADMLOADCONFIG     BOOLEAN := FALSE;
    
    GTBITEMSLOAD        DAGE_ITEMS.TYTBITEMS_ID;
    
    
    
    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    






























    PROCEDURE CARGATABLAREGACT
    (
        INUIDACTIVIDAD  IN  GE_ITEMS.ITEMS_ID%TYPE
    )
    IS
        CURSOR CUDATA(INUACTIVITYID IN  OR_REGENERA_ACTIVIDA.ACTIVIDAD%TYPE)
        IS
            SELECT/*+ INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_02)
                      INDEX(actRegenerar PK_GE_ITEMS) */
                OR_REGENERA_ACTIVIDA.ID_REGENERA_ACTIVIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD,
                OR_REGENERA_ACTIVIDA.ID_CAUSAL,
                OR_REGENERA_ACTIVIDA.CUMPLIDA,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR,
                OR_REGENERA_ACTIVIDA.ACTIVIDAD_WF,
                OR_REGENERA_ACTIVIDA.ESTADO_FINAL,
                OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA,
                OR_REGENERA_ACTIVIDA.ACTION,
            OR_REGENERA_ACTIVIDA.TRY_LEGALIZE
            FROM OR_REGENERA_ACTIVIDA, GE_ITEMS ACTREGENERAR
            /*+ Or_bcRegeneraActivid.CargaTablaRegAct SAO182466 */
            WHERE OR_REGENERA_ACTIVIDA.ACTIVIDAD = INUACTIVITYID
                AND ACTREGENERAR.ITEMS_ID(+) = OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR
                AND ACTREGENERAR.ITEM_CLASSIF_ID(+) = OR_BOCONSTANTS.CNUITEMS_CLASS_TO_ACTIVITY;
            
        RCORREGENERAACTIVIDA    OR_TYOBREGENERAACTIVIDAD;
        NUINDEX                 NUMBER := 0;
    BEGIN
    
        UT_TRACE.TRACE('inicia Or_bcRegeneraActivid.CargaTablaRegAct', 6);
        
        IF (GTBITEMSLOAD.EXISTS(INUIDACTIVIDAD)) THEN
            RETURN;
        END IF;

        
        IF (TBORREGENERAACTIVIDA IS NULL) THEN
            TBORREGENERAACTIVIDA    := OR_TYTBREGENERAACTIVIDAD();
        END IF;
        
        NUINDEX := TBORREGENERAACTIVIDA.COUNT + 1;
        
        FOR RC IN CUDATA(INUIDACTIVIDAD) LOOP
            RCORREGENERAACTIVIDA := OR_TYOBREGENERAACTIVIDAD
                                (
                                    RC.ID_REGENERA_ACTIVIDA,
                                    RC.ACTIVIDAD,
                                    RC.ID_CAUSAL,
                                    RC.CUMPLIDA,
                                    RC.ACTIVIDAD_REGENERAR,
                                    RC.ACTIVIDAD_WF,
                                    RC.ESTADO_FINAL,
                                    RC.TIEMPO_ESPERA,
                                    RC.ACTION,
                                    RC.TRY_LEGALIZE
                                );

            TBORREGENERAACTIVIDA.EXTEND;
            TBORREGENERAACTIVIDA(NUINDEX) := RCORREGENERAACTIVIDA;
            NUINDEX := NUINDEX+1;
        END LOOP;

        GTBITEMSLOAD(INUIDACTIVIDAD) := INUIDACTIVIDAD;
        
        UT_TRACE.TRACE('End Or_bcRegeneraActivid.CargaTablaRegAct - Total ['||NUINDEX||']', 6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            GTBITEMSLOAD.DELETE;
            TBORREGENERAACTIVIDA.DELETE;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            GTBITEMSLOAD.DELETE;
            TBORREGENERAACTIVIDA.DELETE;
            RAISE EX.CONTROLLED_ERROR;
    END CARGATABLAREGACT;

    














    PROCEDURE CARGATABLAACTADMIN
    IS
        CURSOR CUDATA
        IS
            SELECT /*+ index(ge_items  IDX_GE_ITEMS_02)
            INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_01  ) */
            OR_REGENERA_ACTIVIDA.ID_REGENERA_ACTIVIDA,
            OR_REGENERA_ACTIVIDA.ACTIVIDAD,
            OR_REGENERA_ACTIVIDA.ID_CAUSAL,
            OR_REGENERA_ACTIVIDA.CUMPLIDA,
            OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR,
            OR_REGENERA_ACTIVIDA.ACTIVIDAD_WF ,
            OR_REGENERA_ACTIVIDA.ESTADO_FINAL,
            OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA,
            OR_REGENERA_ACTIVIDA.ACTION,
            OR_REGENERA_ACTIVIDA.TRY_LEGALIZE
            FROM  GE_ITEMS , OR_REGENERA_ACTIVIDA
            WHERE OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR =  GE_ITEMS.ITEMS_ID
            AND GE_ITEMS.ITEM_CLASSIF_ID = OR_BOCONSTANTS.CNUADMIN_ACTIV_CLASSIF;

        RCORREGENERAACTIVIDA    OR_TYOBREGENERAACTIVIDAD;
        TBTEMPREGENERAACTIVIDA  DAOR_REGENERA_ACTIVIDA.TYTBOR_REGENERA_ACTIVIDA;
        NUINDEX                 NUMBER:= 1;
    BEGIN
        
        IF ( BLADMLOADCONFIG ) THEN
            RETURN;
        END IF;

        TBORACTIVIDADESADMIN    := OR_TYTBREGENERAACTIVIDAD();

        FOR RC IN CUDATA LOOP
            RCORREGENERAACTIVIDA := OR_TYOBREGENERAACTIVIDAD
                                (
                                    RC.ID_REGENERA_ACTIVIDA,
                                    RC.ACTIVIDAD,
                                    RC.ID_CAUSAL,
                                    RC.CUMPLIDA,
                                    RC.ACTIVIDAD_REGENERAR,
                                    RC.ACTIVIDAD_WF,
                                    RC.ESTADO_FINAL,
                                    RC.TIEMPO_ESPERA,
                                    RC.ACTION,
                                    RC.TRY_LEGALIZE
                                );

            TBORACTIVIDADESADMIN.EXTEND;
            TBORACTIVIDADESADMIN(NUINDEX) := RCORREGENERAACTIVIDA;
            NUINDEX := NUINDEX+1;
        END LOOP;

        BLADMLOADCONFIG := TRUE;
        UT_TRACE.TRACE('End Or_bcRegeneraActivid.CargaTablaActAdmin - Total ['||TBORACTIVIDADESADMIN.COUNT||']', 6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            BLADMLOADCONFIG := FALSE;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            BLADMLOADCONFIG := FALSE;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    











































    PROCEDURE ACTIVIDADESAREGENERA
    (
        INUIDACTIVIDAD          IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUIDCAUSAL             IN  GE_CAUSAL.CAUSAL_ID%TYPE,
        INUCUMPLIDA             IN  OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE,
        INUINTENTOS             IN  OR_REGENERA_ACTIVIDA.TRY_LEGALIZE%TYPE,
        OTBACTIVIDAREGEN        OUT TYTBACTIVIDADREGEN
    )
    IS
        CURSOR  CUCONFIGREGENERAACT
        (
            NUIDACTIVIDAD       IN  GE_ITEMS.ITEMS_ID%TYPE,
            NUIDCAUSAL          IN  GE_CAUSAL.CAUSAL_ID%TYPE,
            NUCUMPLIDA          IN  OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE,
            NUINTENTOS          IN  OR_REGENERA_ACTIVIDA.TRY_LEGALIZE%TYPE
        )
        IS
            SELECT  A.ACTIVIDAD_REGENERAR,
                    A.ACTIVIDAD_WF,
                    A.TIEMPO_ESPERA,
                    NULL TIEMPO_VIDA,
                    NULL PRIORIDAD_DESPACHO,
                    A.ACTION,
                    A.TRY_LEGALIZE
              FROM  TABLE(CAST(TBORREGENERAACTIVIDA AS  OR_TYTBREGENERAACTIVIDAD)) A
              /*+ Or_bcRegeneraActivid.ActividadesARegenera SAO182466 */
             WHERE  A.ACTIVIDAD   = NUIDACTIVIDAD
               AND  NVL(A.ID_CAUSAL, NUIDCAUSAL) = NUIDCAUSAL
               AND  (   A.TRY_LEGALIZE IS NULL OR
                        A.TRY_LEGALIZE = NVL(NUINTENTOS, 0)
                    )
               AND  ( (NUCUMPLIDA = 0) AND (NUCUMPLIDA = A.CUMPLIDA)
                OR    (NUCUMPLIDA != 0) AND (A.CUMPLIDA > 0) );

        CURSOR  CUCONFREGACT
        (
            NUIDACTIVIDAD       IN  GE_ITEMS.ITEMS_ID%TYPE,
            NUIDCAUSAL          IN  GE_CAUSAL.CAUSAL_ID%TYPE,
            NUCUMPLIDA          IN  OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE
        )
        IS
            SELECT  A.ACTIVIDAD_REGENERAR,
                    A.ACTIVIDAD_WF,
                    A.TIEMPO_ESPERA,
                    NULL TIEMPO_VIDA,
                    NULL PRIORIDAD_DESPACHO,
                    A.ACTION,
                    A.TRY_LEGALIZE
              FROM  TABLE(CAST(TBORREGENERAACTIVIDA AS  OR_TYTBREGENERAACTIVIDAD)) A
              /*+ Or_bcRegeneraActivid.ActividadesARegenera SAO193408 */
             WHERE  A.ACTIVIDAD   = NUIDACTIVIDAD
               AND  NVL(A.ID_CAUSAL, NUIDCAUSAL) = NUIDCAUSAL
               AND  A.TRY_LEGALIZE IS NULL
               AND  ( (NUCUMPLIDA = 0) AND (NUCUMPLIDA = A.CUMPLIDA)
                OR    (NUCUMPLIDA != 0) AND (A.CUMPLIDA > 0) );
      
        PROCEDURE CLOSECURSORS
        IS
        BEGIN
            IF CUCONFIGREGENERAACT%ISOPEN THEN
                CLOSE CUCONFIGREGENERAACT;
            END IF;

            IF CUCONFREGACT%ISOPEN THEN
                CLOSE CUCONFREGACT;
            END IF;
        END;
      
    BEGIN
        UT_TRACE.TRACE('inuIdActividad: ['||INUIDACTIVIDAD||'] - '
            ||'inuIdCausal: ['||INUIDCAUSAL||'] - '
            ||'inuCumplida: ['||INUCUMPLIDA||'] ', 6);
            
         IF (INUIDACTIVIDAD IS NULL) THEN
            RETURN;
         END IF;
            
        CARGATABLAREGACT(INUIDACTIVIDAD);

        CLOSECURSORS;

        IF(INUINTENTOS IS NOT NULL)THEN
            OPEN  CUCONFIGREGENERAACT(INUIDACTIVIDAD, INUIDCAUSAL, INUCUMPLIDA, INUINTENTOS);
            FETCH CUCONFIGREGENERAACT BULK COLLECT INTO OTBACTIVIDAREGEN;
            CLOSE CUCONFIGREGENERAACT;
        ELSE
            OPEN  CUCONFREGACT(INUIDACTIVIDAD, INUIDCAUSAL, INUCUMPLIDA);
            FETCH CUCONFREGACT BULK COLLECT INTO OTBACTIVIDAREGEN;
            CLOSE CUCONFREGACT;
        END IF;

        UT_TRACE.TRACE('FIN Or_bcRegeneraActivid.ActividadesARegenera - Total: ['||OTBACTIVIDAREGEN.COUNT||']', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            CLOSECURSORS;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            CLOSECURSORS;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ACTIVIDADESAREGENERA;

    


























    PROCEDURE ACTIVIDADESADMIN (
                                    INUIDACTIVIDAD      IN GE_ITEMS.ITEMS_ID%TYPE,
                                    INUIDCAUSAL         IN GE_CAUSAL.CAUSAL_ID%TYPE,
                                    INUESTADO           IN OR_REGENERA_ACTIVIDA.ESTADO_FINAL%TYPE,
                                    INUCUMPLIDA         IN OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE,
                                    OTBACTIVIDAREGEN   OUT TYTBACTIVIDADREGEN
                               )
    IS
        CURSOR  CUCONFIGREGENERAACT (
                                        NUIDACTIVIDAD  IN  GE_ITEMS.ITEMS_ID%TYPE,
                                        NUIDCAUSAL     IN  GE_CAUSAL.CAUSAL_ID%TYPE,
                                        INUESTADO      IN OR_REGENERA_ACTIVIDA.ESTADO_FINAL%TYPE,
                                        NUCUMPLIDA     IN  OR_REGENERA_ACTIVIDA.CUMPLIDA%TYPE
                                    )
        IS
            SELECT  A.ACTIVIDAD_REGENERAR,
                    A.ACTIVIDAD_WF,
                    A.TIEMPO_ESPERA,
                    OR_ACTIVIDAD.PRIORIDAD_DESPACHO,
                    OR_ACTIVIDAD.TIEMPO_VIDA,
                    NULL ACTION,
                    NULL INTENTOS
              FROM  TABLE(CAST(TBORACTIVIDADESADMIN AS  OR_TYTBREGENERAACTIVIDAD)) A , OR_ACTIVIDAD
             WHERE  A.ACTIVIDAD   = INUIDACTIVIDAD
               AND  NVL(A.ID_CAUSAL, NUIDCAUSAL) = NUIDCAUSAL
               AND  A.ESTADO_FINAL = INUESTADO
               AND A.ACTIVIDAD_REGENERAR = OR_ACTIVIDAD.ID_ACTIVIDAD
               AND NVL(OR_ACTIVIDAD.ACTIVA,GE_BOCONSTANTS.CSBYES) = GE_BOCONSTANTS.CSBYES
               AND  ((INUCUMPLIDA = 0 AND INUCUMPLIDA = A.CUMPLIDA)
                OR    (INUCUMPLIDA != 0 AND A.CUMPLIDA > 0) );

    BEGIN
        UT_TRACE.TRACE('inuIdActividad: ['||INUIDACTIVIDAD||'] - '
            ||'inuIdCausal: ['||INUIDCAUSAL||'] - '
            ||'inuEstado: ['||INUESTADO||'] - '
            ||'inuCumplida: ['||INUCUMPLIDA||'] ', 6);
        CARGATABLAACTADMIN;

        IF CUCONFIGREGENERAACT%ISOPEN THEN
            CLOSE CUCONFIGREGENERAACT;
        END IF;

        OPEN  CUCONFIGREGENERAACT(INUIDACTIVIDAD, NVL(INUIDCAUSAL,-1), INUESTADO, INUCUMPLIDA);
        FETCH CUCONFIGREGENERAACT BULK COLLECT INTO OTBACTIVIDAREGEN;
        CLOSE CUCONFIGREGENERAACT;

        UT_TRACE.TRACE('FIN Or_bcRegeneraActivid.ActividadesAdmin - Total: ['||OTBACTIVIDAREGEN.COUNT||']', 6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUCONFIGREGENERAACT%ISOPEN THEN
                CLOSE CUCONFIGREGENERAACT;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CUCONFIGREGENERAACT%ISOPEN THEN
                CLOSE CUCONFIGREGENERAACT;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
























    PROCEDURE ORDENESAVENCER
    (
        INUTASKTYPEID       IN OR_ORDER_ACTIVITY.TASK_TYPE_ID%TYPE,
        ISBACTIVIDADES      IN  VARCHAR2,
        INUDIASVENCIMIENTO  IN  NUMBER,
        ORFORDVENCER        OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Begin Or_bcRegeneraActivid.OrdenesAVencer',1);

        OPEN ORFORDVENCER FOR
            'SELECT /*+ ordered */ OR_order_activity.order_id,
                    OR_order_activity.order_activity_id,
                    OR_order_activity.activity_id
            FROM    OR_order,
                    OR_order_activity
            /*+ Or_bcRegeneraActivid.OrdenesAVencer SAO182764 */
            WHERE   OR_order.ORDER_status_id = 0
              AND   OR_order.order_id = OR_order_activity.order_id
              AND   or_order_activity.status <>'''|| OR_BOCONSTANTS.CSBFINISHSTATUS||'''
              AND   or_order_activity.activity_id IN ('||ISBACTIVIDADES|| ') '||
            ' AND   OR_order.task_type_id = '||INUTASKTYPEID||
            ' AND     (trunc(sysdate) - trunc(OR_order.created_date)) > '||INUDIASVENCIMIENTO;

        UT_TRACE.TRACE('End Or_bcRegeneraActivid.OrdenesAVencer',1);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ORDENESAVENCER;
    
    
















    PROCEDURE GETADMINACTIVITIES
    (
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN ORFREFCURSOR FOR
            SELECT/*+ INDEX(ge_items  IDX_GE_ITEMS_02)
                      INDEX(OR_regenera_activida IDX_OR_REGENERA_ACTIVIDA_02) */
                    OR_REGENERA_ACTIVIDA.ID_REGENERA_ACTIVIDA,
                    OR_REGENERA_ACTIVIDA.ACTIVIDAD,
                    OR_REGENERA_ACTIVIDA.ID_CAUSAL,
                    OR_REGENERA_ACTIVIDA.ACTIVIDAD_REGENERAR,
                    OR_REGENERA_ACTIVIDA.ESTADO_FINAL,
                    OR_REGENERA_ACTIVIDA.TIEMPO_ESPERA
            FROM    GE_ITEMS,
                    OR_REGENERA_ACTIVIDA
            WHERE   OR_REGENERA_ACTIVIDA.ACTIVIDAD = GE_ITEMS.ITEMS_ID
            AND     GE_ITEMS.ITEM_CLASSIF_ID = OR_BOCONSTANTS.CNUADMIN_ACTIV_CLASSIF;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
















    PROCEDURE GETCAUSALBYORDER(
                                INUORDERID  IN OR_ORDER.ORDER_ID%TYPE,
                                OTBCAUSAL  OUT DAOR_REGENERA_ACTIVIDA.TYTBID_CAUSAL
                              )
    IS
        CURSOR CUCAUSAL(INUORDERID  IN OR_ORDER.ORDER_ID%TYPE) IS
            SELECT ID_CAUSAL
              FROM OR_REGENERA_ACTIVIDA
             WHERE ACTIVIDAD IN (SELECT ACTIVITY_ID
                                   FROM OR_ORDER_ACTIVITY
                                  WHERE ORDER_ID = INUORDERID
                                    AND STATUS <> OR_BOCONSTANTS.CSBFINISHSTATUS);

    BEGIN
        OPEN CUCAUSAL (INUORDERID);
        FETCH CUCAUSAL BULK COLLECT INTO OTBCAUSAL;
        CLOSE CUCAUSAL;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUCAUSAL%ISOPEN THEN
                CLOSE CUCAUSAL;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CUCAUSAL%ISOPEN THEN
                CLOSE CUCAUSAL;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    















    PROCEDURE GETCHILDACTIVITIES
    (
        INUORDERACTID   IN      OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        OTBCHILDACTS    OUT     DAOR_ORDER_ACTIVITY.TYTBOR_ORDER_ACTIVITY
    )
    IS
        CURSOR CUCHILDACTS
        IS
                      SELECT OR_ORDER_ACTIVITY.*,OR_ORDER_ACTIVITY.ROWID
                        FROM OR_ORDER_ACTIVITY
                       WHERE OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID <> INUORDERACTID
                  START WITH OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID = INUORDERACTID
            CONNECT BY PRIOR OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID = OR_ORDER_ACTIVITY.ORIGIN_ACTIVITY_ID;

    BEGIN
    
        UT_TRACE.TRACE('Inicio Or_bcRegeneraActivid.GetChildActivities ',9);
        UT_TRACE.TRACE('inuOrderActId ['||INUORDERACTID||']',9);
        
        OPEN CUCHILDACTS ;
        FETCH CUCHILDACTS BULK COLLECT INTO OTBCHILDACTS;
        CLOSE CUCHILDACTS;
        
        UT_TRACE.TRACE('Fin Or_bcRegeneraActivid.GetChildActivities ['||OTBCHILDACTS.COUNT||']',9);
    
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUCHILDACTS%ISOPEN THEN
            
                CLOSE CUCHILDACTS;
            
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CUCHILDACTS%ISOPEN THEN
            
                CLOSE CUCHILDACTS;
            
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCHILDACTIVITIES;

END OR_BCREGENERAACTIVID;