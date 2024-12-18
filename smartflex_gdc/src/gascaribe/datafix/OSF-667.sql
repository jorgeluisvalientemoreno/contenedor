column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuOrden 	ct_order_certifica.order_id%TYPE := 260339143;
	nuActa 		ct_order_certifica.certificate_id%TYPE := 184011;

BEGIN

	DELETE FROM ct_order_certifica WHERE order_id = nuOrden AND certificate_id = nuActa;
	
	COMMIT;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/