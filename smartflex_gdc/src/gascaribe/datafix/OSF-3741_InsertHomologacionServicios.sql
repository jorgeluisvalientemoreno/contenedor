column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 1805');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
BEGIN
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
            'SA_BOEXECUTABLE.GETEXECUTABLEDATABYNAME', 
            'Proceso que devuelve informacion del ejecutable por su nombre', 
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.PRCOBTINFOEJECXNOMBRE', 
            'Proceso que devuelve informacion del ejecutable por su nombre',
            NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
            'PKEXECUTEDPROCESSMGR.FSBGETSTATUSOFPROCESS', 
            'Funcion que devuelve estado de un proceso en procejec', 
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.FSBOBTESTADOPROCESO', 
            'Funcion que devuelve estado de un proceso en procejec',
            NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
            'PKEXECUTEDPROCESSMGR.VALIFCANEXECUTEPROCESS', 
            'Proceso que valida si se puede ejecutar un proceso (procejec)', 
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.PRCVALIDAEJECUPROCESO', 
            'Proceso que valida si se puede ejecutar un proceso (procejec)',
            NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
            'PKBOPROCCTRLBYSERVICEMGR.FILLSERVPENDLIQSERVTYPE', 
            'Proceso que obtiene tabla de servicios pendientes por liquidar', 
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.PRCOBTSERVPENDLIQU', 
            'Proceso que obtiene tabla de servicios pendientes por liquidar',
            NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKTBLSERVICIO.FSBGETDESCRIPTION', 
              'Retona la descripcion del id de servicio', 
              'ADM_PERSON',
              'PKG_SERVICIO.FSBOBTDESCRIPCION', 
              'Retona la descripcion del id de servicio',
              NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'GE_BCPROCESS_SCHEDULE.FRFGETSCHEDULESBYAPLICATION', 
              'Proceso que devuelve programacion por ejecutable', 
              'ADM_PERSON',
              'PKG_GESTIONPROCESOSPROGRAMADOS.FRFOBTPROGRAMACIONXEJECU', 
              'Proceso que devuelve programacion por ejecutable',
              NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'GE_BCPROC_SCHE_DETAIL.GETSCHEDULEDETAILS', 
              'Proceso que devuelve detalle de la programacion', 
              'ADM_PERSON',
              'PKG_GE_PROC_SCHE_DETAIL.PRCOBTDETALLEPROGRAMACION', 
              'Proceso que devuelve detalle de la programacion',
              NULL );

      INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKBCPERICOSE.VALCNSMPRDCONFIG', 
              'Proceso valida que haya un periodo de consumo configurado para el ciclo y periodo de facturacion', 
              'ADM_PERSON',
              'PKG_BOGESTIONPERIODOS.PRCVALIPERIODOCONSCONF', 
              'Proceso valida que haya un periodo de consumo configurado para el ciclo y periodo de facturacion',
              NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKBOPROCCTRLBYBILLPERIOD.INSBILLPERIODTOPROCINREPOINCO', 
              'Proceso que inserta en repoinco el periodo de facturacion a procesar', 
              'ADM_PERSON',
              'PKG_REPORTES_INCO.PRCINSPERIFACTAPROCREPOINC', 
              'Proceso que inserta en repoinco el periodo de facturacion a procesar',
              NULL );

     INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'GE_BOUTILITIES.ADDATTRIBUTE', 
              'Proceso para adicionar atributos a una consulta', 
              'ADM_PERSON',
              'PKG_BOUTILIDADES.PRADICIONATRIBUTOS', 
              'Proceso para adicionar atributos a una consulta',
              NULL );


    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKBILLINGPERIODMGR.GETNEXTBILLPERIOD', 
              'Proceso que obtiene el siguiente periodo de facturacion, teniendo en cuenta el periodo ingresado', 
              'ADM_PERSON',
              'PKG_BOGESTIONPERIODOS.PRCOBTPERIODOFACTSIGU', 
              'Proceso que obtiene el siguiente periodo de facturacion, teniendo en cuenta el periodo ingresado',
              NULL );
    
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN',
            upper('pkBillingPeriodMgr.frcGetAccCurrentPeriod'),
            'Obtiene periodo de facturación actual',
            'ADM_PERSON',
            'PKG_BOGESTIONPERIODOS.FRCOBTPERIODOFACTURACIONACTUAL',
            'Obtiene periodo de facturación actual',
            NULL );

  INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN',
            'PKEXECUTEDPROCESSMGR.ADDINEXECRECORD',
            'Proceso que registra en la tabla procejec',
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.PRCINSERTAREGISTROEJEC',
            'Proceso que registra en la tabla procejec',
            NULL );
    
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN',
            'PKEXECUTEDPROCESSMGR.UPDATEPROCESS',
            'Proceso que actualiza a terminado registro en la tabla procejec',
            'ADM_PERSON',
            'PKG_BOGESTIONEJECUCIONPROCESOS.PRCACTUALIZAREGISTROEJEC',
            'Proceso que actualiza a terminado registro en la tabla procejec',
            NULL );

   
    -- OSF-3772
    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'DAGE_PROCESS_SCHEDULE.FSBGETPARAMETERS_' as SERVICIO_ORIGEN,
      'Obtiene el valor de los parámetros del proceso programado' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_GESTIONPROCESOSPROGRAMADOS.FSBOBTPARAMETROSPROCESO' as SERVICIO_DESTINO,
      'Obtiene el valor de los parámetros del proceso programado' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'GE_BOSCHEDULE.ADDLOGTOSCHEDULEPROCESS' as SERVICIO_ORIGEN,
      'Agrega log a un proceso programado' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_GESTIONPROCESOSPROGRAMADOS.PRC_AGREGALOGALPROCESO' as SERVICIO_DESTINO,
      'Agrega log a un proceso programado' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;

    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'GE_BOSCHEDULE.CHANGELOGPROCESSSTATUS' as SERVICIO_ORIGEN,
      'Actualiza el estado del log del proceso' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_GESTIONPROCESOSPROGRAMADOS.PRC_ACTESTADOLOGPROCESO' as SERVICIO_DESTINO,
      'Actualiza el estado del log del proceso' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;


    MERGE INTO PERSONALIZACIONES.HOMOLOGACION_SERVICIOS A USING
     (SELECT
      'OPEN' as ESQUEMA_ORIGEN,
      'UT_STRING.GETPARAMETERVALUE' as SERVICIO_ORIGEN,
      'Obtiene el valor de un parametro de proceso programado' as DESCRIPCION_ORIGEN,
      'ADM_PERSON' as ESQUEMA_DESTINO,
      'PKG_GESTIONPROCESOSPROGRAMADOS.FSBOBTVALORPARAMETROPROCESO' as SERVICIO_DESTINO,
      'Obtiene el valor de un parametro de proceso programado' as DESCRIPCION_DESTINO,
      NULL as OBSERVACION
      FROM DUAL) B
    ON (A.ESQUEMA_ORIGEN = B.ESQUEMA_ORIGEN and A.SERVICIO_ORIGEN = B.SERVICIO_ORIGEN)
    WHEN NOT MATCHED THEN 
    INSERT (
      ESQUEMA_ORIGEN, SERVICIO_ORIGEN, DESCRIPCION_ORIGEN, ESQUEMA_DESTINO, SERVICIO_DESTINO, 
      DESCRIPCION_DESTINO, OBSERVACION)
    VALUES (
      B.ESQUEMA_ORIGEN, B.SERVICIO_ORIGEN, B.DESCRIPCION_ORIGEN, B.ESQUEMA_DESTINO, B.SERVICIO_DESTINO, 
      B.DESCRIPCION_DESTINO, B.OBSERVACION)
    WHEN MATCHED THEN
    UPDATE SET 
      A.DESCRIPCION_ORIGEN = B.DESCRIPCION_ORIGEN,
      A.ESQUEMA_DESTINO = B.ESQUEMA_DESTINO,
      A.SERVICIO_DESTINO = B.SERVICIO_DESTINO,
      A.DESCRIPCION_DESTINO = B.DESCRIPCION_DESTINO,
      A.OBSERVACION = B.OBSERVACION;


    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
SET SERVEROUTPUT OFF
QUIT
/ 