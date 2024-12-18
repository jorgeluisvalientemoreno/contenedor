column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuInformesInspeccion IS
	SELECT * FROM LDC_CERTIFICADOS_OIA
	WHERE 
    certificados_oia_id IN ( 3810336 , 3824817 , 3814942 );

    PROCEDURE pRechazaInforme( inuCERTIFICADOS_OIA_ID LDC_CERTIFICADOS_OIA.CERTIFICADOS_OIA_ID%TYPE) IS	
    BEGIN

		UPDATE LDC_CERTIFICADOS_OIA 
		SET 
			STATUS_CERTIFICADO ='R',
			OBSER_RECHAZO = OBSER_RECHAZO || '-' || 'Se cambio el estado a R por el caso OSF-661'
		WHERE CERTIFICADOS_OIA_ID =  inuCERTIFICADOS_OIA_ID;
	
		COMMIT;
		
		dbms_output.put_line('Ok Rechazando Informe : ' || inuCERTIFICADOS_OIA_ID );
		
    EXCEPTION
        WHEN others THEN
			dbms_output.put_line('Error Rechazando Informe : ' || inuCERTIFICADOS_OIA_ID || ' : ' || sqlerrm);
			ROLLBACK;
    END pRechazaInforme;

BEGIN

	FOR reg in cuInformesInspeccion LOOP

		pRechazaInforme( reg.CERTIFICADOS_OIA_ID );

	END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/