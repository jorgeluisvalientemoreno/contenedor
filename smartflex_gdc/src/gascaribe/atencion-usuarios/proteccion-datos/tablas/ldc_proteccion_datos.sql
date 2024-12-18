-- Add/modify columns 
alter table LDC_PROTECCION_DATOS add proteccion_datos_id number(20);
-- Add comments to the columns 
comment on column LDC_PROTECCION_DATOS.proteccion_datos_id
  is 'Id de la tabla';
/
declare
  cursor cuProteccionDatos is
  select d.rowid nuId, rownum fila
  from open.ldc_proteccion_Datos d
  order by d.fecha_creacion;
  nuRegistros number:=0;
begin
  	for reg in cuProteccionDatos loop
       update ldc_proteccion_Datos r set r.proteccion_datos_id=reg.fila where r.rowid=reg.nuId;
       nuRegistros:=nuRegistros+1;
       if nuRegistros = 100 then
         commit;
         nuRegistros:=0;
       end if;
    end loop;
    commit;
end;
/
-- Create/Recreate primary, unique and foreign key constraints 

alter table LDC_PROTECCION_DATOS
  add constraint PK_LDC_PROTECCION_DATOS primary key (PROTECCION_DATOS_ID);
/