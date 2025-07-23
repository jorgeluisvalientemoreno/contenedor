column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	CURSOR cuDatos 
	IS
		SELECT a.package_id,
			   a.product_id,
			   a.subscription_id,
			   o.order_id,
			   o.created_date,
			   o.order_status_id,
			   o.operating_unit_id
		FROM or_order_activity a, or_order o
		WHERE a.order_id IN (348125968, 348125971, 348125979, 348125986, 348125988, 348125991, 348125992, 348125995, 348126000, 348126009, 
							 354556910, 355886241, 362098275, 366818530, 366818804, 366818911, 348125964, 348125966, 348125969, 348125975,
							 348125976, 348125981, 348125990, 348125993, 348125998, 348126001, 348126004, 363576715, 363579215, 366819884,
							 348125957, 348125959, 348125962, 348125963, 348125965, 348125972, 348125973, 348125977, 348125978, 348125980,
							 348125984, 351195354, 352246577, 352738291, 354556905, 354556911, 366818727, 366821793, 348122713, 348125970,
							 348125982, 348125987, 348125989, 348125994, 348125996, 348125999, 348126006, 348126008, 363581647, 365192706,
							 367781981, 348125958, 348125967, 348125974, 348125983, 348125985, 348125997, 348126002, 348126003, 348126005,
							 348126007, 354556907, 354556908, 356954493, 363582644, 363586821, 365192683, 366818521, 368058943)
		AND a.order_id 		= o.order_id
		AND order_status_id	= 8
		ORDER BY package_id;

	sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso SOSF-3339';
	nuCommentType number := 1277;
	nuErrorCode   number;
	sbErrorMesse  varchar2(4000);
BEGIN

	dbms_output.put_line('Inicia OSF-4701');

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
  
	dbms_output.put_line('Inicia OSF-4701');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/