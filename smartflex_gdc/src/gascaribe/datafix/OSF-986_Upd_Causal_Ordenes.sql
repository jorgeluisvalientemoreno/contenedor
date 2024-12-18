column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-986';
	
	nuNuevaCausal	or_order.causal_id%TYPE := 3443;  --Revocación de órdenes

	cursor cuOrdenActuCausal is
       SELECT od.order_id, od.causal_id, rownum nurownum
	   FROM or_order od
	   WHERE od.order_id in
	  (
		278996094,
		275107834,
		275107862,
		275107841,
		275107885,
		275107827,
		278996116,
		278996091,
		274907179,
		275107715,
		278996088,
		278996119,
		278996130,
		275107836,
		278996113,
		278996109,
		275766556,
		275107864,
		275107882,
		275107887,
		278996098,
		275766570,
		278996095,
		275107828,
		278858296,
		275107881,
		275107837,
		275766600,
		275107872,
		278858295,
		275107855,
		278996142,
		275107778,
		275107838,
		278996110,
		278996132,
		275766586,
		275107867,
		275107865,
		275751674,
		275766562,
		275107863,
		278996105,
		278429024,
		275107839,
		275107875,
		278996141,
		275107782,
		275107833,
		275107851,
		275107858,
		275107870,
		278996115,
		275107853,
		275107854,
		275107878,
		278996118,
		275107874,
		275107877,
		275107849,
		275766545,
		275107832,
		275107869,
		278996107,
		275107850,
		275107751,
		275107888,
		278858300,
		275107831,
		275107830,
		275107710,
		278996092,
		278996093,
		275107847,
		278996117,
		278996103,
		278996089,
		275107884,
		279034559,
		275817045,
		279031349,
		275813208,
		278858297,
		279031198,
		279019085,
		275107880,
		275816878,
		275107779,
		275816877,
		275107843,
		275813203,
		279031177,
		275107845,
		279031172,
		278858299,
		275107844,
		275813210,
		279034028,
		275813256,
		275107842,
		275107886,
		275814098,
		279034572,
		279039826,
		279039835 
	   );

	PROCEDURE pActuCausalOrden( inuOrden or_order.order_id%TYPE, inuCausal or_order.causal_id%TYPE, inuRownum NUMBER )
	IS
        rcOrderComment  daor_order_comment.styor_order_comment;
        
        sbComment       or_order_comment.order_comment%TYPE := 'Se actualiza la causal a ' || nuNuevaCausal || ' por ' || sbCaso;
        nuCommTypeId    or_order_comment.comment_type_id%TYPE := 83;
		
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
				
				rcOrderComment.order_comment_id := or_bosequences.fnuNextOr_Order_Comment;
				rcOrderComment.order_comment    := sbComment;
				rcOrderComment.order_id         := inuOrden;
				rcOrderComment.comment_type_id  := nuCommTypeId;
				rcOrderComment.register_date    := ut_date.fdtSysdate;
				rcOrderComment.legalize_comment := GE_BOConstants.csbNO;
				rcOrderComment.person_id        := ge_boPersonal.fnuGetPersonId;

				daor_order_comment.insRecord(rcOrderComment);

				dbms_output.put_line( 'Ok update causal orden |'|| inuOrden );
				
				commit;
				
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
	
	commit;
	
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/