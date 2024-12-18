column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	sbCaso			VARCHAR2(30) := 'OSF-1470';
	
	nuNuevaCausal	or_order.causal_id%TYPE := 9777;  --PAGO POR GESTIÓN DE CONTRATISTA

	cursor cuOrdenActuCausal is
	select  a.order_id,
			a.legalization_date,
			a.task_type_id,
			a.causal_id,
			b.subscription_id,
			b.product_id,
			(select max(pagofepa) from pagos where pagosusc = b.subscription_id and trunc(pagofepa) = trunc(a.legalization_date) ) pagofepa,
			(select max(pagofegr) from pagos where pagosusc = b.subscription_id and trunc(pagofepa) = trunc(a.legalization_date) ) pagofegrt,
			rownum nurownum
	from or_order a, or_order_activity b
	where b.order_id = a.order_id
	and a.order_id in
    (
    293142399,
    292043934,
    294117213,
    294110563,
    294218620,
    294757502,
    294909764,
    294748065,
    294466117,
    294106289,
    294336326,
    294760196,
    294743966,
    294776622,
    293752363,
    294243928,
    294745281,
    294215561,
    294241276,
    294335723,
    293389213,
    294755000,
    294757311,
    292221012,
    294784865,
    294745051,
    293754824,
    294919033,
    294750061,
    294335506,
    294751629,
    294343057,
    294214772,
    294214870,
    294754966,
    292457879,
    294343616,
    293385369,
    293044206,
    293049943,
    293239883,
    294786767,
    292221040,
    294336819,
    294464740,
    294339850,
    293236543,
    294238849,
    293759320,
    294467814,
    293044058,
    294343557,
    294108779,
    293044008,
    293029372,
    294465990,
    294464705,
    294342392,
    294106309,
    294466808,
    293928516,
    294752516,
    294759698,
    292342418,
    292139592,
    294466860,
    294463915,
    292812091,
    294220162,
    294918919,
    294242343,
    293032918,
    293758467,
    293043881,
    294342358,
    294334984,
    294335430,
    294762109,
    293759050
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