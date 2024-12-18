column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare

  vnuacta  ge_acta.id_acta%type := 228810;

  begin
    
      update ge_acta
        set EXTERN_INVOICE_NUM=NULL,
            EXTERN_PAY_DATE=NULL
      WHERE  id_acta = vnuacta;
      commit;    
  exception
    when others then
        ROLLBACK;
          DBMS_OUTPUT.PUT_LINE('Error Update : ' || SQLERRM);
  end;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/