column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

    Vsbproc varchar2(50);

  Begin
    --
    Vsbproc := 'IC_MOVIMIENT ';
    delete from open.ic_movimien
    where movifeco = '04-02-2024'
      and movitido = 71
      and movitihe = 'CE';
    --
    Vsbproc := 'IC_DOCUGENE ';
    delete open.ic_docugene d
    where d.dogetido = 71
      and trunc(d.dogefege) = '04-02-2024';
    --
    commit;
    --    
    DBMS_OUTPUT.PUT_LINE('Proceso termina Ok.');
    --
  Exception
    when others then
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error Eliminando en la tabla : ' || Vsbproc ||'   ' || SQLERRM);
  End;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/