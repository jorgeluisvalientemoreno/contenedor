column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-1645';
	
	
	cursor cuPeriCoSe is
	select  pc.*
	from pericose PC
	WHERE PC.PECSCONS = 106632;
	
	PROCEDURE pActuPeCsProc( inuPeriodo number )
	IS
	BEGIN
	
				
        UPDATE pericose
        SET  pecsproc = 'S'
        WHERE pecscons = inuPeriodo;
        
        dbms_output.put_line( 'Ok pecsproc a S periodo  |'|| inuPeriodo );
        
        commit;
                
			  
	exception
		when others then
			dbms_output.put_line( 'ERROR:  inuPeriodo|' || inuPeriodo || '|' || SQLERRM );
			rollback;	

	END pActuPeCsProc;

BEGIN

	FOR reg IN cuPeriCoSe LOOP
		pActuPeCsProc( reg.PECSCONS);
	END LOOP;
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

