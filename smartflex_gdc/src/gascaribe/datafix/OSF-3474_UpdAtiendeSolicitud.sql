column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	cursor cuSolicitudes is
        SELECT p2.package_id,
                p2.request_Date,
                p2.motive_status_id,
                p2.user_id,
                p2.comment_,
                p2.cust_care_reques_num,
                p2.package_type_id,
                mo.product_id,
                mo.motive_id
        FROM OPEN.mo_packages p
        INNER JOIN OPEN.mo_packages p2 on p2.cust_care_reques_num=to_char(p.cust_care_reques_num)
        INNER JOIN OPEN.mo_motive mo on mo.package_id=p2.package_id
        WHERE p.package_id IN (10644538)
        AND p2.motive_status_id in (13,32)
        ORDER BY  p2.package_id;

	PROCEDURE pReactiva( inuSolicitud mo_packages.package_id%TYPE, inuProducto mo_motive.product_id%type, inuMotivo  mo_motive.motive_id%type)
	IS	
		dtFechMaxi DATE := TO_DATE( '31-12-4732','DD-MM-YYYY');  
	BEGIN

		dbms_output.put_line( 'Inicia pReactiva Solicitud|'|| inuSolicitud );

		-- Solicitud -- ok
		update open.mo_packages m
		set m.motive_status_id = 14, attention_date = sysdate
		where m.package_id = inuSolicitud;

		dbms_output.put_line( 'Ok update mo_packages'  );

		-- Motivo -- ok
		update open.mo_motive m
		set m.motive_status_id = 11, attention_date = sysdate
		where m.package_id = inuSolicitud;

		dbms_output.put_line( 'Ok update mo_motive' );

        update open.servsusc s
        set sesuesco = 1,
            sesufere = dtFechMaxi
        where s.sesunuse = 50637295;

		dbms_output.put_line( 'Ok update servsusc' );

		-- Componente del motivo
		update open.mo_component m
		set m.motive_status_id = 23,
		m.attention_date = sysdate
		where m.motive_id = inuMotivo;

		dbms_output.put_line( 'Ok update mo_component' );

		--
		commit;

		dbms_output.put_line( 'Finaliza pReactiva Solicitud|'|| inuSolicitud );

	exception
		when others then
			dbms_output.put_line( 'ERROR: Reactivando Solicitud |' || inuSolicitud || '|' || SQLERRM );
			rollback;	

	END pReactiva;  

BEGIN

	dbms_output.put_line( 'Inicia OSF-3474' );

	FOR reg IN cuSolicitudes LOOP
		pReactiva( reg.package_id, reg.product_id, reg.motive_id );
	END LOOP;

	dbms_output.put_line( 'Fin OSF-3474' );

END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/