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
			277404529	,
			277404601	,
			277404614	,
			277404615	,
			277405055	,
			277416453	,
			277416456	,
			277406088	,
			277405446	,
			277408072	,
			277411767	,
			277411770	,
			277412963	,
			277412981	,
			277413073	,
			277418989	,
			277419092	,
			277419938	,
			277419950	,
			277420005	,
			277420171	,
			277420443	,
			277420450	,
			277420461	,
			277420485	,
			277420757	,
			277420795	,
			277420883	,
			277420891	,
			277420893	,
			277420903	,
			277420906	,
			277421128	,
			277421623	,
			277421684	,
			277422362	,
			277423303	,
			277423394	,
			277428020	,
			277428040	,
			277428049	,
			277428433	,
			277437800	,
			277407046	,
			277407534	,
			277408245	,
			277408268	,
			277408364	,
			277421067	,
			277418331	,
			277407529	,
			277407532	,
			277407653	,
			277407667	,
			277408262	,
			277408303	,
			277408342	,
			277420471	,
			277420659	,
			277421223	,
			277407562	,
			277408083	,
			277408279	,
			277408505	,
			277411771	,
			277412985	,
			277413096	,
			277418335	,
			277419084	,
			277419971	,
			277420467	,
			277420751	,
			277420763	,
			277420776	,
			277420785	,
			277420797	,
			277420896	,
			277421686	,
			277428794	,
			277404484	,
			277404491	,
			277404517	,
			277404594	,
			277404595	,
			277404597	,
			277404606	,
			277404608	,
			277404610	,
			277404611	,
			277404612	,
			277404618	,
			277404620	,
			277404634	,
			277405054	,
			277408177	,
			277416299	,
			277418161	
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
		COMMIT;
	END LOOP;
	
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/