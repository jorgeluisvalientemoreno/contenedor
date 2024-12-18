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
		WHERE 	order_id IN (279079888,279924141,272595254,272595389,279079854,288777134,289255073,272595290,289255075,272595243,290311762,
							295670306,289745785,288779107,272593305,288777128,272595416,289745786,295631554,290533912,292241332,289745652,
							289745720,295631563,288777131,288779106,289745722,288781126,295631562,289745653,289745658,288777127,295631616,
							292245005,293904026,292241331,280674201,288779108,288781117,289745650,292241325,293904031,288777129,288779110,
							290655360,290311760,288779103,292241328,293904038,295631558,192198181,274214708,293906343,293904028,293906362,
							290410134,295655941,293905673,288781127,296760262,288777126,293901318,296760263,296760317,289745657,192198179,
							289255074,192198174,293904029,192198182,293901194,295631556,288777124,192198177,279922752,192198176,288777125,
							296760265,295631561,293904033,288777130,288782323,288781118,295670317,296760269,292242763,292241326,292241330,
							192198175,295631557,296760318,192198180,293901188,192198185,295670334,192198178,192198183,289254424,296760261,
							296761701,293904032,272595399,192198184,295683998,295688833,296761601,296762193,297261544,297261624);

BEGIN
	dbms_output.put_line('Inicia OSF-1624');
  
	BEGIN
  
		FOR reg IN cuOrder LOOP
		
			dbms_output.put_line('Anulando la orden: '||reg.order_id);
		
			or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
		
			api_addordercomment(reg.order_id, nuTipoComentario, 'Se anula por solicitud en el caso SOSF-1964', nuCodigoError, sbMensajeError);
			
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
	
	dbms_output.put_line('Termina OSF-1624');

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/