column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    sbCaso      VARCHAR2(50) := 'OSF-1944';

    CURSOR cuDatos
    IS
    select vf.*, vf.rowid rid
    from cm_vavafaco vf  
    where vvfcubge in (8907 ,8910) 
    and vvfcfeiv >= TO_DATE( '01/11/2023', 'dd/mm/yyyy')
    and vvfcfeiv > vvfcfefv;
    
    dtVVFCFEFV date := TO_DATE( '31/12/4732', 'dd/mm/yyyy');

    TYPE tytbDatos IS TABLE OF cuDatos%ROWTYPE INDEX BY BINARY_INTEGER;
    
    tbDatos tytbDatos;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, itbDatos tytbDatos, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
    
        
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  isbTabla || '|' || REPLACE(isbColumnas,',','|') );
        END IF;
        
        FOR indRowIds IN 1..itbDatos.COUNT LOOP
        
            sbQuery := 'SELECT ' || REPLACE ( isbColumnas, ',' , ' ||' || '''' || '|' || ''''  ||  '|| '  ) || ' FROM ' || isbTabla || ' WHERE ROWID = ' || '''' || itbDatos(indRowIds).Rid || '''';
        
            --DBMS_OUTPUT.PUT_LINE ( sbQuery );

            OPEN    rfcCursor FOR sbQuery;
            FETCH   rfcCursor   INTO sbRes;
            CLOSE   rfcCursor;


            sbRes := isbMomento || '|' || sbRes;

            DBMS_OUTPUT.PUT_LINE(  sbRes );
        
        END LOOP;
    
    END pFOTO;
	
BEGIN

	dbms_output.put_line( 'Inicia dataFix ' || sbCaso );
	
	OPEN cuDatos;
	FETCH cuDatos BULK COLLECT INTO tbDatos;
    CLOSE cuDatos;
    
	dbms_output.put_line( 'Va a procesar ' || tbDatos.Count || ' registros' ); 
	
	IF tbDatos.Count > 0 THEN
	
        pFOTO ( 'CM_VAVAFACO', 'VVFCCONS,VVFCVAFC,VVFCFEFV', tbDatos, 'ANTES', TRUE );
        
        FOR indtbDato IN 1..tbDatos.Count LOOP

            UPDATE cm_vavafaco
            SET VVFCFEFV = dtVVFCFEFV
            WHERE rowid = tbDatos(indtbDato).Rid;
        
        END LOOP;

        pFOTO ( 'CM_VAVAFACO', 'VVFCCONS,VVFCVAFC,VVFCFEFV', tbDatos, 'DESP', FALSE );
        
        COMMIT;
	
    END IF;
    
	dbms_output.put_line( 'Termina dataFix ' || sbCaso );
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        