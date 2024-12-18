column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	CURSOR cuItemsSeriado
	IS
	SELECT  it.ID_ITEMS_SERIADO, it.SERIE
	from GE_ITEMS_SERIADO it
	WHERE serie in ( 'S-452058-20' );
	
	            
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
    
        
    PROCEDURE pUpdGE_ITEMS_SERIADO( inuIdItemsSeriado NUMBER, isbSerie VARCHAR2)
    IS
    
        CURSOR cuElMeSeSu_Acti
        IS
        SELECT *
        FROM ElMeSeSu
        WHERE emssCoEM = isbSerie
        AND emssfere > sysdate;
        
        rcElMeSeSu_Acti cuElMeSeSu_Acti%ROWTYPE;
    
        CURSOR cuGE_ITEMS_SERIADO
        IS
        SELECT es.rowid rid, rownum indice
        FROM GE_ITEMS_SERIADO es
        WHERE es.ID_ITEMS_SERIADO = inuIdItemsSeriado;
        
                
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdItems_Seriado' );
            
        
        OPEN cuElMeSeSu_Acti;
        FETCH cuElMeSeSu_Acti INTO rcElMeSeSu_Acti;
        CLOSE cuElMeSeSu_Acti;
        
        IF rcElMeSeSu_Acti.emsssesu IS NULL THEN

            tbRowIds.DELETE;
        
            FOR RG1 IN cuGE_ITEMS_SERIADO LOOP
                tbRowIds(rg1.indice) := rg1.rid;
            END LOOP;    
        
            pFOTO( 'GE_ITEMS_SERIADO', 'ID_ITEMS_SERIADO,SERIE,ID_ITEMS_ESTADO_INV,NUMERO_SERVICIO,SUBSCRIBER_ID', tbRowIds, 'ANTES', TRUE );
                    
            UPDATE GE_ITEMS_SERIADO 
            SET ID_ITEMS_ESTADO_INV = 17, -- Chatarra
                NUMERO_SERVICIO     = NULL,
                SUBSCRIBER_ID       = NULL
            WHERE ID_ITEMS_SERIADO = inuIdItemsSeriado;

            pFOTO( 'GE_ITEMS_SERIADO', 'ID_ITEMS_SERIADO,SERIE,ID_ITEMS_ESTADO_INV,NUMERO_SERVICIO,SUBSCRIBER_ID', tbRowIds, 'DESPU', FALSE );
        
        ELSE

            dbms_output.put_line('No se actualiza  ' || isbSerie || ' ya que se encuentra asociado al producto ' || rcElMeSeSu_Acti.emsssesu );        
        
        END IF;

        --dbms_output.put_line('Termina pUpdItems_Seriado' );
        
    END pUpdGE_ITEMS_SERIADO;    
    
    PROCEDURE pProcItemsSeriado( inuIdItemsSeriado NUMBER, isbSerie VARCHAR2)
    IS
    
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);
                     
    BEGIN

        --dbms_output.put_line('Inicia pProcItemsSeriado' );
                
        pUpdGE_ITEMS_SERIADO( inuIdItemsSeriado, isbSerie );

        COMMIT;
		dbms_output.put_line('Se actualizó ID_ITEM_SERIADO: ' || inuIdItemsSeriado || ' Serie ' || isbSerie );

				
        --dbms_output.put_line('Termina pProcItemsSeriado' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR ID_ITEM_SERIADO|' || inuIdItemsSeriado || '|' || osbMensError);
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT ID_ITEM_SERIADO|' ||inuIdItemsSeriado || '|' || osbMensError );    
                ROLLBACK;            
    END pProcItemsSeriado;
    
BEGIN

	FOR rgItemSeriado IN cuItemsSeriado LOOP
        
        pProcItemsSeriado ( rgItemSeriado.ID_ITEMS_SERIADO, rgItemSeriado.Serie);
		
	END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        