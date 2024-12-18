declare

contador Number;

begin

select count(1) into contador
from personalizaciones.homologacion_servicios where servicio_origen='LDC_FNURETTIPOEXCEP'; 

if contador = 0 then
  insert into homologacion_servicios values('OPEN','LDC_FNURETTIPOEXCEP','Obtiene el tipo exencion definido en una solicitud de exencion cobro a facturar','PERSONALIZACIONES','PKG_BCEXENCION_CONTRIBUCION.FNUOBTENERTIPOEXENCION','Obtiene el tipo exencion definido en una solicitud de exencion cobro a facturar',''	);
  commit;
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO LDC_FNURETTIPOEXCEP REGISTRADO OK.');
else
  dbms_output.put_line('HOMOLOGACION DEL SERVIVIO LDC_FNURETTIPOEXCEP YA EXISTE.');
end if;  

exception
  when others then
    rollback;
    dbms_output.put_line('Error: ' || sqlerrm);
end;
/
