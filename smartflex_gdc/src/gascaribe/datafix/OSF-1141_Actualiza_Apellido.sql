set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
BEGIN
	UPDATE open.mo_data_change
	SET 	entity_attr_new_val = 'BONET MCORMICK'
	WHERE   mo_data_change.motive_id = 86179658
    AND     mo_data_change.entity_name = 'GE_SUBSCRIBER'
    AND     mo_data_change.entity_pk = 695598
    AND 	mo_data_change.attribute_name = 'SUBS_LAST_NAME';
	
	COMMIT;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/