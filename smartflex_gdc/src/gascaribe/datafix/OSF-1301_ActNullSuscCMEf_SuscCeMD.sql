column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare    
    
    CURSOR cuPoblacion
    IS
    select      s.*
    from        open.SUSCRIPC s
    inner join  open.SERVSUSC serv
    on          s.SUSCCODI = serv.SESUSUSC
    where       (s.SUSCCEMF is not null OR s.SUSCCEMD is not null)
    and         serv.SESUCATE in (1,2)
    and         serv.SESUSERV = 7014;
    
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
    
    PROCEDURE pUpdSUSCCEMF_SUSCCEMD( inuContrato NUMBER )
    IS              
        CURSOR cuSUSCCEMF_SUSCCEMD
        IS
        SELECT sc.ROWID Rid, ROWNUM
        FROM suscripc sc
        WHERE sc.susccodi = inuContrato
        AND 
        (
            sc.SUSCCEMF IS NOT NULL 
            OR
            sc.SUSCCEMD IS NOT NULL
        );
        
        sbCaso  VARCHAR2(50) := 'OSF-1301';
        
        CURSOR cuSusc ( irRid ROWID )
        IS
        SELECT SUSCCODI, SUSCCEMF,SUSCCEMD
        FROM suscripc
        WHERE ROWID = irRid;
        
    BEGIN

        
        gsbProc         := 'pUpdSUSCCEMF_SUSCCEMD';
        
        --dbms_output.put_line('Inicia ' || gsbProc);
        
        FOR rgSusc IN cuSUSCCEMF_SUSCCEMD LOOP
            tbRowids(rgSusc.rownum) := rgSusc.Rid;
        END LOOP;
    
        IF gnuContador = 0 THEN
            -- Foto de los datos antes de los cambios con encabezado
            pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCEMF,SUSCCEMD', tbRowids, 'ANTES' , TRUE);
        ELSE
            -- Foto de los datos antes de los cambios sin encabezado
            pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCEMF,SUSCCEMD', tbRowids, 'ANTES' , FALSE);        
        END IF;
        
        -- TODO_Cambios en los datos
        FOR indRid IN 1..tbRowids.COUNT LOOP
                
            UPDATE suscripc
            SET SUSCCEMF = NULL,
            SUSCCEMD = NULL
            WHERE ROWID = tbRowids(indRid);                    
        
        END LOOP;
        
        gnuContador := gnuContador + 1;

        -- Foto de los datos despues de los cambios
        --pFOTO('SUSCRIPC', 'SUSCCODI,SUSCCEMF,SUSCCEMD', tbRowids, 'DESPU' , FALSE);
                
        --dbms_output.put_line('Termina ' || gsbProc);
        
    END;
    
    PROCEDURE pProcesaRg( inuContrato NUMBER )
    IS
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);    
    BEGIN 
    
        pUpdSUSCCEMF_SUSCCEMD ( inuContrato );
        
        COMMIT;
    
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

        pProcesaRg( rgPoblacion.susccodi );
     
    END LOOP;
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/