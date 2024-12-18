column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  Declare

  Begin
    --
    EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgbu_Concilia DISABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgUpdConcilia DISABLE';
    -- Actualiza DOCUSORE
    update open.docusore d
      set d.dosrtdsr = 1,
          d.dosrnucu = 4
    where d.dosrconc in (256120);
    -- Actualiza CONCILIA
    update open.concilia c
      set c.concnucu = 4,
          c.concvato = 68556
    where c.conccons in (256120);
    -- 
    commit;
    --
    EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgbu_Concilia ENABLE';
    EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgUpdConcilia ENABLE';
    --
  Exception
    when others then
       EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgbu_Concilia ENABLE';
       EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.trgUpdConcilia ENABLE';    
       ROLLBACK;
       DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
  End;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/