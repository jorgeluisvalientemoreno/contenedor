column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-3605';
						  
	PROCEDURE prcActuaActivividad
	IS

        sbComment       	or_order_comment.order_comment%TYPE := 'Se actualiza la actividad y los items por ' || sbCaso;
        nuCommTypeId    	or_order_comment.comment_type_id%TYPE := 83;
		nuNuevaActividad    NUMBER := 100009058;	
				
		onuCodError     NUMBER;
		osbMensError    VARCHAR2(4000);

		CURSOR cuOrdenes
		IS
		SELECT order_id
		FROM or_order od
		WHERE od.order_id IN (279651851);
				
		CURSOR cuActividades (inuOrden NUMBER)
		IS
		SELECT oa.*, 
			   oa.ROWID Rid
		FROM or_order_activity oa
		WHERE oa.order_id = inuOrden
		AND status = 'R';
		
		CURSOR cuItems(inuOrden NUMBER)
		IS
		SELECT oi.*, 
			   ROWID Rid
		FROM or_order_items oi
		WHERE oi.order_id = inuOrden;	
        
	BEGIN	
		
		dbms_output.put_line('Inicia prcActuaActivividad');
		
		FOR rgOrden IN cuOrdenes LOOP
		
			dbms_output.put_line('Inicia actualización de la actividad de la orden: '|| rgOrden.Order_Id);
		
			FOR rgActi IN cuActividades(rgOrden.Order_Id) LOOP

				dbms_output.put_line( 'Actividad Antes[' || rgActi.activity_id || '] actividad orden[' || rgActi.order_activity_id || ']');	
				
				update or_order_activity
                SET activity_id = nuNuevaActividad
                WHERE rowid = rgActi.Rid ;
								
			END LOOP;
			
			FOR rgActi IN cuActividades (rgOrden.Order_Id) LOOP
			
				dbms_output.put_line( 'Actividad Despu[' || rgActi.activity_id || '] actividad orden[' || rgActi.order_activity_id || ']');	
			
			END LOOP;
			

			FOR rgItem IN cuItems(rgOrden.Order_Id) LOOP

				dbms_output.put_line('Item Antes|' || rgItem.items_id || '] Order_Items_id[' || rgItem.order_items_id || ']');
				
				update or_order_items
				SET items_id = nuNuevaActividad
				WHERE rowid = rgItem.Rid;			
				
			END LOOP;


			FOR rgItem IN cuItems (rgOrden.Order_Id) LOOP

				dbms_output.put_line('Item Despu|' || rgItem.items_id || '] Order_Items_id[' || rgItem.order_items_id || ']');
			
			END LOOP;
			
			onuCodError 	:= null;
			osbMensError	:= null;
			
			dbms_output.put_line('Agregando comentario a la orden ' || rgOrden.Order_Id);
			
			api_addordercomment(inuOrderId       => rgOrden.ORDER_ID,
								inuCommentTypeId => nuCommTypeId,
								isbComment       => sbComment,
								onuErrorCode     => onuCodError,
								osbErrorMessage  => osbMensError);
								
			IF (onuCodError <> 0) THEN
				dbms_output.put_line('No se logro crear el comentario de La orden ['||rgOrden.ORDER_ID||'][' || osbMensError || ']');
				ROLLBACK;
			ELSE
				COMMIT;			
			END IF;			
				
		END LOOP;
		
		dbms_output.put_line('Inicia prcActuaActivividad');
			  
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR onuCodError|' || onuCodError || '|' || osbMensError);
			rollback;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT onuCodError|' || onuCodError || '|' || osbMensError);
			rollback;
	END prcActuaActivividad;

BEGIN

	dbms_output.put_line('Inicio Datafix OSF-3605');

	prcActuaActivividad;
		
	dbms_output.put_line('Termina Datafix OSF-3605');
		
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/