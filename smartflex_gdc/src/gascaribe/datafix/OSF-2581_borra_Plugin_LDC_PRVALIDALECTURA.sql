column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    
    CURSOR cuPoblacion
    IS
    SELECT cc.ROWID Rid, ROWNUM
    FROM LDC_Procedimiento_Obj cc
    WHERE upper(procedimiento) = 'LDC_PRVALIDALECTURA';
    
    gsbProc     VARCHAR(30);

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
    
    PROCEDURE pDelLDCProcedimientoObj( irId ROWID)
    IS              
                
        
    BEGIN

   
        gsbProc         := 'pDelLDCProcedimientoObj';
        
        dbms_output.put_line('Inicia ' || gsbProc);
        
        tbRowids.DELETE;
        
        tbRowids(1) := irId;
    
        -- Foto de los datos antes de los cambios
        pFOTO('LDC_PROCEDIMIENTO_OBJ', 'TASK_TYPE_ID,CAUSAL_ID,PROCEDIMIENTO,DESCRIPCION,ORDEN_EJEC,ACTIVO', tbRowids, 'ANTES' , TRUE);
        
        -- TODO_Cambios en los datos
        FOR indRid IN 1..tbRowids.COUNT LOOP

            DELETE LDC_Procedimiento_Obj
            WHERE ROWID = tbRowids(indRid);
                        
        END LOOP;
                
        dbms_output.put_line('Termina ' || gsbProc);
        
    END;
    
    PROCEDURE pProcesaRg( irId ROWID )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        pDelLDCProcedimientoObj ( irId );
        
        --COMMIT;
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR ROWID ' || irId || '|' || osbMensError);
            ROLLBACK;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR ROWID ' || irId || '|' || osbMensError);
            ROLLBACK;
    END;        

begin
    
    FOR rgPoblacion IN cuPoblacion LOOP

        pProcesaRg( rgPoblacion.rid );
     
    END LOOP;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual
/