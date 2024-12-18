column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuCodigoError 		NUMBER;
    sbMensajeError 		VARCHAR2(4000);
	nuTipoComentario 	or_order_comment.comment_type_id%TYPE := 1277;

	CURSOR cuOrder IS
		SELECT 	order_id 
		FROM 	open.or_order 
		WHERE 	order_id IN (168135597, 179903942, 289990508);

BEGIN
	dbms_output.put_line('Inicia OSF-1598');
  
	BEGIN
  
		FOR reg IN cuOrder LOOP
		
			dbms_output.put_line('Anulando la orden: '||reg.order_id);
		
			or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
		
			api_addordercomment(reg.order_id, nuTipoComentario, 'Se anula por solicitud en el caso SOSF-1952', nuCodigoError, sbMensajeError);
			
			IF (nuCodigoError <> 0) THEN
				dbms_output.put_line(sbMensajeError);
			END IF;
		
			COMMIT;
		 
		END LOOP;
		
	EXCEPTION
		WHEN OTHERS THEN
			Pkg_error.seterror;
			Pkg_error.geterror(nuCodigoError, sbMensajeError);
			dbms_output.put_line(sbMensajeError);
	END;
	
	dbms_output.put_line('Termina OSF-1598');

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/