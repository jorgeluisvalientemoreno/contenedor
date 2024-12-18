column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    orId    ROWID;
	
	CURSOR cuEsPr
	IS
	SELECT ep.rowid rid, ep.*
	FROM estaprog ep
	WHERE esprpefa = 113635 
	AND esprprog like 'FGCC%';
	
	sbLineaO	VARCHAR2(32000);
	
begin
    
    sbLineaO := 'EsPrProg' || '|' ||  
                'EsPrPorc' || '|' || 
                'EsPrMesg' || '|' ||
                'EsPrFeIN' || '|' || 
                'EsPrFeFi' || '|' || 
                'EsPrTaPr' || '|' || 
                'EsPrSuPr' || '|' ||
                'Observacion';

    DBMS_output.put_line( sbLineaO );
	
	FOR rgEsPr IN cuEsPr LOOP
	
		sbLineaO := rgEsPr.EsPrProg || '|' ||  
					rgEsPr.EsPrPorc || '|' || 
					rgEsPr.EsPrMesg || '|' ||
					rgEsPr.EsPrFeIN || '|' || 
					rgEsPr.EsPrFeFi || '|' || 
					rgEsPr.EsPrTaPr || '|' || 
					rgEsPr.EsPrSuPr || '|';
					
		DELETE estaprog WHERE rowid = rgEsPr.rId;
		
		sbLineaO := sbLineaO || 'Borrado Ok';

		DBMS_output.put_line( sbLineaO );
		
		COMMIT;
		
	END LOOP;

    COMMIT;        
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line( sbLineaO || 'Error[' || sqlerrm || ']');
            ROLLBACK;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/