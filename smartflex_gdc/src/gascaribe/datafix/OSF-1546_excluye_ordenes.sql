column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1546');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	CURSOR cuExcluirOrdenes IS
		select c.certificados_oia_id,
			   ce.status_certificado,
			   ce.fecha_aprobacion,
			   c.observacion,
			   c.estado,
			   c.order_id,
			   o.created_date,
			   o.execution_final_date,
			   o.legalization_date
		from open.ldc_genordvaldocu  c
		inner join open.ldc_certificados_oia ce on ce.certificados_oia_id = c.certificados_oia_id
		left join open.or_order o on o.order_id = c.order_id
		where o.execution_final_date >= '01/09/2023'
		and c.estado = 'A'
		order by c.certificados_oia_id asc;
		
	osbErrormessage            ge_error_log.description%TYPE;
	onuErrorcode               ge_error_log.error_log_id%TYPE;

begin
	dbms_output.put_line('Iniciando datafix OSF-1546');

	FOR c in cuExcluirOrdenes LOOP

		BEGIN
		
		dbms_output.put_line('Se inicia exclusion de la orden: ' || c.order_id);
		
		GE_BOCertificate.ExcludeOrder(to_date('12-09-2023', 'dd-mm-yyyy'), 	-- IDTFINALEXCLUSIONDATE
									  c.order_id, 						    -- INUORDERID 
									  12, 									-- INUCOMMENTTYPEID
									  'Se excluye por caso OSF-1546 por que corresponden al mes de Septiembre/2023'
									  );
									  
		COMMIT;
		
	
		EXCEPTION 
		WHEN others THEN    
			ROLLBACK;		
			Pkg_error.setError;
			Pkg_error.getError(onuErrorcode, OSBERRORMESSAGE);	 
			dbms_output.put_line('Error excluyendo la orden: ' || c.order_id || ' onuErrorcode: ' || onuErrorcode || ' OSBERRORMESSAGE: ' || OSBERRORMESSAGE);
		END;
		
	END LOOP;

	dbms_output.put_line('Fin OSF-1546');
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/