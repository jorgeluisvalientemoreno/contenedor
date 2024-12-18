column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuEjecucionFlujo NUMBER := 0;
	nuErrorCode    NUMBER(18);
	sbErrorMessage VARCHAR2(2000);
	
  	CURSOR cuPackages IS
	SELECT P.PACKAGE_ID,
			   P.MOTIVE_STATUS_ID,
			   P.PACKAGE_TYPE_ID,
			   P.REQUEST_DATE,
			   LAST_MESS_DESC_ERROR,
			   W.INSTANCE_ID,
			   I.INSERTING_DATE,
			   I.INTERFACE_HISTORY_ID CODIGO_CAMBIAR1,
			   NULL CODIGO_CAMBIAR2
		  FROM OPEN.IN_INTERFACE_HISTORY I,
			   OPEN.WF_INSTANCE          W,
			   OPEN.MO_PACKAGES          P,
			   OPEN.WF_DATA_EXTERNAL     DE
		 WHERE  I.REQUEST_NUMBER_ORIGI = W.INSTANCE_ID
		   AND DE.PLAN_ID = W.PLAN_ID
		   AND DE.PACKAGE_ID = P.PACKAGE_ID
		   AND P.PACKAGE_ID = 220048673;

BEGIN

	dbms_output.put_line('Inicia OSF-3715');

	FOR reg IN cuPackages LOOP
		nuEjecucionFlujo := 0;

		update or_order_activity set instance_id = reg.instance_id where  order_id = 342440122;

		BEGIN
			dbms_output.put_line('Empujando la solicitud: ' || reg.package_id);
		  
			WF_BOAnswer_Receptor.AnswerReceptor(reg.instance_id, -- Código de la instancia del flujo
												PKG_GESTIONORDENES.CNUCAUSALEXITO
												); 

			nuEjecucionFlujo := 0;
		
		EXCEPTION
			when PKG_ERROR.CONTROLLED_ERROR then
			nuEjecucionFlujo := 1;
			PKG_ERROR.GETERROR(nuErrorCode, sbErrorMessage);
			dbms_output.put_line('ERROR CONTROLLED ');
			dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
			dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
			when OTHERS then
			nuEjecucionFlujo := 1;
			PKG_ERROR.SETERROR;
			PKG_ERROR.GETERROR(nuErrorCode, sbErrorMessage);
			dbms_output.put_line('ERROR OTHERS ');
			dbms_output.put_line('error onuErrorCode: ' || nuErrorCode);
			dbms_output.put_line('error osbErrorMess: ' || sbErrorMessage);
		END;
	  END LOOP;

	  COMMIT;
  
	dbms_output.put_line('Finaliza OSF-3715');
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/