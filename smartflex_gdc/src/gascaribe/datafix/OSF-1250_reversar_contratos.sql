DECLARE

	nuerror NUMBER;
    sberror VARCHAR2(4000);


begin
  dbms_output.put_line('Inicia Reversión de contratos');
  
  BEGIN
	
	dbms_output.put_line('Actualizando: status, de la entidad or_order_activity');
	update open.or_order_activity
	set status = 'R'
	where order_activity_id in (281300518, 281296052, 240679398, 260946590);

	dbms_output.put_line('Actualizando: annul_date, annul_causal_id, motive_status_id, de la entidad mo_motive');
	update open.mo_motive
	set annul_date = '30/05/2023 11:08',
		annul_causal_id = 306,
		motive_status_id = 5
	where motive_id = 75464258;

	dbms_output.put_line('Actualizando: order_status_id, causal_id de la entidad or_order');
	update open.or_order
	set order_status_id = 5,
		causal_id = null
	where order_id in (248757346, 268770034, 288865076, 288869542);

	dbms_output.put_line('Eliminando los datos de las ordenes 248757346, 268770034, 288865076, 288869542 en or_order_comment');
	delete open.or_order_comment
	where order_id in (248757346, 268770034, 288865076, 288869542);
	
	dbms_output.put_line('Insertando el cambio de estado de la orden 248757346 en or_order_stat_change');
	Insert into OPEN.OR_ORDER_STAT_CHANGE
		(ORDER_STAT_CHANGE_ID, ACTION_ID, INITIAL_STATUS_ID, FINAL_STATUS_ID, ORDER_ID, 
		 STAT_CHG_DATE, USER_ID, TERMINAL, INITIAL_OPER_UNIT_ID)
	Values
		(SEQ_OR_ORDER_STAT_CHANGE.nextval, 102, 12, 5, 248757346, 
		 SYSDATE, 'OPEN', 'NO TERMINAL', 3623);
		 
	dbms_output.put_line('Insertando el cambio de estado de la orden 268770034 en or_order_stat_change');
	Insert into OPEN.OR_ORDER_STAT_CHANGE
		(ORDER_STAT_CHANGE_ID, ACTION_ID, INITIAL_STATUS_ID, FINAL_STATUS_ID, ORDER_ID, 
		 STAT_CHG_DATE, USER_ID, TERMINAL, INITIAL_OPER_UNIT_ID)
	Values
		(SEQ_OR_ORDER_STAT_CHANGE.nextval, 102, 12, 5, 268770034, 
		 SYSDATE, 'OPEN', 'NO TERMINAL', 4299);
	
	dbms_output.put_line('Insertando el cambio de estado de la orden 288865076 en or_order_stat_change');	
	Insert into OPEN.OR_ORDER_STAT_CHANGE
		(ORDER_STAT_CHANGE_ID, ACTION_ID, INITIAL_STATUS_ID, FINAL_STATUS_ID, ORDER_ID, 
		 STAT_CHG_DATE, USER_ID, TERMINAL, INITIAL_OPER_UNIT_ID)
	Values
		(SEQ_OR_ORDER_STAT_CHANGE.nextval, 102, 12, 5, 288865076, 
		 SYSDATE, 'OPEN', 'NO TERMINAL', 4006);
	
	dbms_output.put_line('Insertando el cambio de estado de la orden 288869542 en or_order_stat_change');	
	Insert into OPEN.OR_ORDER_STAT_CHANGE
		(ORDER_STAT_CHANGE_ID, ACTION_ID, INITIAL_STATUS_ID, FINAL_STATUS_ID, ORDER_ID, 
		 STAT_CHG_DATE, USER_ID, TERMINAL, INITIAL_OPER_UNIT_ID)
	Values
		(SEQ_OR_ORDER_STAT_CHANGE.nextval, 102, 12, 5, 288869542, 
		 SYSDATE, 'OPEN', 'NO TERMINAL', 4006);

	dbms_output.put_line('Actualizando: sesufere, sesuesco de la entidad servsusc');
	update open.servsusc
	set sesufere = '31/12/4732 23:59',
		sesuesco = 1
	where sesunuse = 52312570;

	dbms_output.put_line('Actualizando: sesufere, sesuesco de la entidad servsusc');
	update open.servsusc
	set sesufere = '31/12/4732 23:59',
		sesuesco = 3
	where sesunuse = 52407987;

	dbms_output.put_line('Actualizando: product_status_id, retire_date, suspen_ord_act_id  de la entidad pr_product');
	update open.pr_product
	set product_status_id = 1,
		retire_date = null,
		suspen_ord_act_id = null
	where product_id in (52312570, 52407987);

	dbms_output.put_line('Actualizando: component_status_id, de la entidad pr_component');
	update open.pr_component
	set component_status_id = 5
	where component_id in (6721599, 6721628);

	dbms_output.put_line('Actualizando: component_status_id, de la entidad pr_component');
	update open.pr_component
	set component_status_id = 8
	where component_id in (6862808, 6862830);

	dbms_output.put_line('Actualizando: annul_date, motive_status_id de la entidad mo_component');
	update open.mo_component
	set annul_date = null,
		motive_status_id = 23
	where component_id in (13577889, 13577910, 15054243, 15054244, 14454392,
						   14454401, 16178028, 16178029, 16162881, 16162882);
						   
	dbms_output.put_line('Actualizando: cmssfere, cmssescm de la entidad compsesu');
	update open.compsesu
	set cmssfere = '31/12/4732 23:59',
		cmssescm = 5
	where cmssidco in (6721599, 6721628);

	dbms_output.put_line('Actualizando: cmssfere, cmssescm de la entidad compsesu');
	update open.compsesu
	set cmssfere = '31/12/4732 23:59',
		cmssescm = 8
	where cmssidco in (6862808, 6862830);

	commit;
     
  
  EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuerror, sberror);
    DBMS_OUTPUT.PUT_LINE(sberror);
  END;
  
  dbms_output.put_line('Termina Reversión de contratos');
  
end;
/