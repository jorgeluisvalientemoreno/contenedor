column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-3428';
	
	nuNuevaCausal	or_order.causal_id%TYPE := 9866;  

	cursor cuOrdenActuCausal is
       SELECT od.order_id, 
			  od.causal_id, 
			  rownum nurownum
	   FROM or_order od
	   WHERE od.order_id in (203899183);

	PROCEDURE pActuCausalOrden(inuOrden or_order.order_id%TYPE, 
							   inuCausal or_order.causal_id%TYPE, 
							   inuRownum NUMBER 
							   )
	IS
        rcOrderComment  daor_order_comment.styor_order_comment;
        
        sbComment       or_order_comment.order_comment%TYPE := 'Se actualiza la causal a ' || nuNuevaCausal || ' por ' || sbCaso;
        nuCommTypeId    or_order_comment.comment_type_id%TYPE := 1277;

		nuErrorCode   number;
  		sbErrorMesse  varchar2(4000);
		
		CURSOR cuGe_Detalle_Acta
		IS
		SELECT *
		FROM GE_DETALLE_ACTA
		WHERE ID_ORDEN = inuOrden;
		
		rcGe_Detalle_Acta cuGe_Detalle_Acta%ROWTYPE;
        
	BEGIN
	
		OPEN cuGe_Detalle_Acta;
		FETCH cuGe_Detalle_Acta INTO rcGe_Detalle_Acta;
		CLOSE cuGe_Detalle_Acta;
		
		IF rcGe_Detalle_Acta.Id_Orden IS NULL THEN
		

			IF ( inuCausal NOT IN ( nuNuevaCausal ) )
			THEN 
		
				UPDATE or_order
				SET causal_id = nuNuevaCausal
				WHERE order_id = inuOrden;

				api_addordercomment(inuOrden,
								   nuCommTypeId,
								   sbComment,
								   nuErrorCode,
								   sbErrorMesse
								   );
								   
				if nuErrorCode = 0 then
					commit;
					dbms_output.put_line('Se actualiza OK orden: ' || inuOrden);
				else
					rollback;
					dbms_output.put_line('Error actualiza orden: ' || inuOrden ||
											' : ' || sbErrorMesse);
				end IF;
				
			ELSE

				dbms_output.put_line( 'No se actualiza Orden |'|| inuOrden || '| por que la causal actual es|' || inuCausal );       
				
			END IF;
			
		ELSE

			dbms_output.put_line( 'No se actualiza Orden |'|| inuOrden || '| porque esta en el acta |' || rcGe_Detalle_Acta.Id_Acta );
				
		END IF;
			  
	exception
		when others then
			dbms_output.put_line( 'ERROR:  orden|' || inuOrden || '|' || SQLERRM );
			rollback;	

	END pActuCausalOrden;

BEGIN

	FOR reg IN cuOrdenActuCausal LOOP
		pActuCausalOrden( reg.order_id , reg.causal_id, reg.nurownum);
	END LOOP;
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/