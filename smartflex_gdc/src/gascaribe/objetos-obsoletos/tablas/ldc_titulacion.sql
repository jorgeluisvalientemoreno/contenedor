-- Create table
create table OPEN.LDC_TITULACION
(
  id_titulacion VARCHAR2(20) not null,
  version       VARCHAR2(100) not null,
  descripcion   VARCHAR2(500) not null,
  id_tipocert   VARCHAR2(1) default 'T' not null,
  id_org_cert   NUMBER(15) not null
)
tablespace TSD_BASICA
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
comment on table OPEN.LDC_TITULACION
  is 'LDC_TITULACION';
-- Add comments to the columns 
comment on column OPEN.LDC_TITULACION.id_titulacion
  is 'Identificador de la titulacion';
comment on column OPEN.LDC_TITULACION.version
  is 'Version de la titulacion';
comment on column OPEN.LDC_TITULACION.descripcion
  is 'Descripcion de titulacion';
comment on column OPEN.LDC_TITULACION.id_tipocert
  is 'Tipo de certificacion';
comment on column OPEN.LDC_TITULACION.id_org_cert
  is 'Organismo certificador';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_TITULACION
  add constraint PK_LDC_TITULACION primary key (ID_ORG_CERT, ID_TITULACION)
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
alter table OPEN.LDC_TITULACION
  add constraint FK_LDC_TITULACION foreign key (ID_TIPOCERT)
  references OPEN.LDC_TIPOCERT (ID_TIPOCERT);
alter table OPEN.LDC_TITULACION
  add constraint FK_LDC_TITULACION2 foreign key (ID_ORG_CERT)
  references OPEN.LDC_ORG_CERT (ID_ORG_CERT);
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_TITULACION to CONSULTA;
grant select on OPEN.LDC_TITULACION to MIGRA;
grant insert, update, delete on OPEN.LDC_TITULACION to RDMLOPEN;
grant select on OPEN.LDC_TITULACION to RSELOPEN;
grant select on OPEN.LDC_TITULACION to RSELSYS;
grant select on OPEN.LDC_TITULACION to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_TITULACION to SYSTEM_OBJ_PRIVS_ROLE;
