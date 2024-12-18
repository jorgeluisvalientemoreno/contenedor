DECLARE
 nuconta number;
begin
  select count(*) into nuconta
 from dba_sequences
 where SEQUENCE_NAME = 'SEQ_GRUPVIFA';
 
 if nuconta = 0 then
	EXECUTE immediate 'CREATE SEQUENCE SEQ_GRUPVIFA start with 1 increment by 1 nocycle nocache';  
	EXECUTE immediate 'grant select on SEQ_GRUPVIFA to SYSTEM_OBJ_PRIVS_ROLE';
 end if;
end;
/