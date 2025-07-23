column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuDatos IS
    SELECT * 
	FROM or_order 
	WHERE order_id IN (349771081, 349771092, 349771097, 349771115, 349771118,
                          349771035, 349771072, 349771082, 349771022, 349771028,
                          349771033, 349771042, 349771049, 349771059, 349771061,
                          349771095, 349771110, 349771112, 349771020, 349771024,
                          349771023, 349771030, 349771032, 349771040, 349771045,
                          349771107, 349771048, 349771050, 349771056, 349771060,
                          349771065, 349771066, 349771071, 349771077, 349771093,
                          349771109, 349771113, 349771114, 349771117, 349771124,
                          349771125, 349771130, 349771021);

  sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso SOSF-3262';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
BEGIN

	dbms_output.put_line('Inicia OSF-4541');

	FOR reg IN cudatos LOOP
		BEGIN
			dbms_output.put_line('Orden: ' || reg.order_id);
		  
			api_anullorder(reg.order_id,
						   nuCommentType,
						   sbOrderCommen,
						   nuErrorCode,
						   sbErrorMesse
						  );
		  
			IF (nuErrorCode = 0) THEN
				COMMIT;
				dbms_output.put_line('Se anulo OK orden: ' || reg.order_id);
			ELSE
				ROLLBACK;
				dbms_output.put_line('Error anulando orden: ' || reg.order_id || ' : ' || sbErrorMesse);
			END IF;
		
		EXCEPTION
			WHEN OTHERS THEN
			dbms_output.put_line('Error OTHERS anulando orden: ' || reg.order_id || ' : ' || sqlerrm);
			ROLLBACK;
		END;
	  END LOOP;
  
	dbms_output.put_line('Inicia OSF-4541');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/