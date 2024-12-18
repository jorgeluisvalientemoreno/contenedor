column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
	CURSOR cuOrdeAsig IS
	SELECT o.defined_contract_id contrato, sum(nvl(estimated_cost,0)) costo
	FROM or_order o
	WHERE o.order_status_id IN ( 5,6,7)
	  AND o.defined_contract_id in (5542)
	-- AND o.defined_contract_id is not null
	 and o.task_type_id <> 10044
	 group by o.defined_contract_id;	

begin
	DBMS_OUTPUT.PUT_LINE('ORDENES ASIGNADAS');
    FOR reg IN cuOrdeAsig LOOP
	  DBMS_OUTPUT.PUT_LINE('REG.contrato:'||REG.contrato||'|'||'REG.coSTO: '||REG.coSTO);
	   UPDATE ge_contrato set VALOR_ASIGNADO = REG.coSTO WHERE ID_CONTRATO = REG.contrato;
	   commit;
    END LOOP;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/