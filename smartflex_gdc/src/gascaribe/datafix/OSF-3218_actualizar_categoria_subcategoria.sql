column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  cursor cuContratos is
    select a.susccodi contrato
      from OPEN.SUSCRIPC a
     where a.susccodi in (48058469,
                          48087319,
                          66447739,
                          48100687,
                          48032581,
                          48011177,
                          48058468);

  rfuContratos cuContratos%rowtype;

BEGIN

  for rfContratos in cuContratos loop
  
    begin
      update open.pr_product pp
         set pp.category_id = 7, pp.subcategory_id = 1
       where pp.subscription_id = rfContratos.contrato;
    
      update open.servsusc s
         set s.sesucate = 7, s.sesusuca = 1
       where s.sesususc = rfContratos.contrato;
    
      COMMIT;
      dbms_output.put_line('Actualiza a categotia 7 y subcategorai 1 de los productos y servicios del contrato ' ||
                           rfContratos.contrato);
    exception
      when others then
        rollback;
        dbms_output.put_line('No se actualizo a categotia 7 y subcategorai 1 de los productos y servicios del contrato ' ||
                             rfContratos.contrato || ' - Error: ' ||
                             sqlerrm);
    end;
  
  end loop;

exception
  when others then
    ROLLBACK;
    dbms_output.put_line('Error - ' || sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/