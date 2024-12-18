CREATE OR REPLACE PROCEDURE LDC_GeneraObligaAuto IS
    /*=======================================================================
        Unidad         : LDC_GeneraObligaAuto
        Descripcion    : Proceso para la generación automática de obligaciones 
        Autor          : jgomez@horbath
        Fecha          : 09.03.2021
    
        Historia de Modificaciones
    
        Fecha             Autor             Modificación
        =========   ==================      ====================
		06/09/2022  cgonzalez 				Se ajusta para identificar el contratista -1 - TODOS de
											la configuracion de la entidad LDC_COPRAUAC
        09.03.2021  jgomez@horbath.CA902    Creación
    =======================================================================*/
    onuerror      ge_error_log.error_log_id%TYPE;
    osbError      ge_error_log.description%TYPE;
    nuPeriodocert ge_periodo_cert.id_periodo%TYPE;
    nuSentence    NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_SENTENCIA_ACTAS_AUTO');
    csbREGISTRADO VARCHAR2(1) := 'R';
    csbPREACTA    VARCHAR2(1) := 'D';
    csbPROCESO    VARCHAR2(1) := 'P';
    csbERROR      VARCHAR2(1) := 'X';
    csbEXITO      VARCHAR2(1) := 'E';
    dtSYSDATE     DATE;
    nuCount       NUMBER := 0;
    nuCountE      NUMBER := 0;
    sbAPP         VARCHAR2(10) := 'GENOBLIAUT';
	nuContratista NUMBER;

    --<< configuración
    CURSOR cuLoadConfig IS
        SELECT *
          FROM LDC_COPRAUAC C
         WHERE TRUNC(C.COPAFEGA) <= TRUNC(SYSDATE)
           AND C.COPAESTA IN (csbREGISTRADO, csbPREACTA);

    TYPE tytbConfig IS TABLE OF cuLoadConfig%ROWTYPE INDEX BY BINARY_INTEGER;
    tbConfig tytbConfig;

    --<< Periodo de certificación
    CURSOR cuLoadPeriodoCert(idt DATE) IS
        SELECT p.id_periodo
          FROM ge_periodo_cert p
         WHERE trunc(idt) BETWEEN p.fecha_inicial AND p.fecha_final;

    --<< Actas por contratista y/o base administrativa
    CURSOR cuActasGeneradas(nuContratista NUMBER,
                            nuBase        NUMBER,
                            idt           DATE) IS
        SELECT UNIQUE GA.ID_ACTA
          FROM GE_ACTA GA
         WHERE GA.CONTRACTOR_ID = NVL(NUCONTRATISTA, GA.CONTRACTOR_ID)
           AND GA.ID_BASE_ADMINISTRATIVA = NVL(NUBASE, GA.ID_BASE_ADMINISTRATIVA)
           AND GA.FECHA_CREACION > IDT;

    TYPE tytbActas IS TABLE OF cuActasGeneradas%ROWTYPE INDEX BY BINARY_INTEGER;
    tbActas tytbActas;

    --<< Actualizacion del estado del proceso       
    PROCEDURE CambiaEstadoProceso(inuRegistro  NUMBER,
                                  isbEstado    VARCHAR2,
                                  isbResultado VARCHAR2 DEFAULT NULL) IS
    
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        ut_trace.trace(isbmessage => '[ LDC_GeneraObligaAuto.CambiaEstadoProceso', inulevel => 3);
    
        UPDATE LDC_COPRAUAC x
           SET x.copaesta = isbEstado,
               x.coparesu = isbResultado
         WHERE x.copaidcp = inuRegistro;
    
        pkgeneralservices.committransaction;
        ut_trace.trace(isbmessage => '] LDC_GeneraObligaAuto.CambiaEstadoProceso', inulevel => 3);
    EXCEPTION
        WHEN OTHERS THEN
            pkgeneralservices.rollbacktransaction;
            errors.seterror;
            errors.geterror(onuerror, osbError);
            ut_trace.trace(isbmessage => '] LDC_GeneraObligaAuto.CambiaEstadoProceso (err)', inulevel => 3);
    END CambiaEstadoProceso;

