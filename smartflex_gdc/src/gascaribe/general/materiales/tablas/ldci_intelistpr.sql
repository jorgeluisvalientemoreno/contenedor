-- Create table
create table OPEN.LDCI_INTELISTPR
(
  codigo           NUMBER(15) not null,
  descripcion      VARCHAR2(100),
  fecha_ini_vigen  DATE,
  fecha_final_vige DATE,
  fecha_registro   DATE,
  fecha_procesado  DATE,
  usuario          VARCHAR2(100),
  estado           VARCHAR2(2),
  mensaje          VARCHAR2(4000)
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
comment on table OPEN.LDCI_INTELISTPR
  is 'TABLA MAESTRO INTERFAZ LISTAS DE PRECIO';
-- Add comments to the columns 
comment on column OPEN.LDCI_INTELISTPR.codigo
  is 'CODIGO DE INTERFAZ DE LISTAS';
comment on column OPEN.LDCI_INTELISTPR.descripcion
  is 'DESCRIPCION';
comment on column OPEN.LDCI_INTELISTPR.fecha_ini_vigen
  is 'FECHA INICIAL DE VIGENCIA LISTAS';
comment on column OPEN.LDCI_INTELISTPR.fecha_final_vige
  is 'FECHA FINAL DE VIGENCIA LISTAS';
comment on column OPEN.LDCI_INTELISTPR.fecha_registro
  is 'FECHA DE REGISTRO';
comment on column OPEN.LDCI_INTELISTPR.fecha_procesado
  is 'FECHA EN QUE SE PROCESO EL REGISTRO';
comment on column OPEN.LDCI_INTELISTPR.usuario
  is 'USUARIO';
comment on column OPEN.LDCI_INTELISTPR.estado
  is 'ESTADO DEL REGISTRO 1(REGISTRADO), 2(ERROR),3(PROCESADO)';
comment on column OPEN.LDCI_INTELISTPR.mensaje
  is 'RESULTADO DEL PROCESAMIENTO';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDCI_INTELISTPR
  add constraint LDCI_INTELISTPR_PK primary key (CODIGO)
  using index 
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
grant select on OPEN.LDCI_INTELISTPR to REPORTES;
grant select on OPEN.LDCI_INTELISTPR to ROLESELOPEN;
grant select, insert, update, delete, alter on OPEN.LDCI_INTELISTPR to SYSTEM_OBJ_PRIVS_ROLE;
