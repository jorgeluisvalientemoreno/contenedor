column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    nuOrden     or_order.order_id%TYPE;
            
    TYPE tyTbRid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
    
    tbRowIds tyTbRid;
    
    PROCEDURE pFOTO(isbTabla VARCHAR2, isbColumnas VARCHAR2, itbRowIds tyTbRid, isbMomento VARCHAR2, iblImpHeader BOOLEAN DEFAULT FALSE) IS      
        sbQuery         VARCHAR2(32767);        
        sbRes           VARCHAR2(32767);
        rfcCursor       SYS_REFCURSOR;
        
    BEGIN
    

        
        IF iblImpHeader THEN
            DBMS_OUTPUT.PUT_LINE(  REPLACE(isbColumnas,',','|') );
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
    
    PROCEDURE pDelOrderPerson
    IS
        CURSOR cuOR_ORDER_PERSON
        IS
        SELECT ROWID rid, ROWNUM indice
        FROM OR_ORDER_PERSON
        WHERE order_id = nuOrden;
               
    BEGIN
   
        --dbms_output.put_line('Inicia pDelOrderPerson' );
        
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER_PERSON LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;
        
        pFOTO( 'OR_ORDER_PERSON', 'ORDER_ID,OPERATING_UNIT_ID,PERSON_ID', tbRowIds, 'ANTES', TRUE );
        
        DELETE FROM OR_ORDER_PERSON
        WHERE order_id = nuOrden;

        pFOTO( 'OR_ORDER_PERSON', 'ORDER_ID,OPERATING_UNIT_ID,PERSON_ID', tbRowIds, 'DESPU', FALSE );

        --dbms_output.put_line('Termina pDelOrderPerson' );
                
    END pDelOrderPerson; 
    
    PROCEDURE pUpdOrderItems
    IS   
        CURSOR cuOR_ORDER_ITEMS
        IS
        SELECT ROWID RID,ROWNUM indice 
        FROM OR_ORDER_ITEMS
        WHERE order_id = nuOrden;    
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOrderItems' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER_ITEMS LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;

        pFOTO( 'OR_ORDER_ITEMS', 'ORDER_ID,ORDER_ITEMS_ID,LEGAL_ITEM_AMOUNT', tbRowIds, 'ANTES', TRUE );

        UPDATE OR_ORDER_ITEMS
        SET legal_item_amount = -1
        WHERE order_id = nuOrden;

        pFOTO( 'OR_ORDER_ITEMS', 'ORDER_ID,ORDER_ITEMS_ID,LEGAL_ITEM_AMOUNT', tbRowIds, 'DESPU', FALSE );      

        --dbms_output.put_line('Termina pUpdOrderItems' );

    END pUpdOrderItems;
    
    PROCEDURE pUpdOrderActivity
    IS
        CURSOR cuOR_ORDER_ACTIVITY
        IS
        SELECT ROWID RID,ROWNUM indice 
        FROM OR_ORDER_ACTIVITY
        WHERE order_id = nuOrden;  
            
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOrderActivity' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER_ACTIVITY LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'OR_ORDER_ACTIVITY', 'ORDER_ID,ORDER_ACTIVITY_ID,STATUS,COMMENT_,VALUE1', tbRowIds, 'ANTES', TRUE );

        UPDATE OR_ORDER_ACTIVITY 
        SET STATUS = 'R', -- ANTES: F
        VALUE1 = NULL -- ANTES: LECTURA>000>>9> 
        WHERE order_id = nuOrden;

        pFOTO( 'OR_ORDER_ACTIVITY', 'ORDER_ID,ORDER_ACTIVITY_ID,STATUS,COMMENT_,VALUE1', tbRowIds, 'DESPU', FALSE );    

        --dbms_output.put_line('Termina pUpdOrderActivity' );
        
    END pUpdOrderActivity;
    
    PROCEDURE pUpdOrder
    IS
        CURSOR cuOR_ORDER_ACTIVITY
        IS
        SELECT ROWID RID,ROWNUM indice 
        FROM OR_ORDER
        WHERE order_id = nuOrden;      
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOrder' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER_ACTIVITY LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'OR_ORDER', 'ORDER_ID,CAUSAL_ID', tbRowIds, 'ANTES', TRUE );

        Update or_order 
        set causal_id= null -- ANTES: 9791 - SERVICIO SUSPENDIDO ACOMETIDA
        where order_id = nuOrden;

        pFOTO( 'OR_ORDER', 'ORDER_ID,CAUSAL_ID', tbRowIds, 'DESPU', FALSE );    

        --dbms_output.put_line('Termina pUpdOrder' );
        
    END pUpdOrder;
    
    PROCEDURE pProcOrden( inuOrden NUMBER )
    IS
    
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);
            
    
    BEGIN

        --dbms_output.put_line('Inicia pProcOrden' );
            
        nuOrden := inuOrden;
    
        pDelOrderPerson;
        
        pUpdOrderItems;

        pUpdOrderActivity;

        pUpdOrder;

        COMMIT;

        --dbms_output.put_line('Termina pProcOrden' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR ORDEN|' || inuOrden || '|' || osbMensError);
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT ORDEN|' ||nuOrden || '|' || osbMensError );    
                ROLLBACK;            
    END pProcOrden;
    
BEGIN

    pProcOrden ( 277564633 );

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        