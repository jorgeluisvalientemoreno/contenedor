-- Create table
create table OPEN.LDC_DATOS_ACTUALIZAR
(
  package_id   NUMBER(15),
  old_name     VARCHAR2(100),
  new_name     VARCHAR2(100),
  old_lastname VARCHAR2(100),
  new_lastname VARCHAR2(100),
  new_ident    VARCHAR2(20),
  old_ident    VARCHAR2(20),
  tipo_cambio  VARCHAR2(20),
  tagname      VARCHAR2(100),
  tagnamemot   VARCHAR2(100),
  packtypeid   VARCHAR2(20),
  idcliente    VARCHAR2(20),
  idcontrato   NUMBER(8)
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 2M
    next 2M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Add comments to the table 
comment on table OPEN.LDC_DATOS_ACTUALIZAR
  is 'LDC - Datos por actualziar';
-- Add comments to the columns 
comment on column OPEN.LDC_DATOS_ACTUALIZAR.package_id
  is 'Solicitud';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.old_name
  is 'Nombre actual en el sistema';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.new_name
  is 'Nombre nuevo';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.old_lastname
  is 'Apellido actual en el sistema';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.new_lastname
  is 'Apellido nuevo';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.new_ident
  is 'Identificaci?n nuevo';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.old_ident
  is 'Identificaci?n actual en el sistema';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.tipo_cambio
  is 'Tipo de Cambio';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.tagname
  is 'Tag de la solicitud';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.tagnamemot
  is 'Tag del Motivo';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.packtypeid
  is 'Tipo de solicitud a crear';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.idcliente
  is 'Identificador del cliente';
comment on column OPEN.LDC_DATOS_ACTUALIZAR.idcontrato
  is 'Identificador del contrato';
-- Create/Recreate indexes 
create index OPEN.IDX_LDC_DATOS_ACTUALIZAR01 on OPEN.LDC_DATOS_ACTUALIZAR (PACKAGE_ID)
  tablespace TSI_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 2M
    next 2M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Grant/Revoke object privileges 
grant select, insert, update, delete on OPEN.LDC_DATOS_ACTUALIZAR to REPORTES;
grant select on OPEN.LDC_DATOS_ACTUALIZAR to RSELOPEN;
grant select on OPEN.LDC_DATOS_ACTUALIZAR to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_DATOS_ACTUALIZAR to SYSTEM_OBJ_PRIVS_ROLE;
