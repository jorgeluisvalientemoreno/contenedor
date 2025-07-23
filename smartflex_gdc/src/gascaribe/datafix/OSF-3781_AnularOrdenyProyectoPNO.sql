column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  
	CURSOR cuOrdenPNO 
	IS
		select order_id
		from FM_POSSIBLE_NTL 
		where order_id 	in (348376899)
		and STATUS		in ('R','P');

	nuCommentType number := 1277;
	nuErrorCode   number;
	sbErrorMesse  varchar2(4000);
	sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso OSF-3781';
	
BEGIN

	dbms_output.put_line('Inicia OSF-3781');

	FOR reg IN cuOrdenPNO LOOP
		
		BEGIN
			dbms_output.put_line('Incia anulación Orden: ' || reg.order_id);
		  
			api_anullorder(reg.order_id,
						   nuCommentType,
						   sbOrderCommen,
						   nuErrorCode,
						   sbErrorMesse
						  );
		  
			IF (nuErrorCode = 0) THEN
			
				update FM_POSSIBLE_NTL 
				set status = 'N'
				where order_id = reg.order_id;
				
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
  
	dbms_output.put_line('Inicia OSF-3781');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/