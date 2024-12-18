column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuerror NUMBER;
    sberror VARCHAR2(4000);
	nuCommentType or_order_comment.comment_type_id%type := 1277;

	CURSOR cuInfoCuenta IS
		select mp.package_id package_id, 
			   oo.order_id order_id,
			   ooa.product_id product_id,
			   mm.motive_id motive_id
		from open.or_order_activity ooa, open.or_order oo, open.mo_packages mp, open.mo_motive mm
		where mm.product_id in (select sesunuse 
								from open.servsusc 
								where sesususc in (67262722, 67199566)) 
		and ooa.product_id	= mm.product_id
		and mp.package_id 	= mm.package_id
		and oo.order_id 	= ooa.order_id
		and ooa.status 		= 'R';

begin
  dbms_output.put_line('Inicia OSF-1223');
  
  BEGIN
  
  --reversion de transitorias
  FOR reg IN cuInfoCuenta LOOP
	
	/*dbms_output.put_line('Actualizando el estado de mo_packages, de la solicitud: ' || reg.package_id);
	
	-- Solicitud -- ok
	update open.mo_packages m
    set m.motive_status_id = 32
	where m.package_id in (reg.package_id);*/
	
	dbms_output.put_line('Actualizando el estado, fecha de anulación, causal de anulación de mo_motive, de la solicitud: ' || reg.motive_id);
   
	-- Motivo -- ok
	update open.mo_motive m
    set m.motive_status_id 	= 5,
        m.annul_date 		= sysdate,
        m.annul_causal_id 	= 306
	where m.motive_id in (reg.motive_id);
	
	dbms_output.put_line('Anulando, de la orden: ' || reg.order_id);
	
	or_boanullorder.anullorderwithoutval(reg.order_id, SYSDATE);
	
	OS_ADDORDERCOMMENT(reg.order_id,
                       nuCommentType,
                       'Se anula por solicitud en el caso OSF-1223',
                       nuerror,
                       sberror);
	
	dbms_output.put_line('Actualizando el estado de corte de servsusc, del producto: ' || reg.product_id);
   
	-- Estado de corte del producto -- ok
	update open.servsusc s
    set sesuesco = 110,
		sesufere = sysdate
	where s.sesunuse in (reg.product_id);
	
	dbms_output.put_line('Actualizando el estado, Actividad de orden de suspensión del servicio y fecha de retiro de pr_product del producto: ' || reg.product_id);
   
	-- Estado del producto -- ok
	update open.pr_product p
    set p.product_status_id = 16,
        p.suspen_ord_act_id = null,
        p.retire_date = sysdate
	where p.product_id in (reg.product_id);
	
	dbms_output.put_line('Actualizando el estado en pr_component, del producto: ' || reg.product_id);
   
	-- Estado Componente del prodcuto -- ok
	update open.pr_component
    set component_status_id = 18
	where product_id in (reg.product_id);
	
	dbms_output.put_line('Actualizando el estado y fecha de anulación en mo_component del producto: ' || reg.product_id);
   
	-- Componente del motivo
	update open.mo_component m
    set m.motive_status_id = 26,
        m.annul_date = sysdate
	where product_id in (reg.product_id);
	
	dbms_output.put_line('Actualizando el estado y fecha de retiro en compsesu del producto: ' || reg.product_id);
   
	-- Componente del Servicio Suscripto
	update open.compsesu
    set cmssescm = 18,
        cmssfere = sysdate
	where cmsssesu in (reg.product_id);
	
	commit;
     
  END LOOP;
  
  EXCEPTION
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuerror, sberror);
    DBMS_OUTPUT.PUT_LINE(sberror);
  END;
  
  dbms_output.put_line('Termina OSF-1223');
  
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/