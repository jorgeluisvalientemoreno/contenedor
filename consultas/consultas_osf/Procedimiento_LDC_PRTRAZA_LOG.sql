create or replace procedure LDC_PRTRAZA_LOG(Inutralog_id number,
                                            Isbdata1     in varchar2,
                                            Isbdata2     in varchar2) is

  PRAGMA AUTONOMOUS_TRANSACTION;
begin

  insert into ldc_traza_log
    (tralog_id, fecha_registro, data1, data2)
  values
    (Inutralog_id, sysdate, Isbdata1, Isbdata2);
  commit;

exception
  when others then
    null;
  
end LDC_PRTRAZA_LOG;
