column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	nuValor_Liquidado	ge_contrato.valor_liquidado%type;
	nuValor_Pagado		ge_contrato.valor_total_pagado%type;

	CURSOR cuValor_Liquidado(inuId_Contrato in ge_contrato.id_contrato%type) IS
		select sum(valor_liquidado)
		from ge_acta 
		where id_contrato = inuId_Contrato;
		
	CURSOR cuValor_Pagado(inuId_Contrato in ge_contrato.id_contrato%type) IS
		select sum(valor_liquidado)
		from ge_acta 
		where id_contrato = inuId_Contrato
		and estado = 'C';


begin
  dbms_output.put_line('Inicia OSF-1138');
  
	BEGIN 
		dbms_output.put_line('Calculando valores del contrato 9321');
	
		if cuValor_Liquidado%isopen then
			close cuValor_Liquidado;
		end if;
		
		if cuValor_Pagado%isopen then
			close cuValor_Pagado;
		end if;
		
		open cuValor_Liquidado(9321);
		fetch cuValor_Liquidado into nuValor_Liquidado;
		close cuValor_Liquidado;
		
		open cuValor_Pagado(9321);
		fetch cuValor_Pagado into nuValor_Pagado;
		close cuValor_Pagado;
		
		dbms_output.put_line('El valor liquidado del contrato 9321 es: ' || nuValor_Liquidado);
		dbms_output.put_line('El valor total pagado del contrato 9321 es: ' || nuValor_Pagado);
		dbms_output.put_line('Actualizando el valor liquidado y valor total pagado del contrato 9321...');
		
		update ge_contrato
		set valor_liquidado 	= nuValor_Liquidado, 
			valor_total_pagado 	= nuValor_Pagado
		where id_contrato = 9321;

		COMMIT; 
		
	EXCEPTION
	WHEN OTHERS THEN 
		rollback; 
		DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
	END; 
	
	BEGIN 
		dbms_output.put_line('Calculando valores del contrato 9303');
	
		open cuValor_Liquidado(9303);
		fetch cuValor_Liquidado into nuValor_Liquidado;
		close cuValor_Liquidado;
		
		open cuValor_Pagado(9303);
		fetch cuValor_Pagado into nuValor_Pagado;
		close cuValor_Pagado;
		
		dbms_output.put_line('El valor liquidado del contrato 9303 es: ' || nuValor_Liquidado);
		dbms_output.put_line('El valor total pagado del contrato 9303 es: ' || nuValor_Pagado);
		dbms_output.put_line('Actualizando el valor liquidado y valor total pagado del contrato 9303...');
		
		update ge_contrato
		set valor_liquidado 	= nuValor_Liquidado, 
			valor_total_pagado 	= nuValor_Pagado
		where id_contrato = 9303;

		COMMIT; 
		
	EXCEPTION
	WHEN OTHERS THEN 
		rollback; 
		DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
	END;
	
	BEGIN 
		dbms_output.put_line('Calculando valores del contrato 9324');
	
		open cuValor_Liquidado(9324);
		fetch cuValor_Liquidado into nuValor_Liquidado;
		close cuValor_Liquidado;
		
		open cuValor_Pagado(9324);
		fetch cuValor_Pagado into nuValor_Pagado;
		close cuValor_Pagado;
		
		dbms_output.put_line('El valor liquidado del contrato 9324 es: ' || nuValor_Liquidado);
		dbms_output.put_line('El valor total pagado del contrato 9324 es: ' || nuValor_Pagado);
		dbms_output.put_line('Actualizando el valor liquidado y valor total pagado del contrato 9324...');
		
		update ge_contrato
		set valor_liquidado 	= nuValor_Liquidado, 
			valor_total_pagado 	= nuValor_Pagado
		where id_contrato = 9324;

		COMMIT; 
		
	EXCEPTION
	WHEN OTHERS THEN 
		rollback; 
		DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm); 
	END;
  
  DBMS_OUTPUT.PUT_LINE('Termina OSF-1138'); 
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/