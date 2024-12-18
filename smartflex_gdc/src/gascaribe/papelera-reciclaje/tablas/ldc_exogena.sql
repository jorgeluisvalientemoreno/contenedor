declare 
    nuExiste number;
begin
  select count(1)
  into nuExiste
  from dba_tables
  where owner='OPEN'
   and table_name='LDC_EXOGENA';

   if nuExiste > 0 then 
    execute immediate 'DROP TABLE OPEN.LDC_EXOGENA';
   end if;
end;
/