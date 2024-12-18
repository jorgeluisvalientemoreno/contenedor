column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare    
    
    CURSOR cuPoblacion
    IS
    select      ss.rowid rid, ss.sesucicl newCiCo
    from        open.SERVSUSC ss, open.SUSCRIPC sc
    where       ss.sesuesco IN  ( 99,111,112)
    AND ss.sesucico <> ss.sesucicl
    AND sc.susccodi = ss.sesususc
    AND ss.sesucicl = sc.susccicl
    ;
        
    gsbProc     VARCHAR(30);

    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    gnuContador NUMBER := 0;
    
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
    
    PROCEDURE pUpdSESUCICO( iRid ROWID, inuNewCiCo NUMBER )
    IS              
            
        sbCaso  VARCHAR2(50) := 'OSF-1444';
        
    BEGIN

        
        gsbProc         := 'pUpdSESUCICO';
        
        --dbms_output.put_line('Inicia ' || gsbProc);
        tbRowids.delete;
        
        tbRowids(1) := iRid;
    
        IF gnuContador = 0 THEN
            -- Foto de los datos antes de los cambios con encabezado
            pFOTO('SERVSUSC', 'SESUNUSE,SESUCICO,SESUCICL,SESUESCO', tbRowids, 'ANTES' , TRUE);
        ELSE
            -- Foto de los datos antes de los cambios sin encabezado
            pFOTO('SERVSUSC', 'SESUNUSE,SESUCICO,SESUCICL,SESUESCO', tbRowids, 'ANTES' , FALSE);        
        END IF;
        
        -- TODO_Cambios en los datos
        FOR indRid IN 1..tbRowids.COUNT LOOP
                
            UPDATE SERVSUSC
            SET SESUCICO = inuNewCiCo
            WHERE ROWID = tbRowids(indRid);                    
        
        END LOOP;
        
        gnuContador := gnuContador + 1;

        -- Foto de los datos despues de los cambios
        pFOTO('SERVSUSC', 'SESUNUSE,SESUCICO,SESUCICL,SESUESCO', tbRowids, 'DESPU' , FALSE);    
                
        --dbms_output.put_line('Termina ' || gsbProc);
        
    END;
    
    PROCEDURE pProcesaRg( iRid ROWID, inuNewCiCo NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        pUpdSESUCICO ( iRid, inuNewCiCo );
        
        COMMIT;
    
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR ' || gsbProc || '|RowId|' || iRid || '|' || osbMensError);
            ROLLBACK;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT ' || gsbProc || '|RowId|' || iRid || '|' || osbMensError );
            ROLLBACK;
    END pProcesaRg;        

begin
    
    FOR rgPoblacion IN cuPoblacion LOOP

        pProcesaRg( rgPoblacion.rid, rgPoblacion.NewCiCo );
     
    END LOOP;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/