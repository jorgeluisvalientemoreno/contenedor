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
	WHERE order_id IN (356151066, 356202173, 356349141);

  sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso SOSF-3306';
  nuCommentType number := 1277;
  nuErrorCode   number;
  sbErrorMesse  varchar2(4000);
BEGIN

	dbms_output.put_line('Inicia OSF-4619');

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
  
	dbms_output.put_line('Inicia OSF-4619');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/