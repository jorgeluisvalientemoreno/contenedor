column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	cursor cuLDC_HOMOITMAITAC is
		SELECT rg.*
		FROM LDC_HOMOITMAITAC rg
		WHERE ITEM_MATERIAL = 100007780
		AND ITEM_ACTIVIDAD = 100007758;

	PROCEDURE pBorraLDC_HOMOITMAITAC( inuItem NUMBER, inuActividad NUMBER )
	IS
  
	BEGIN

        dbms_output.put_line( 'Inicia pBorraLDC_HOMOITMAITAC' );

		DELETE LDC_HOMOITMAITAC rg
		WHERE ITEM_MATERIAL = inuItem
		AND ITEM_ACTIVIDAD = inuActividad;

		dbms_output.put_line( 'OK pBorraLDC_HOMOITMAITAC|item|' || inuItem || '|actividad|' || inuActividad || '|' || SQLERRM );
			
		COMMIT;
			  
        dbms_output.put_line( 'Termina pBorraLDC_HOMOITMAITAC' );
		
	exception
		when others then
			dbms_output.put_line( 'ERROR pBorraLDC_HOMOITMAITAC|item|' || inuItem || '|actividad|' || inuActividad || '|' || SQLERRM );
			rollback;	

	END pBorraLDC_HOMOITMAITAC;

BEGIN

	FOR reg IN cuLDC_HOMOITMAITAC LOOP
		pBorraLDC_HOMOITMAITAC( reg.ITEM_MATERIAL , reg.ITEM_ACTIVIDAD );
	END LOOP;
	
	commit;
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/