column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    nuSolicitud     mo_packages.package_id%TYPE;
            
    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, itbRowIds tyTbRid, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
    

        
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  'MOMENTO|' || REPLACE(isbColumnas,',','|') );
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
    
    
    PROCEDURE pUpdldc_mantenimiento_notas_di
    IS
        CURSOR cuLDC_MANTENIMIENTO_NOTAS_DIF
        IS
        SELECT ROWID RID,ROWNUM indice 
        FROM LDC_MANTENIMIENTO_NOTAS_DIF
        WHERE package_id = nuSolicitud;      
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdldc_mantenimiento_notas_di' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuLDC_MANTENIMIENTO_NOTAS_DIF LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'LDC_MANTENIMIENTO_NOTAS_DIF', 'PACKAGE_ID,CONCEPTO_ID,CUOTAS', tbRowIds, 'ANTES', TRUE );

        Update LDC_MANTENIMIENTO_NOTAS_DIF 
        set cuotas = 17 -- ANTES: 48
        where package_id = nuSolicitud;

        pFOTO( 'LDC_MANTENIMIENTO_NOTAS_DIF', 'PACKAGE_ID,CONCEPTO_ID,CUOTAS', tbRowIds, 'DESPU', FALSE );    

        --dbms_output.put_line('Termina pUpdldc_mantenimiento_notas_di' );
        
    END pUpdldc_mantenimiento_notas_di;
    
    PROCEDURE pProcSolicitud( inuSolicitud NUMBER )
    IS
    
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);
            
    
    BEGIN

        --dbms_output.put_line('Inicia pProcSolicitud' );
            
        nuSolicitud := inuSolicitud;
    
        pUpdldc_mantenimiento_notas_di;

        COMMIT;
		
        --dbms_output.put_line('Termina pProcSolicitud' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR SOLICITUD|' || inuSolicitud || '|' || osbMensError);
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT SOLICITUD|' ||nuSolicitud || '|' || osbMensError );    
                ROLLBACK;            
    END pProcSolicitud;
    
BEGIN

    pProcSolicitud ( 198803912 );

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        