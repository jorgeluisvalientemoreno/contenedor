column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuerror NUMBER;
    sberror VARCHAR2(4000);
	nuCommentType or_order_comment.comment_type_id%type := 1277;

	CURSOR cuOrder IS
		select order_id 
		from open.or_order 
		where order_id in (160025447, 156682047, 151639249, 160033941,
						   170770961);

begin
  dbms_output.put_line('Inicia OSF-1279');
  
  BEGIN
  
  FOR reg IN cuOrder LOOP
	
	dbms_output.put_line('Anulando la orden: ' || reg.order_id);
	
	or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
	
	OS_ADDORDERCOMMENT(reg.order_id,
                       nuCommentType,
                       'Se anula por solicitud en el caso OSF-1279',
                       nuerror,
                       sberror);
	
	commit;
     
  END LOOP;
  
  EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuerror, sberror);
    DBMS_OUTPUT.PUT_LINE(sberror);
  END;
  
  dbms_output.put_line('Termina OSF-1279');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/