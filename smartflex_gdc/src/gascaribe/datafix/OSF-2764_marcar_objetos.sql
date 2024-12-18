begin
update master_personalizaciones
set comentario = 'BORRADO'
where nombre in
(
    'LDCI_PKCONTROLNOTIFICAINTEGRA',
    'OS_EMERGENCY_ORDER'

);
insert into master_personalizaciones(esquema, nombre, tipo_objeto, comentario)
select owner esquema,
       object_name nombre, 
       object_type tipo_objeto,
       'BORRADO' comentario
from dba_objects
where object_name in ('GCFIFA_CT49E121148800','GCFIFA_CT49E121148798','GCFIFA_CT49E121148799','GCFIFA_CT49E121148801','GCFIFA_CT49E121148802','LDC_DETALLEFACT_SURTIGAS')
 and not exists(select null from open.master_personalizaciones p where p.nombre=object_name)
 and object_type not in ('PACKAGE BODY');
 commit;
end;
/