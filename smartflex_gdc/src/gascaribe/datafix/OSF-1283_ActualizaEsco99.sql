column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    
    CURSOR cuPoblacion
    IS
    select  distinct sesususc, sesunuse, sesuserv
    from servsusc ss1,
    suscripc sc
    where ss1.sesuesco = 111
    and sc.susccodi = ss1.sesususc
    and sc.susctisu = -1 
    and exists
    (
        select *
        from servsusc ss2
        where ss2.sesususc = ss1.sesususc 
        and ss2.sesuesco = 99
    )
    and ss1.sesuserv <> ( 7053 );
    
    gsbCaso  VARCHAR2(50) := 'OSF-1283';
            
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
        
 
        FOR indRid IN 1..itbRowIds.COUNT LOOP
                        
            sbQuery := 'SELECT ' || REPLACE ( isbColumnas, ',' , ' ||' || '''' || '|' || ''''  ||  '|| '  ) || ' FROM ' || isbTabla || ' WHERE ROWID = ' || '''' || itbRowIds(indRid) || '''';
        
            --DBMS_OUTPUT.PUT_LINE ( sbQuery );

            OPEN    rfcCursor FOR sbQuery;
            FETCH   rfcCursor   INTO sbRes;
            CLOSE   rfcCursor;

            sbRes := isbMomento || '|' || sbRes;

            DBMS_OUTPUT.PUT_LINE(  sbRes );
                   
        END LOOP;
    
    END pFOTO;
    
    PROCEDURE pUpdSeSuEsCo( inuContrato NUMBER )
    IS              
        CURSOR cuServSusc
        IS
        select  ss1.rowid rid, rownum
        from servsusc ss1,
        suscripc sc
        where ss1.sesuesco = 111
        and sc.susccodi = ss1.sesususc
        and sc.susctisu = -1 
        and sc.susccodi = inuContrato
        and exists
        (
            select *
            from servsusc ss2
            where ss2.sesususc = ss1.sesususc 
            and ss2.sesuesco = 99
        )
        and ss1.sesuserv <> ( 7053 );
                        
                
    BEGIN

        pkErrors.SetApplication('GCNED');
        
        gsbProc         := 'pUpdSeSuEsCo';
        
        dbms_output.put_line('Inicia ' || gsbProc);
        
        tbRowids.delete;
        
        FOR rgSeSu IN cuServSusc LOOP
            tbRowids(rgSeSu.rownum) := rgSeSu.Rid;
        END LOOP;
    
        -- Foto de los datos antes de los cambios
        pFOTO('SERVSUSC', 'SESUSUSC,SESUNUSE,SESUESCO', tbRowids, 'ANTES' , TRUE);
        
        -- TODO_Cambios en los datos

        FOR indRid IN 1..tbRowids.COUNT LOOP
            
            UPDATE servsusc
            SET sesuesco = 99
            WHERE rowid = tbRowids(indRid);
            
            COMMIT;
                                                
        END LOOP;

        -- Foto de los datos despues de los cambios
        pFOTO('SERVSUSC', 'SESUSUSC,SESUNUSE,SESUESCO', tbRowids, 'DESPU' , FALSE);
                
        dbms_output.put_line('Termina ' || gsbProc);
        
    END;
    
    PROCEDURE pProcesaRg( inuContrato NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        pUpdSeSuEsCo ( inuContrato );

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
    END;        

begin
    
    FOR rgPoblacion IN cuPoblacion LOOP

        pProcesaRg( rgPoblacion.sesususc );
     
    END LOOP;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/