BEGIN
    ut_trace.trace(isbmessage => '[ LDC_GeneraObligaAuto', inulevel => 1);

    --<< Establece app para control del trigger.
    errors.setapplication(sbAPP);   

    --<< marcador de fecha de ejecución del proceso.
    dtSYSDATE := UT_DATE.FDTSYSDATE;
    
    --<< Carga la configuración
    OPEN cuLoadConfig;
    FETCH cuLoadConfig BULK COLLECT
        INTO tbConfig;
    CLOSE cuLoadConfig;

    ut_trace.trace(isbmessage => '--< Registros de configuración a procesar: [' || tbConfig.count || ']', inulevel => 2);

    --<< Procesa de acuerdo con la configuración cagada
    IF tbConfig.count != 0
    THEN
        
        FOR idx IN tbConfig.first .. tbConfig.last
        LOOP
            --<< Actualiza el estado del registro 
            CambiaEstadoProceso(tbConfig(idx).COPAIDCP, csbPROCESO);
        
            --<< Obtiene el periodo de certificación
            OPEN cuLoadPeriodoCert(tbConfig(idx).COPAFECO);
            FETCH cuLoadPeriodoCert
                INTO nuPeriodocert;
            CLOSE cuLoadPeriodoCert;
			
			nuContratista := NULL;
			nuContratista := tbConfig(idx).COPAIDCT;
			
			IF (nuContratista = -1) THEN 
				nuContratista := NULL;
			END IF;
        
            --<< Generación automática de obligaciones
            OS_PEGenContractObligat(inuPeriodId         => nuPeriodocert,
                                    idbCutOffDate       => TO_DATE(TRUNC(tbConfig(idx).COPAFECO + 1) - (1 / 24 / 3600),'DD/MM/YYYY HH24:MI:SS'),
                                    inuContractTypeId   => tbConfig(idx).COPATICO,
                                    inuContractorId     => nuContratista, 
                                    inuAdminBaseId      => tbConfig(idx).COPABAAD,
                                    onuErrorCode        => onuerror, 
                                    osbErrorMessage     => osbError);
        
            --<< Valida la ejecución del API.
            IF onuerror != 0
            THEN
                ut_trace.trace(isbmessage => '--<< Error API: [' || osbError || ']', inulevel => 2);
            
                --<< Registro con errores
                CambiaEstadoProceso(tbConfig(idx).COPAIDCP, csbERROR, onuerror || ' - ' || osbError);
            
                --<< Reversa la ejecución del API
                pkgeneralservices.rollbacktransaction;
                nuCountE := nuCountE + 1;
            ELSE
                ut_trace.trace(isbmessage => '--<< API Ok!', inulevel => 2);
            
                --<< Registro exitoso
                CambiaEstadoProceso(tbConfig(idx).COPAIDCP, csbEXITO, onuerror || ' - ' || osbError);
            
                --<< Confirma la transaccion del API
                pkgeneralservices.committransaction;
            
                --<< identifica las actas generadas
                OPEN cuActasGeneradas(nuContratista, tbConfig(idx).COPABAAD, dtSYSDATE);
                FETCH cuActasGeneradas BULK COLLECT
                    INTO tbActas;
                CLOSE cuActasGeneradas;
            
                ut_trace.trace(isbmessage => 'Actas generadas: [' || tbActas.count || ']', inulevel => 2);
            
                --<< Valida las actas generadas
                IF tbActas.count != 0
                   AND nuSentence IS NOT NULL
                THEN
                    --<< Procesa sentencia configurada por cada acta
                    NULL; -- Fase II
                
                    --<< Arma correo electrónico
                    NULL; -- Fase II
                ELSE
                    ut_trace.trace(isbmessage => 'No se generaron actas en el proceso. [' || tbActas.count || ' - ' ||  nuSentence || ']', inulevel => 2);
                END IF;
            END IF;
            nuCount := nuCount + 1;
        END LOOP;
    ELSE
        ut_trace.trace(isbmessage => 'No existe configuración generadora en [LD_COPRAUAC]. Valide los campos [COPAFEGA] y [COPAESTA]', inulevel => 2);
    END IF;

    ut_trace.trace(isbmessage => 'Registros de configuración procesados: [' || tbConfig.count || ']. (' || nuCountE || ') registros con error.', inulevel => 2);
    ut_trace.trace(isbmessage => '] LDC_GeneraObligaAuto', inulevel => 1);
    errors.setapplication(NULL); 
EXCEPTION
    WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(onuerror, osbError);
        ut_trace.trace(isbmessage => '] LDC_GeneraObligaAuto (err). [' || osbError || ']', inulevel => 1);
        RAISE ex.controlled_error;
END LDC_GeneraObligaAuto;
/

