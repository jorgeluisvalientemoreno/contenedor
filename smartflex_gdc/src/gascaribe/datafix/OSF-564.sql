column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
	CURSOR cuOrdenes IS
        SELECT 	o.order_id, a.package_id, a.order_activity_id
        FROM 	open.or_order o, open.or_order_activity a
		WHERE 	o.order_id in (254329451,254329488,254329468,254329590,254329697,254329470,254329695,254329750,254329753,254329692,254329713,254329700,254329727,254329509,
							254329732,254329601,254329537,254329475,254329432,254329759,254329426,254329756,254329513,254329438,254329525,254329534,254329522,254329552,
							254329502,254329499,254329559,254329598,254329646,254329531,254329563,254329556,254329604,254329569,254329648,254329547,254329524,254329561,
							254329511,254329554,254329565,254329613,254329666,254329642,254329656,254329660,254329686,254329683,254329619,254329669,254329608,254329672,
							254329516,254329607,254329622,254329664,254329674,254329527)
		AND 	o.causal_id = 3675
		AND		o.order_id = a.order_id;
							
	TYPE tytbOrdenes IS TABLE OF cuOrdenes%ROWTYPE INDEX BY BINARY_INTEGER;
	tbOrdenes tytbOrdenes;
	
	idx	BINARY_INTEGER;
	
	rcOrderComment  daor_order_comment.styOR_order_comment;
    sbComment VARCHAR2(4000) := 'Se desasocia la orden de la solicitud OSF-564.';

BEGIN

	OPEN cuOrdenes;
	FETCH cuOrdenes BULK COLLECT INTO tbOrdenes;
	CLOSE cuOrdenes;
		
	idx := tbOrdenes.first;
	
	LOOP
		EXIT WHEN idx IS NULL;
		
		/* Inserta registro en OR_order_comment */
        rcOrderComment.order_comment_id 	:= or_bosequences.fnuNextOr_Order_Comment;
        rcOrderComment.order_comment 		:= sbComment||' Solicitud: '||tbOrdenes(idx).package_id;
        rcOrderComment.order_id 			:= tbOrdenes(idx).order_id;
        rcOrderComment.comment_type_id 		:= 1277;
        rcOrderComment.register_date 		:= sysdate;
        rcOrderComment.legalize_comment 	:= GE_BOConstants.csbNO;
        rcOrderComment.person_id 			:= ge_boPersonal.fnuGetPersonId;

        daor_order_comment.insRecord(rcOrderComment);

		/* Actualizar solicitud de la actividad */
		daor_order_activity.updpackage_id(tbOrdenes(idx).order_activity_id, null);
		
		idx := tbOrdenes.NEXT(idx);
	END LOOP;
	
	COMMIT;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/