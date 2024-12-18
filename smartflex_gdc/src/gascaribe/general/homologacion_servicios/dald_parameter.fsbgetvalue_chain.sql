declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios where servicio_origen='DALD_PARAMETER.FSBGETVALUE_CHAIN';

if contador = 0 then
  insert into homologacion_servicios values('OPEN','DALD_PARAMETER.FSBGETVALUE_CHAIN','Obtiene el valor cadena registrado en un parametro','PERSONALIZACIONES','PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA','Obtiene el valor cadena registrado en un parametro',''	);
  commit;
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALD_PARAMETER.FSBGETVALUE_CHAIN REGISTRADO OK.');
else
  update homologacion_servicios set servicio_destino = 'PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA' where servicio_origen = 'DALD_PARAMETER.FSBGETVALUE_CHAIN';
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO DALD_PARAMETER.FSBGETVALUE_CHAIN YA EXISTE.');
end if;  

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
