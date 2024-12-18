declare
  nuconta number;
begin
 select count(1) into nuconta
 from dba_synonyms
 where synonym_name = 'OR_BOORDERACTIVITIES'
 and OWNER = 'ADM_PERSON';

 if nuconta = 0 then
    execute immediate 'create synonym adm_person.or_boorderactivities for open.or_boorderactivities';
 end if;
end;
/