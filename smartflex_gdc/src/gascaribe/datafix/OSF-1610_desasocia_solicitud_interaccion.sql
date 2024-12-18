set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1610');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    cursor cuSolicitudes is
        select rowid as rid, package_id_asso from open.mo_packages_asso  
        WHERE package_id IN ( 200906213, 201129350 );
    NUERROR NUMBER;
BEGIN

	FOR reg IN cuSolicitudes LOOP

		nuError  :=0;
		--elimina el registro en mo_package_asso
      
    delete mo_packages_asso 
    where rowid= reg.rid;

	dbms_output.put_line('elimina el registro de la solicitud asociada: '|| reg.package_id_asso);
	
	END LOOP;
END;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/