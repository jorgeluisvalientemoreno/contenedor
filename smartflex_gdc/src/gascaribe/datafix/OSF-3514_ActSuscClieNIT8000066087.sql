column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    
    CURSOR cuContratos
    IS
    select sc.susccodi, sc.RowId rId, rownum Contador
    from suscripc sc
    where sc.suscclie in (1272357, 1267877, 2441348, 2511566, 364522, 936924, 546539, 323496);
    
    CURSOR cuClientes
    IS
    select sr.subscriber_id, sr.RowId rId
    from ge_subscriber sr
    where sr.subscriber_id in (1272357, 1267877, 2441348, 2511566, 364522, 936924, 546539, 323496);

    gsbProc     VARCHAR(30);

    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, irId ROWID, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
            
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  isbTabla || '|' || REPLACE(isbColumnas,',','|') );
        END IF;
                
        sbQuery := 'SELECT ' || REPLACE ( isbColumnas, ',' , ' ||' || '''' || '|' || ''''  ||  '|| '  ) || ' FROM ' || isbTabla || ' WHERE ROWID = ' || '''' || irId || '''';
    
        --DBMS_OUTPUT.PUT_LINE ( sbQuery );

        OPEN    rfcCursor FOR sbQuery;
        FETCH   rfcCursor   INTO sbRes;
        CLOSE   rfcCursor;

        sbRes := isbMomento || '|' || sbRes;

        DBMS_OUTPUT.PUT_LINE(  sbRes );

    
    END pFOTO;
    
    PROCEDURE pUpdSuscClie( iRowid ROWID )
    IS              

                       
    BEGIN

        
        gsbProc         := 'pUpdSuscClie';
        
        dbms_output.put_line('Inicia ' || gsbProc);
            
        -- Foto de los datos antes de los cambios
        pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCLIE', iRowid, 'ANTES' , FALSE);
        
        UPDATE suscripc
        SET suscclie = 298335
        WHERE ROWID = iRowid;

        -- Foto de los datos despues de los cambios
        --pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCLIE', iRowid, 'DESPU' , FALSE);
                
        dbms_output.put_line('Termina ' || gsbProc);
        
    END pUpdSuscClie;
    
    
    PROCEDURE pUpdGeSubscriber( iRowid ROWID )
    IS              

                       
    BEGIN

        
        gsbProc         := 'pUpdGeSubscriber';
        
        dbms_output.put_line('Inicia ' || gsbProc);
            
        -- Foto de los datos antes de los cambios
        pFOTO('GE_SUBSCRIBER', 'SUBSCRIBER_ID,ACTIVE,SUBS_STATUS_ID', iRowid, 'ANTES' , FALSE);
        
        UPDATE ge_subscriber
        SET ACTIVE = 'N', SUBS_STATUS_ID = 3
        WHERE ROWID = iRowid;

        -- Foto de los datos despues de los cambios
        pFOTO('GE_SUBSCRIBER', 'SUBSCRIBER_ID,ACTIVE,SUBS_STATUS_ID', iRowid, 'DESPU' , FALSE);
                
        dbms_output.put_line('Termina ' || gsbProc);
        
    END pUpdGeSubscriber;
    
    PROCEDURE pProcesaCont( irId ROWID, inuContrato NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        
        pUpdSuscClie ( irId );
        
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR ' || gsbProc || '|inuContrato|' || inuContrato || '|' || osbMensError);
            ROLLBACK;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT ' || gsbProc || '|inuContrato|' || inuContrato || '|' || osbMensError );
            ROLLBACK;
    END pProcesaCont;        

    PROCEDURE pProcesaClie( irId ROWID, inuCliente NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        
        pUpdGeSubscriber ( irId );
        
        COMMIT;
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR ' || gsbProc || '|inuCliente|' || inuCliente || '|' || osbMensError);
            ROLLBACK;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT ' || gsbProc || '|inuCliente|' || inuCliente || '|' || osbMensError );
            ROLLBACK;
    END pProcesaClie;  

begin

	dbms_output.put_line('Inicio Datafix OSF-3514');

    dbms_output.put_line('MOMENTO|SUSCRIPC|SUSCCLIE');
            
    FOR rgContratos IN cuContratos LOOP
        
        pProcesaCont( rgContratos.rId, rgContratos.susccodi );
        
        IF MOD(  rgContratos.contador, 10 ) = 0 THEN
           COMMIT;
        END IF;
     
    END LOOP;
    
    COMMIT;

    dbms_output.put_line('-----------------------------------');  
    dbms_output.put_line('MOMENTO|SUBSCRIBER_ID|ACTIVE|SUBS_STATUS_ID');  

    FOR rgClientes IN cuClientes LOOP
        
        pProcesaClie( rgClientes.rId, rgClientes.subscriber_id );
     
    END LOOP;

	dbms_output.put_line('Termina Datafix OSF-3514 ');
	
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/