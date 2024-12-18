set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
    DELETE FROM lectelme WHERE leemsesu = 52604476 AND leemleto IS NULL;
	
	DELETE FROM lectelme WHERE leemsesu = 1000880 AND leemleto IS NULL AND LEEMPEFA = 105310;
    COMMIT;
 Exception
   When others then
     Rollback;
     dbms_output.put_line(sqlerrm);
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/