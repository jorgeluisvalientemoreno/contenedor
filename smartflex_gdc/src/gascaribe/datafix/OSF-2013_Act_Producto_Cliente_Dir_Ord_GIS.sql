column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE


	CURSOR cuOrdenes
	IS
	SELECT oa.order_id, 
			case 
				when oa.order_id = 303983258 then  
					50094765 
			end ProdOk, 
			oa.package_id Soli,
			pk.package_type_id TiSo
	from or_order_ACTIVITY oa,
	mo_packages pk
	WHERE oa.ORDER_ID IN ( 303983258 )
	AND pk.package_id(+) = oa.package_id;
	
	CURSOR cuDatosOk( inuProdOk NUMBER)
	IS
	SELECT sc.susccodi ContOk, sc.suscclie ClieOk, sr.subscriber_name NombOk, pr.address_id DireOk
    FROM servsusc ss, 
         suscripc sc,
         ge_subscriber sr,
		 pr_product pr
	WHERE ss.sesunuse = inuProdOk
	AND sc.susccodi = ss.sesususc
	AND sr.subscriber_id = sc.suscclie
	AND pr.product_id = ss.sesunuse;
	            
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
    
    
    PROCEDURE pUpdOr_Order( inuOrden NUMBER, inuDireOk NUMBER)
    IS

        CURSOR cuOR_ORDER
        IS
        SELECT od.rowid rid, rownum indice
        FROM OR_ORDER od
        WHERE od.order_id = inuOrden;
		
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOr_Order_Activity' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'OR_ORDER', 'ORDER_ID,EXTERNAL_ADDRESS_ID', tbRowIds, 'ANTES', TRUE );
				
        UPDATE OR_ORDER
        SET external_address_id 		= inuDireOk
        WHERE order_id = inuOrden;

        pFOTO( 'OR_ORDER', 'ORDER_ID,EXTERNAL_ADDRESS_ID', tbRowIds, 'DESPU', FALSE );

        --dbms_output.put_line('Termina pUpdOr_Order_Activity' );
        
    END pUpdOr_Order;    
    
    PROCEDURE pUpdOr_Order_Activity( inuOrden NUMBER, inuProdOk NUMBER, inuClieOK NUMBER, inuDireOk NUMBER)
    IS

        CURSOR cuOR_ORDER_ACTIVITY
        IS
        SELECT oa.rowid rid, rownum indice
        FROM OR_ORDER_ACTIVITY oa
        WHERE oa.order_id = inuOrden;
		
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOr_Order_Activity' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_ORDER_ACTIVITY LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'OR_ORDER_ACTIVITY', 'ORDER_ACTIVITY_ID,ORDER_ID,PRODUCT_ID,SUBSCRIBER_ID,ADDRESS_ID', tbRowIds, 'ANTES', TRUE );
				
        UPDATE OR_ORDER_ACTIVITY 
        SET product_id 		= inuProdOk,
			subscriber_id 	= inuClieOK,
		    address_id      = inuDireOk
        WHERE order_id = inuOrden;

        pFOTO( 'OR_ORDER_ACTIVITY', 'ORDER_ACTIVITY_ID,ORDER_ID,PRODUCT_ID,SUBSCRIBER_ID,ADDRESS_ID', tbRowIds, 'DESPU', FALSE );

        --dbms_output.put_line('Termina pUpdOr_Order_Activity' );
        
    END pUpdOr_Order_Activity;
    
    PROCEDURE pUpdOr_Extern_Systems_Id( inuOrden NUMBER, inuProdOk NUMBER, inuContOk NUMBER, inuClieOk NUMBER, isbNombOK VARCHAR2, inuSoli NUMBER, inuTiSo NUMBER, inuDire NUMBER)
    IS
        CURSOR cuOR_EXTERN_SYSTEMS_ID
        IS
        SELECT es.rowid rid, rownum indice
        FROM OR_EXTERN_SYSTEMS_ID es
        WHERE es.order_id = inuOrden;
        
    BEGIN
    
        --dbms_output.put_line('Inicia pUpdOr_Order_Activity' );
            
        tbRowIds.DELETE;

        FOR RG1 IN cuOR_EXTERN_SYSTEMS_ID LOOP
            tbRowIds(rg1.indice) := rg1.rid;
        END LOOP;    
    
        pFOTO( 'OR_EXTERN_SYSTEMS_ID', 'ORDER_ID,PRODUCT_ID,SUBSCRIPTION_ID,SUBSCRIBER_ID,SUBSCRIBER_NAME,PACKAGE_ID,PACKAGE_TYPE_ID,ADDRESS_ID', tbRowIds, 'ANTES', TRUE );
				
        UPDATE OR_EXTERN_SYSTEMS_ID 
        SET product_id 		= inuProdOk,
            subscription_id = inuContOk,
			subscriber_id 	= inuClieOK,
			subscriber_name = isbNombOK,
			package_id      = inuSoli,
			address_id  	= inuDire
        WHERE order_id = inuOrden;

        pFOTO( 'OR_EXTERN_SYSTEMS_ID', 'ORDER_ID,PRODUCT_ID,SUBSCRIPTION_ID,SUBSCRIBER_ID,SUBSCRIBER_NAME,PACKAGE_ID,PACKAGE_TYPE_ID,ADDRESS_ID', tbRowIds, 'DESPU', FALSE );

        --dbms_output.put_line('Termina pUpdOr_Order_Activity' );
        
    END pUpdOr_Extern_Systems_Id;    
    
    PROCEDURE pProcOrdenes( inuOrden NUMBER, inuProdOk NUMBER, inuContOk NUMBER, inuClieOk NUMBER, isbNombOk VARCHAR2, inuSoli NUMBER, inuTiSo NUMBER, inuDire NUMBER)
    IS
    
        onuCodError     NUMBER;
        osbMensError    VARCHAR2(4000);
		
		isbOrderComme varchar2(4000) := 'Se actauliza el producto y el cliente por OSF-2013';
		nuCommentType number := 1277;
             
    BEGIN

        --dbms_output.put_line('Inicia pProcOrdenes' );
        
        pUpdOr_Order(inuOrden, inuDire);
                
        pUpdOr_Order_Activity( inuOrden, inuProdOk, inuClieOk, inuDire);

        pUpdOr_Extern_Systems_Id( inuOrden, inuProdOk, inuContOk, inuClieOk, isbNombOk, inuSoli, inuTiSo, inuDire);
		
		OS_ADDORDERCOMMENT(  inuOrden,
							 nuCommentType,
							 isbOrderComme,
							 onuCodError,
							 osbMensError);
							 
		if onuCodError = 0 then
			COMMIT;
			dbms_output.put_line('Se actualizó orden: ' || inuOrden);
		else
			ROLLBACK;
			dbms_output.put_line('Error actualizando orden: ' || inuOrden ||
								 ' : ' || osbMensError);
		end IF;		
				
        --dbms_output.put_line('Termina pProcOrdenes' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR ORDEN|' || inuOrden || '|' || osbMensError);
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT ORDEN|' ||inuOrden || '|' || osbMensError );    
                ROLLBACK;            
    END pProcOrdenes;
    
BEGIN

	FOR rgOrd IN cuOrdenes LOOP

        FOR rgDatosOk IN cuDatosOk( rgOrd.ProdOk ) LOOP
        
            pProcOrdenes ( rgOrd.order_id, rgOrd.ProdOk,  rgDatosOk.ContOk, rgDatosOk.ClieOk, rgDatosOk.NombOk, rgOrd.Soli, rgOrd.TiSo, rgDatosOk.DireOk );
		
		END LOOP;
		
	END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/

        