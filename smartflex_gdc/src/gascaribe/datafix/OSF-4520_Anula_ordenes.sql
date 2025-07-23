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
	WHERE order_id IN (357734710, 359918778, 361136306, 356994579, 357474892, 357474928, 357013188, 
                       357106005, 357106616, 357464371, 357007765, 357009586, 357106452, 356972403, 
                       356786511, 357002106);

  sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso SOSF-3274';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
BEGIN

	dbms_output.put_line('Inicia OSF-4520');

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
  
	dbms_output.put_line('Inicia OSF-4520');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/