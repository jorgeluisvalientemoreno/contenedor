declare
  nuActivo number;
begin
  select count(1)
    into nuActivo
  from dba_scheduler_jobs j
  where j.job_name='LDCI_FACELEC_EMI_ENERSOLAR'
    and j.STATE!='DISABLED';
  if nuActivo > 0 then
   sys.dbms_scheduler.disable(name => 'OPEN.LDCI_FACELEC_EMI_ENERSOLAR');
  end if;
end;
/