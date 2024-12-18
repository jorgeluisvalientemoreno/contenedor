declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios where servicio_origen='DALD_PARAMETER.FNUGETNUMERIC_VALUE';

if contador = 0 then
  insert into homologacion_servicios values('OPEN','DALD_PARAMETER.FNUGETNUMERIC_VALUE','Obtiene el valor numerico registrado en un parametro','PERSONALIZACIONES','PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO','Obtiene el valor numerico registrado en un parametro',''	);
  commit;
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALD_PARAMETER.FNUGETNUMERIC_VALUE REGISTRADO OK.');
else
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALD_PARAMETER.FNUGETNUMERIC_VALUE YA EXISTE.');
end if;  

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/

