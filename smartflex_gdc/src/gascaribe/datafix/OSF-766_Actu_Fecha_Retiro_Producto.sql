column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
	sbCaso  VARCHAR2(20) := 'OSF-766';
    	
    PROCEDURE pActuFechaRetiroServSusc
    IS              
		CURSOR cuServSusc
		IS
		SELECT  ss.sesuesco, ss.sesunuse, ss.sesufere, ss.ROWID RId
		FROM
		servsusc ss
		WHERE
			sesususc = 67089430
		AND	sesuserv = 7014
		AND sesufere < SYSDATE;
		
		sbFechaMaxima	VARCHAR2(20) := '31/12/4732';
		sbFormatoFecha	VARCHAR2(20) := 'dd/mm/yyyy';
		dtFechaMaxima	DATE := TO_DATE( sbFechaMaxima,sbFormatoFecha);
		
    BEGIN
    
		FOR rgSS IN cuServSusc LOOP
		
			BEGIN
			
				dbms_output.put_line( 'ANTES ACTUALIZACION SS[' || rgSS.sesunuse || ']FECHA_RETIRO[' || TO_CHAR( rgSS.SeSuFeRe, sbFormatoFecha ) || ']' );
				
				UPDATE servsusc
				SET sesufere = dtFechaMaxima
				WHERE ROWID = rgSS.RId;
			
				COMMIT;
				
				dbms_output.put_line( 'DESPUES ACTUALIZACION SS[' || rgSS.sesunuse || ']FECHA_RETIRO[' || sbFechaMaxima || ']' ); 
				
				EXCEPTION 
					WHEN OTHERS THEN
						dbms_output.put_line( 'ERROR ACTUALIZACION SS[' || rgSS.sesunuse || '][' || SQLERRM || ']' );
						ROLLBACK;			
			END;
		
		END LOOP;		
        
    END pActuFechaRetiroServSusc;
begin
	pActuFechaRetiroServSusc;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/