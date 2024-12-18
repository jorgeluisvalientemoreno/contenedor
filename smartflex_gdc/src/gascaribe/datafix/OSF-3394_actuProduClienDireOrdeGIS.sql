set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-3394');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25;
DEFINE CASO=OSF-3394

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

DECLARE

    nuTotal     NUMBER;
    nuOK        NUMBER;
    nuErr       NUMBER;

    -- Cursor con la relacion de la order y el producto (WHEN order_id THEN product_id)
	CURSOR cuOrdenes
	IS
        SELECT 
             oa.order_id        as order_id,
             CASE
                WHEN oa.order_id = 337033658 THEN 52597720
             END                as ProdOk,
             oa.package_id      as Soli,
             pk.package_type_id as TiSo
        FROM open.or_order_ACTIVITY oa,
             open.mo_packages pk
        WHERE oa.order_id IN (337033658)
          AND pk.package_id(+) = oa.package_id;

	CURSOR cuDatosOk( inuProdOk NUMBER)
	IS
        SELECT sc.susccodi        as ContOk, 
               sc.suscclie        as ClieOk, 
               sr.subscriber_name as NombOk, 
               pr.address_id      as DireOk
        FROM open.servsusc ss,
             open.suscripc sc,
             open.ge_subscriber sr,
             open.pr_product pr
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

            OPEN  rfcCursor FOR sbQuery;
            FETCH rfcCursor INTO sbRes;
            CLOSE rfcCursor;

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

        -- Actualiza or_order
        UPDATE or_order
        SET external_address_id = inuDireOk
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

        -- Actualiza or_order_activity
        UPDATE or_order_activity
        SET product_id 	  = inuProdOk,
			subscriber_id = inuClieOK,
		    address_id    = inuDireOk
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

        -- Actualiza or_extern_systems_id
        UPDATE or_extern_systems_id
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

		isbOrderComme varchar2(4000) := 'Se actualiza producto, cliente y direccion por OSF-3394';
		nuCommentType number := 1277;

    BEGIN

        --dbms_output.put_line('Inicia pProcOrdenes' );

        pUpdOr_Order(inuOrden, inuDire);

        pUpdOr_Order_Activity( inuOrden, inuProdOk, inuClieOk, inuDire);

        pUpdOr_Extern_Systems_Id( inuOrden, inuProdOk, inuContOk, inuClieOk, isbNombOk, inuSoli, inuTiSo, inuDire);

        -- Adiciona el comentario a la orden
        API_ADDORDERCOMMENT
        (  
            inuOrden,
            nuCommentType,
            isbOrderComme,
            onuCodError,
            osbMensError
        );

		if onuCodError = 0 then
			COMMIT;
			dbms_output.put_line('Se actualizó orden: ' || inuOrden);
            nuOK := nuOK + 1;
		else
			ROLLBACK;
			dbms_output.put_line('Error actualizando orden: ' || inuOrden ||', '|| osbMensError);
            nuErr := nuErr + 1;
		end IF;

        --dbms_output.put_line('Termina pProcOrdenes' );

        EXCEPTION
            when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR CONTR ORDEN|' || inuOrden || '|' || osbMensError);
                nuErr := nuErr + 1;
                ROLLBACK;
            when others then
                pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
                pkerrors.geterrorvar(onuCodError, osbMensError);
                dbms_output.put_line('ERROR NOCONT ORDEN|' ||inuOrden || '|' || osbMensError );
                nuErr := nuErr + 1;
                ROLLBACK;
    END pProcOrdenes;

BEGIN

	dbms_output.put_line('Inicia datafix OSF-3394');
    dbms_output.put_line('-----------------------------------------');    
    
    nuTotal := 0;
    nuOK    := 0;
    nuErr   := 0;

	FOR rgOrd IN cuOrdenes LOOP
        nuTotal := nuTotal + 1;

        FOR rgDatosOk IN cuDatosOk( rgOrd.ProdOk ) LOOP

            pProcOrdenes (rgOrd.order_id, rgOrd.ProdOk,  rgDatosOk.ContOk, rgDatosOk.ClieOk, rgDatosOk.NombOk, rgOrd.Soli, rgOrd.TiSo, rgDatosOk.DireOk);

		END LOOP;

	END LOOP;
    dbms_output.put_line('-----------------------------------------');
    dbms_output.put_line('Total Ordenes Seleccionadas: '||nuTotal);
    dbms_output.put_line('Total Ordenes Actualizadas:  '||nuOK);
    dbms_output.put_line('Total Ordenes con Error:     '||nuErr);
    dbms_output.put_line('-----------------------------------------');
	dbms_output.put_line('Finaliza datafix OSF-3394');

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/