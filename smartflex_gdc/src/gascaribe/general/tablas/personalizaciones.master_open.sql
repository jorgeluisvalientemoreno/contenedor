declare 
    nuExiste number;
begin
  select count(1)
  into nuExiste
  from dba_tables
  where owner='PERSONALIZACIONES'
   and table_name='MASTER_OPEN';

   if nuExiste > 0 then 
    execute immediate 'DROP TABLE PERSONALIZACIONES.MASTER_OPEN';
   end if;

   execute immediate 'create table PERSONALIZACIONES.MASTER_OPEN
(
  tipo_open   VARCHAR2(100),
  nombre      VARCHAR2(100),
  object_type VARCHAR2(100),
  observacion VARCHAR2(100) default ''MASTER OPEN''
)';

 BEGIN
      pkg_utilidades.prAplicarPermisos('MASTER_OPEN', 'PERSONALIZACIONES');
    END;

end;
/