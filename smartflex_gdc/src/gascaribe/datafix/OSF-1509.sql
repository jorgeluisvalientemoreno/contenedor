column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1509');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin


   
  BEGIN
    
    update  concilia
                    set     concfeci = null,concflpr = 'N'
                    where   conccons = 247220;
    dbms_output.put_line('ACTUALIZA CONCILIACION 247220');

    DELETE docusore where   dosrconc in ( 247220); 
    dbms_output.put_line('BORRA DOCUSORE docusore'); 
      
    COMMIT;
    --
    DBMS_OUTPUT.PUT_LINE('Proceso termina ok');
  EXCEPTION
    WHEN others THEN
    ROLLBACK;
    ERRORS.SETERROR();
    RAISE EX.CONTROLLED_ERROR;
  END;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/