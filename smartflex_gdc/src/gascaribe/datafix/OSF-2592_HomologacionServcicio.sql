declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios where servicio_origen='LDC_PKGREPEGELERECOYSUSP.PROREGISTRALOGLEGORDRECOSUSP';

if contador = 0 then
  insert into homologacion_servicios values('OPEN','LDC_PKGREPEGELERECOYSUSP.PROREGISTRALOGLEGORDRECOSUSP','Inserta en la tabla LDC_LOGERRLEORRESU','PERSONALIZACIONES','PKG_LDC_LOGERRLEORRESU.PRC_INS_LDC_LOGERRLEORRESU','Inserta en la tabla LDC_LOGERRLEORRESU',''	);
  commit;
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO LDC_PKGREPEGELERECOYSUSP.PROREGISTRALOGLEGORDRECOSUSP REGISTRADO OK.');
else
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO LDC_PKGREPEGELERECOYSUSP.PROREGISTRALOGLEGORDRECOSUSP YA EXISTE.');
end if;  

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/

