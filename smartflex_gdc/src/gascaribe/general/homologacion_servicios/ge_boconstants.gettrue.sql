declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios where servicio_origen='GE_BOCONSTANTS.GETTRUE';

if contador = 0 then
  insert into homologacion_servicios values('OPEN','GE_BOCONSTANTS.GETTRUE','Retorna valor booleano TRUE','PERSONALIZACIONES','CONSTANTS_PER.GETTRUE','Retorna valor booleano TRUE','');
  commit;
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO GE_BOCONSTANTS.GETTRUE REGISTRADO OK.');
else
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO GE_BOCONSTANTS.GETTRUE YA EXISTE.');
end if;  

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/

