column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  declare 
    --
    Cursor Cuge_contrato IS
      select c.id_contrato, c.valor_total_contrato, c.fecha_inicial, c.fecha_final, c.valor_anticipo
        from open.ge_contrato c
      where c.id_contrato = 10061; -- Nro de Contrato
    -- Local variables here
    nuErrorCode  NUMBER;
    sberror      VARCHAR2(1000);
    vnunrocont   ge_contrato.id_contrato%type;
    vnuvrcontra  ge_contrato.valor_total_contrato%type;
    dtfecinicia  ge_contrato.fecha_inicial%type;
    dtfecfinal   ge_contrato.fecha_final%type;
    vnuvrantic   ge_contrato.valor_anticipo%type;
    --
  begin
    -- Test statements here
    open Cuge_contrato;
    fetch Cuge_contrato into vnunrocont, vnuvrcontra, dtfecinicia, dtfecfinal, vnuvrantic;
    close Cuge_contrato;
    
    CT_BOCONTRACT.INITIALIZECONTRACT(vnunrocont, vnuvrcontra, vnuvrantic, dtfecinicia, dtfecfinal, 8933,  'NUEVO CONTRATO FNB');
    commit;
    
  EXCEPTION  
    WHEN EX.CONTROLLED_ERROR THEN
        ERRORS.GETERROR(nuErrorCode,sberror);
              DBMS_OUTPUT.put_line(sberror);
    WHEN OTHERS THEN
            Errors.setError;
          ERRORS.GETERROR(nuErrorCode,sberror); 
          DBMS_OUTPUT.put_line(sberror);
  END;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/