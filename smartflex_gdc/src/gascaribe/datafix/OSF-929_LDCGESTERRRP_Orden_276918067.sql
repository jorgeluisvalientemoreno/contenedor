column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

    onuErrorCode        NUMBER;
    osbErrorMessage     VARCHAR2(4000);

	cursor cuOrdenes is
       SELECT od.order_id, od.causal_id, rownum nurownum
	   FROM or_order od
	   WHERE od.order_id in
	   (
            276918067
	   );

    PROCEDURE ldc_proc_aud_bloq_lega_sol (nmpasolicitud       NUMBER,
                                          nmpaorden           NUMBER,
                                          sbmensaje       OUT VARCHAR)
    IS
    BEGIN
        sbmensaje := NULL;

        INSERT INTO ldc_aud_bloq_lega_sol (package_id,
                                                order_id,
                                                usuario,
                                                fecha,
                                                maquina)
             VALUES (nmpasolicitud,
                     nmpaorden,
                     USER,
                     SYSDATE,
                     SYS_CONTEXT ('USERENV', 'TERMINAL'));
    EXCEPTION
        WHEN OTHERS
        THEN
            ROLLBACK;
            sbmensaje :=
                   'Error en ldc_proc_aud_bloq_lega_sol : '
                || SQLERRM;
    END ldc_proc_aud_bloq_lega_sol;

    PROCEDURE prcProcesaGrilla
    (
        inuOrden        IN  NUMBER
    )
    IS
        nuSolicitud   NUMBER;                          --se almacena solicitud

        --se obtiene solicitud de la orden
        CURSOR cuGetSolicitud IS
            SELECT oa.package_id
              FROM open.or_order_activity oa
             WHERE oa.order_id = inuOrden;
    BEGIN
       dbms_output.put_line ('Inicio .prcProcesaGrilla');

        OPEN cuGetSolicitud;
        FETCH cuGetSolicitud INTO nuSolicitud;
        CLOSE cuGetSolicitud;

        --se elimina registro de bloqueo
        DELETE FROM open.LDC_BLOQ_LEGA_SOLICITUD
        WHERE PACKAGE_ID_GENE = nuSolicitud;
        
       dbms_output.put_line ('Delete registro en LDC_BLOQ_LEGA_SOLICITUD solicitud|' ||  nuSolicitud );        

        DELETE open.LDC_ORDER
        WHERE ORDER_ID = inuOrden;

       dbms_output.put_line ('Delete registro en LDC_ORDER orden| ' || inuOrden);        

        osbErrorMessage := NULL;
        
        /*CA516 JJJM Inicio*/
        ldc_proc_aud_bloq_lega_sol (nuSolicitud, inuOrden, osbErrorMessage);

       dbms_output.put_line ('Termina prcProcesaGrilla');
    EXCEPTION
        WHEN ex.controlled_error THEN
            errors.geterror (onuErrorCode, osbErrorMessage);
            dbms_output.put_line ('ERROR controlado orden|' || inuOrden || '|' || osbErrorMessage );
            ROLLBACK;
        WHEN OTHERS THEN
            errors.seterror;
            errors.geterror (onuErrorCode, osbErrorMessage);
            dbms_output.put_line ('ERROR Otros orden|' || inuOrden || '|' || osbErrorMessage );
            ROLLBACK;
    END prcProcesaGrilla;

BEGIN

	FOR reg IN cuOrdenes LOOP
		prcProcesaGrilla( reg.order_id );
	END LOOP;
	
	COMMIT;
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/