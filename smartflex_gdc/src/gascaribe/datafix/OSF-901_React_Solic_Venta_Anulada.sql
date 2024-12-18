column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	cursor cuSolicitudes is
       SELECT pk.package_id,
                pk.request_Date,
                pk.motive_status_id,
                pk.user_id,
                pk.comment_,
                pk.cust_care_reques_num,
                pk.package_type_id,
                mo.product_id
        FROM OPEN.mo_packages pk,
        OPEN.mo_motive mo
        WHERE pk.package_id IN 
        (
            194377563,
            191779676
        )
		AND pk.package_type_id = 271
		AND pk.motive_status_id =32
		AND mo.package_id = pk.package_id
        ORDER BY  pk.package_id;
  
	PROCEDURE pReactiva( inuSolicitud mo_packages.package_id%TYPE, inuProducto mo_motive.product_id%type )
	IS	
		dtFechMaxi DATE := TO_DATE( '31-12-4732','DD-MM-YYYY');  
	BEGIN

		dbms_output.put_line( 'Inicia pReactiva Solicitud|'|| inuSolicitud );
		
		-- Or_order_activity -- ok
		update open.or_order_activity a
		set a.status = 'R'
		where a.package_id = inuSolicitud;
		
		dbms_output.put_line( 'Ok update or_order_activity'  );
	
		-- Solicitud -- ok
		update open.mo_packages m
		set m.motive_status_id = 13
		where m.package_id = inuSolicitud;

		dbms_output.put_line( 'Ok update mo_packages'  );
		
		-- Motivo -- ok
		update open.mo_motive m
		set m.motive_status_id = 1,
		m.annul_date = null,
		m.annul_causal_id = null
		where m.package_id = inuSolicitud;
		
		dbms_output.put_line( 'Ok update mo_motive' );

		update open.servsusc s
		set sesuesco = 96
		where s.sesunuse = inuProducto;

		dbms_output.put_line( 'Ok update servsusc' );
		
		-- Estado del producto -- ok
		update open.pr_product p
		set p.product_status_id = 15,
			p.suspen_ord_act_id = null,
			p.retire_date = dtFechMaxi
		where p.product_id = inuProducto;

		dbms_output.put_line( 'Ok update pr_product' );
		
		-- Estado Componente del prodcuto -- ok
		update open.pr_component
		set component_status_id = 17
		where product_id = inuProducto;

		dbms_output.put_line( 'Ok update pr_component' );
		
		-- Componente del motivo
		update open.mo_component m
		set m.motive_status_id = 15,
		m.annul_date = dtFechMaxi
		where product_id = inuProducto;

		dbms_output.put_line( 'Ok update mo_component' );
		
		-- 
		update open.compsesu
		set cmssescm = 17,
		cmssfere = dtFechMaxi
		where cmsssesu = inuProducto;

		dbms_output.put_line( 'Ok update compsesu' );
		
		-- Pasa Cupones a la tabla cupones desde la tabla Cupon_Anulado_Ventas..
		insert into open.cupon 
		select * from open.Cupon_Anulado_Ventas p 
		where p.cupodocu = TO_CHAR(inuSolicitud);

		dbms_output.put_line( 'Ok insert cupón' );
				
		-- Borra cupones de la tabla Anulados..
		delete open.Cupon_Anulado_Ventas p 
		where p.cupodocu = TO_CHAR(inuSolicitud);

		dbms_output.put_line( 'Ok delete Cupon_Anulado_Ventas' );
		
		--
		commit;

		dbms_output.put_line( 'Finaliza pReactiva Solicitud|'|| inuSolicitud );
	  
	exception
		when others then
			dbms_output.put_line( 'ERROR: Reactivando Solicitud |' || inuSolicitud || '|' || SQLERRM );
			rollback;	

	END pReactiva;  

BEGIN

	FOR reg IN cuSolicitudes LOOP
		pReactiva( reg.package_id, reg.product_id );
	END LOOP;

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/