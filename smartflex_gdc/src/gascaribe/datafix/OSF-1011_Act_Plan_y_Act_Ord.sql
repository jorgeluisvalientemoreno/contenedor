column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-1011';
	
	nuNuevoPlan		NUMBER := 36;

	cursor cuSolicitud is
       SELECT mo.package_id, mo.motive_id, mo.product_id
	   FROM mo_packages pk,
			mo_motive 	mo
	   WHERE pk.package_id = 196288193
			AND pk.motive_status_id = 13
			AND mo.package_id = pk.package_id
			AND mo.commercial_plan_id = 54;
						  
	PROCEDURE pActuSoliActiOrden( inuSolicitud NUMBER, inuMotivo NUMBER, inuProducto NUMBER )
	IS

        sbComment       or_order_comment.order_comment%TYPE := 'Se actualiza la actividad y los items  por ' || sbCaso;
        nuCommTypeId    or_order_comment.comment_type_id%TYPE := 83;
				
		onuCodError     NUMBER;
		osbMensError    VARCHAR2(4000);
		
		CURSOR cuMotivo( inuMoti NUMBER)
		IS
		SELECT commercial_plan_id, mo.ROWID Rid
		FROM mo_motive MO
		WHERE mo.motive_id = inuMoti;

		CURSOR cuServSusc( inuSeSu NUMBER)
		IS
		SELECT ss.sesuplfa, ss.ROWID Rid
		FROM servsusc ss
		WHERE ss.sesunuse = inuSeSu;

		CURSOR cuProducto( inuProd NUMBER)
		IS
		SELECT pr.commercial_plan_id, pr.ROWID Rid
		FROM pr_product pr
		WHERE pr.product_id = inuProd;

		CURSOR cuOrdenes
		IS
		SELECT order_id
		FROM or_order od
		WHERE od.order_id IN ( 275306203, 275306202  );
				
		CURSOR cuActividades ( inuOrden NUMBER )
		IS
		SELECT oa.*, oa.ROWID Rid
		FROM or_order_activity oa
		WHERE oa.order_id = inuOrden
		AND status = 'R';
		
		CURSOR cuItems( inuOrden NUMBER )
		IS
		SELECT oi.*, ROWID Rid
		FROM or_order_items oi
		WHERE oi.order_id = inuOrden;
		
		nuNuevaActividad    NUMBER;		
        
	BEGIN
		
		FOR rgMoti IN cuMotivo( inuMotivo) LOOP

			dbms_output.put_line( 'Plan Antes[' || rgMoti.commercial_plan_id || ']motivo[' || inuMotivo || ']' );			
		
			IF rgMoti.commercial_plan_id <> nuNuevoPlan THEN
				UPDATE mo_motive
				SET commercial_plan_id = nuNuevoPlan
				WHERE rowid = rgMoti.Rid;
			END IF;

		END LOOP;

		FOR rgMoti IN cuMotivo( inuMotivo) LOOP

			dbms_output.put_line( 'Plan Despu[' || rgMoti.commercial_plan_id || ']motivo[' || inuMotivo || ']' );			
		
		END LOOP;
				
		
		FOR rgSeSu IN cuServSusc( inuProducto ) LOOP

			dbms_output.put_line( 'Plan Antes[' || rgSeSu.sesuplfa || ']servicio suscrito[' || inuProducto || ']' );	
			
			IF rgSeSu.sesuplfa <> nuNuevoPlan THEN
				UPDATE servsusc
				SET sesuplfa = nuNuevoPlan
				WHERE rowid = rgSeSu.Rid;
			END IF;
			
		END LOOP;

		FOR rgSeSu IN cuServSusc( inuProducto ) LOOP

			dbms_output.put_line( 'Plan Despu[' || rgSeSu.sesuplfa || ']servicio suscrito[' || inuProducto || ']' );	
						
		END LOOP;
		
		FOR rgProd IN cuProducto( inuProducto ) LOOP

			dbms_output.put_line( 'Plan Antes[' || rgProd.commercial_plan_id || ']producto[' || inuProducto || ']' );
			
			IF rgProd.commercial_plan_id <> nuNuevoPlan THEN
			
				UPDATE pr_product
				SET commercial_plan_id = nuNuevoPlan
				WHERE rowid = rgProd.Rid;
				
			END IF;
			
		END LOOP;

		FOR rgProd IN cuProducto( inuProducto ) LOOP

			dbms_output.put_line( 'Plan Despu[' || rgProd.commercial_plan_id || ']producto[' || inuProducto || ']' );
			
		END LOOP;	
		
		FOR rgOrden IN cuOrdenes LOOP
		
			FOR rgActi IN cuActividades ( rgOrden.Order_Id ) LOOP

				dbms_output.put_line( 'Actividad Antes[' || rgActi.activity_id || ']actividad orden[' || rgActi.order_activity_id || ']' );	
				
				IF rgActi.activity_id NOT IN ( 4000051, 4000063) THEN
				
                    nuNuevaActividad := CASE rgActi.task_type_id 
										WHEN 12150 THEN 4000051
										WHEN 12162 THEN 4000063
										ELSE NULL
									  END;
                    
                    IF nuNuevaActividad IS NOT NULL then
                    
                        update or_order_activity
                        SET activity_id = nuNuevaActividad
                        WHERE rowid = rgActi.Rid ;
                        
                    END IF;
                        
				END IF;
								
			END LOOP;
			
			FOR rgActi IN cuActividades ( rgOrden.Order_Id ) LOOP
			
				dbms_output.put_line( 'Actividad Despu[' || rgActi.activity_id || ']actividad orden[' || rgActi.order_activity_id || ']' );	
			
			END LOOP;
			

			FOR rgItem IN cuItems ( rgOrden.Order_Id ) LOOP

				dbms_output.put_line( 'Item Antes|' || rgItem.items_id || ']Order_Items_id[' || rgItem.order_items_id || ']' );
				
				IF rgItem.items_id IN ( 100002510, 100002515 ) THEN
					update or_order_items
					SET items_id = CASE rgItem.items_id 
										WHEN 100002510 THEN 4000051
										WHEN 100002515 THEN 4000063
									  END
					WHERE rowid = rgItem.Rid;			
				END IF;

			
			END LOOP;


			FOR rgItem IN cuItems ( rgOrden.Order_Id ) LOOP

				dbms_output.put_line( 'Item Despu|' || rgItem.items_id || ']Order_Items_id[' || rgItem.order_items_id || ']' );
			
			END LOOP;
			
			onuCodError := null;
			osbMensError:= null;
			
			OS_ADDORDERCOMMENT( inuOrderId       => rgOrden.ORDER_ID,
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

			  
    EXCEPTION
        when LOGIN_DENIED OR pkConstante.exERROR_LEVEL2 OR ex.CONTROLLED_ERROR then
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR CONTR Solicitud|' || inuSolicitud || '|' || osbMensError);
			rollback;
        when others then
            pkErrors.NotifyError(pkErrors.fsbLastObject, sqlerrm, osbMensError);
            pkerrors.geterrorvar(onuCodError, osbMensError);
            dbms_output.put_line('ERROR NCONT Solicitud|' || inuSolicitud || '|' || osbMensError);
			rollback;
	END pActuSoliActiOrden;

BEGIN

	FOR reg IN cuSolicitud LOOP
		pActuSoliActiOrden( reg.package_id, reg.motive_id, reg.product_id);
	END LOOP;
		
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/