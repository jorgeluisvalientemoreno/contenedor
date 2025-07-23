column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbDigitalPromNoteCons	ld_non_ba_fi_requ.digital_prom_note_cons%TYPE;
	sbManualPromNoteCons	ld_non_ba_fi_requ.manual_prom_note_cons%TYPE;
	
	CURSOR cuDatos
	IS
		SELECT * 
		FROM LD_NON_BA_FI_REQU 
		WHERE non_ba_fi_requ_id IN (225970240, 225970066);

BEGIN

	dbms_output.put_line('Inicio Datafix OSF-4156');
	
	FOR reg IN cuDatos LOOP
		
		dbms_output.put_line('Inicia actualización de la solicitud de financiación no bancaria: ' || reg.non_ba_fi_requ_id);
		
		IF (reg.non_ba_fi_requ_id = 225970240) THEN
		
			sbDigitalPromNoteCons 	:=  NULL;
			sbManualPromNoteCons	:=	reg.digital_prom_note_cons;
			
		ELSIF (reg.non_ba_fi_requ_id = 225970066) THEN	
		
			sbDigitalPromNoteCons 	:=  NULL;
			sbManualPromNoteCons	:=	reg.digital_prom_note_cons;

		END IF;		
		
		dbms_output.put_line('Se actualiza digital_prom_note_cons [' || reg.digital_prom_note_cons || '] por [' || sbDigitalPromNoteCons || ']');
		dbms_output.put_line('Se actualiza manual_prom_note_cons [' || reg.manual_prom_note_cons || '] por [' || reg.digital_prom_note_cons || ']');
		
		UPDATE ld_non_ba_fi_requ
		SET digital_prom_note_cons = sbDigitalPromNoteCons, 
			manual_prom_note_cons = sbManualPromNoteCons
		WHERE non_ba_fi_requ_id = reg.non_ba_fi_requ_id;
			
		dbms_output.put_line('Finaliza actualización de la solicitud de financiación no bancaria: ' || reg.non_ba_fi_requ_id);
		
		COMMIT;		
		
	END LOOP;	
	
	dbms_output.put_line('FIN Datafix OSF-4156');
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/