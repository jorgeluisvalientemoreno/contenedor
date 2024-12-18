column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	CURSOR cuMO_WF_PACK_INTERFAC
	IS
    select rowid rId
    from MO_WF_PACK_INTERFAC
    where package_id = 184014323
    and attendance_date is null
    and causal_id_output = 500
    and status_activity_id = 2
    and action_id = 157;
		            
    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, itbRowIds tyTbRid, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
    
        
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  isbTabla || '|' || REPLACE(isbColumnas,',','|') );
        END IF;
        
        FOR indRowIds IN 1..itbRowIds.COUNT LOOP
        
            sbQuery := 'SELECT ' || REPLACE ( isbColumnas, ',' , ' ||' || '''' || '|' || ''''  ||  '|| '  ) || ' FROM ' || isbTabla || ' WHERE ROWID = ' || '''' || itbRowIds(indRowIds) || '''';
        
            --DBMS_OUTPUT.PUT_LINE ( sbQuery );

            OPEN    rfcCursor FOR sbQuery;
            FETCH   rfcCursor   INTO sbRes;
            CLOSE   rfcCursor;


            sbRes := isbMomento || '|' || sbRes;

            DBMS_OUTPUT.PUT_LINE(  sbRes );
        
        END LOOP;
    
    END pFOTO; 
    
        
    PROCEDURE pUpdMO_WF_PACK_INTERFAC( irId ROWID )
    IS
                    
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdItems_Seriado' );
                            
        IF irId IS NOT NULL THEN

            tbRowIds.DELETE;
        
            tbRowIds(1) := irId;
        
            pFOTO( 'MO_WF_PACK_INTERFAC', 'WF_PACK_INTERFAC_ID,PACKAGE_ID,STATUS_ACTIVITY_ID,CAUSAL_ID_OUTPUT,ACTION_ID', tbRowIds, 'ANTES', TRUE );
                    
            UPDATE MO_WF_PACK_INTERFAC 
            SET STATUS_ACTIVITY_ID = 4 -- Para reenvio manual
            WHERE ROWID  = irId;

            pFOTO( 'MO_WF_PACK_INTERFAC', 'WF_PACK_INTERFAC_ID,PACKAGE_ID,STATUS_ACTIVITY_ID,CAUSAL_ID_OUTPUT,ACTION_ID', tbRowIds, 'DESPU', FALSE );
        
        ELSE

            dbms_output.put_line('No se actualiza MO_WF_PACK_INTERFAC ya que no hay registro para procesar');        
        
        END IF;

        --dbms_output.put_line('Termina pUpdItems_Seriado' );
        
    END pUpdMO_WF_PACK_INTERFAC;    
    
    PROCEDURE pProcMO_WF_PACK_INTERFAC( irId ROWID)
    IS
    
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);
                     
    BEGIN

        --dbms_output.put_line('Inicia pProcMO_WF_PACK_INTERFAC' );
                
        pUpdMO_WF_PACK_INTERFAC( irId );

        COMMIT;
		dbms_output.put_line('Se actualizo MO_WF_PACK_INTERFAC rowid: ' || irId  );

				
        --dbms_output.put_line('Termina pProcMO_WF_PACK_INTERFAC' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR MO_WF_PACK_INTERFAC rowid: ' || irId || '|' || osbMensError);
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT MO_WF_PACK_INTERFAC rowid: ' ||irId || '|' || osbMensError );    
                ROLLBACK;            
    END pProcMO_WF_PACK_INTERFAC;
    
BEGIN

	FOR rgMO_WF_PACK_INTERFAC IN cuMO_WF_PACK_INTERFAC LOOP
        
        pProcMO_WF_PACK_INTERFAC ( rgMO_WF_PACK_INTERFAC.rId);
		
	END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        