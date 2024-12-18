declare
  nuerror number;
  sberror varchar2(4000);
  nuRegistros number;
begin
insert into selicicl 
select distinct s.slcicicl, 7057 servicio
from open.selicicl s
where not exists(select null from open.selicicl s2 where s2.slcicicl=s.slcicicl and s2.slciserv=7057);
nuRegistros:=sql%rowcount;
commit;
dbms_output.put_line('Registros insertados :'||nuRegistros);
exception
  when others then 
    errors.geterror(nuerror, sberror);
    rollback;
    dbms_output.put_line('Error:'||sberror);
end;
/