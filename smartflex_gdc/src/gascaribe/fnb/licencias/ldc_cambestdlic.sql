CREATE OR REPLACE PROCEDURE LDC_CAMBESTDLIC(inuProgramacion IN ge_process_schedule.process_schedule_id%TYPE) IS
    /**************************************************************************
      Autor       : Luz Guillen
      Fecha       : 2020-06-05
      Descripcion : Proceso para evitar costos de licenciamiento sobre productos que ya no se requieren
    
      Parametros Entrada
    
    
      Valor de salida
        sbmen  mensaje
        error  codigo del error
    
     HISTORIA DE MODIFICACIONES
       FECHA        AUTOR   DESCRIPCION
     19-09-2022    EDMLAR   OSF_556
                            Se cambia el nombre del programa MIGRA por LICENCIA, con el fin de identificar 
                            que el cambio realizado se hizo por este proceso.

    ***************************************************************************/
    nuparano     NUMBER(4);
    nuparmes     NUMBER(2);
    nutsess      NUMBER;
    sbparuser    VARCHAR2(30);
    nuHilos      NUMBER := 1;
    onuerror     NUMBER;
    osbError     VARCHAR2(500);

    nuLogProceso ge_log_process.log_process_id%TYPE;
    sbParametros ge_process_schedule.parameters_%TYPE;


    CURSOR cuServsusc IS
        SELECT --+ choose parallel (auto)
         A.SESUNUSE
        ,B.COMPONENT_ID SESUSESG
          FROM OPEN.SERVSUSC     A
              ,OPEN.PR_COMPONENT B
              ,OPEN.CONFESCO     C
         WHERE NOT EXISTS (SELECT 'X'
                  FROM OPEN.MO_MOTIVE        M
                      ,OPEN.MO_PACKAGES      PACK
                      ,OPEN.PS_MOTIVE_STATUS MS
                 WHERE M.PRODUCT_ID = A.SESUNUSE
                   AND PACK.PACKAGE_ID = M.PACKAGE_ID
                   AND PACK.MOTIVE_STATUS_ID = MS.MOTIVE_STATUS_ID
                   AND MS.IS_FINAL_STATUS = 'N')
           AND NVL(SESUSAFA, 0) = 0
           AND A.SESUNUSE = B.PRODUCT_ID
           AND A.SESUSERV IN (SELECT to_number(REGEXP_SUBSTR(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_SERVCAMBLICEN'),'[^|]+', 1, LEVEL))
                                FROM DUAL
                              CONNECT BY LEVEL <= LENGTH(REGEXP_REPLACE(DALD_PARAMETER.FSBGETVALUE_CHAIN('LDC_SERVCAMBLICEN'),'[^|]+')) + 1)
           AND A.SESUESFN = 'A'
           AND C.COECCODI = A.SESUESCO
           AND C.COECSERV = A.SESUSERV
           AND C.COECFACT = 'S'
           AND OPEN.PKDEFERREDMGR.FNUGETDEFERREDBALSERVICE(A.SESUNUSE) <= 0
           AND OPEN.PKBCCUENCOBR.FNUGETOUTSTANDBAL(A.SESUNUSE) <= 0
           AND OPEN.PKBCCUENCOBR.FNUCLAIMVALUEBYPROD(A.SESUNUSE) <= 0
           ;

    TYPE tytbservsusc IS TABLE OF cuServsusc%ROWTYPE INDEX BY BINARY_INTEGER;
    tbservsusc tytbservsusc;
BEGIN
    ut_trace.trace('[ Inicia LDC_CAMBESTDLIC', 1);
    
    SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
          ,TO_NUMBER(TO_CHAR(SYSDATE, 'MM'))
          ,USERENV('SESSIONID')
          ,USER
      INTO nuparano
          ,nuparmes
          ,nutsess
          ,sbparuser
      FROM dual;

    -- se establece el ejecutable
    pkerrors.setapplication('LICENCIA');

    -- Se inicia log del programa
    ldc_proinsertaestaprog(nuparano, nuparmes, 'LDC_CAMBESTDLIC', 'En ejecución', nutsess, sbparuser);

    -- Se adiciona al log de procesos
    ge_boschedule.AddLogToScheduleProcess(inuProgramacion, nuHilos, nuLogProceso);
    
    sbParametros := dage_process_schedule.fsbGetParameters_(inuProgramacion);

    OPEN cuServsusc;
    FETCH cuServsusc BULK COLLECT
        INTO tbservsusc LIMIT 10000;
    CLOSE cuServsusc;

    ut_trace.trace('Numero de productos a liberar: ' || tbservsusc.count, 2);

    IF tbservsusc.count <= 0
    THEN
        RETURN;
    END IF;

    FOR i IN tbservsusc.first .. tbservsusc.last
    LOOP
        BEGIN
            --<< Se actualizan los productos para liberar licencias
            pktblservsusc.updsesuesco(tbservsusc(i).sesunuse, 92);
            dapr_product.updproduct_status_id(tbservsusc(i).sesunuse, 3);
            dapr_component.updcomponent_status_id(tbservsusc(i).sesusesg, 9);
        EXCEPTION
            WHEN OTHERS THEN
                Errors.setError;
                errors.geterror(onuerror, osbError);
                ut_trace.trace('Error en liberacion de licencia de producto [' || tbservsusc(i).sesunuse ||']: ' || onuerror || ' - ' || osbError, 2);
        END;
    END LOOP;

    -- el proceso se actualiza en el staprog a termino ok 
    ldc_proactualizaestaprog(nutsess, 'Termino ok', 'LDC_CAMBESTDLIC', '');

    --Se Cambia el proceso a finalizado
    ge_boschedule.changelogProcessStatus(nuLogProceso, 'F');
    
    pkgeneralservices.committransaction;

    ut_trace.trace('] Finaliza LDC_CAMBESTDLIC', 1);
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
END;
/
