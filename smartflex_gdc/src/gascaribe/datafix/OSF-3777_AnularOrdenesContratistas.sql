column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  CURSOR cuDatos IS
    SELECT a.package_id,
           a.product_id,
           a.subscription_id,
           o.order_id,
           o.created_date,
           o.order_status_id,
           o.operating_unit_id
      FROM or_order_activity a, or_order o
     WHERE a.order_id IN (112195146, 112196079, 336972937, 341567593, 340112028, 340112014, 341098183, 192198185,
						  340112010, 192198184, 192198181, 192198182, 192198178, 192198183, 341097046, 192198175,
						  250653892, 192198179, 343382370, 343382351, 192198176, 192198180, 192198177, 192198174) 
       and a.order_id = o.order_id
	   and order_status_id = 8
     order by package_id;

	nuCommentType number := 1277;
	nuErrorCode   number;
	sbErrorMesse  varchar2(4000);
	sbOrderCommen varchar2(4000) := 'Se cambia estado a anulado por caso OSF-3777';
	
BEGIN

	dbms_output.put_line('Inicia OSF-3777');

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
  
	dbms_output.put_line('Inicia OSF-3777');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/