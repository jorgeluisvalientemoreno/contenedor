set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
	Insert into LECTELME (LEEMELME,LEEMTCON,LEEMPEFA,LEEMOBLE,LEEMLEAN,LEEMFELA,LEEMLETO,LEEMFELE,LEEMFAME,LEEMDOCU,LEEMSESU,LEEMCMSS,LEEMFLCO,LEEMCONS,LEEMPECS,LEEMPETL,LEEMCLEC,LEEMOBSB,LEEMOBSC) values ('670416','1','105310',null,'0',to_date('31/05/2023 06:14:08 AM','DD/MM/YYYY HH:MI:SS AM'),null,null,null,'280769823','1000880',null,null,'129436936','105285',null,'F',null,null);
	
	COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/