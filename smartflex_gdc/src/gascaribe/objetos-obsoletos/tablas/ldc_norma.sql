-- Create table
create table OPEN.LDC_NORMA
(
  id_norma      VARCHAR2(20) not null,
  descripcion   VARCHAR2(500) not null,
  mate_const    VARCHAR2(100) not null,
  id_titulacion VARCHAR2(20) not null,
  id_tipocert   VARCHAR2(1) default 'N' not null,
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
comment on table OPEN.LDC_NORMA
  is 'LDC_NORMAs';
-- Add comments to the columns 
comment on column OPEN.LDC_NORMA.id_norma
  is 'Identificador de la norma';
comment on column OPEN.LDC_NORMA.descripcion
  is 'Descripcion de la norma';
comment on column OPEN.LDC_NORMA.mate_const
  is 'Material de construccion';
comment on column OPEN.LDC_NORMA.id_titulacion
  is 'Identificador de la titulacion';
comment on column OPEN.LDC_NORMA.id_tipocert
  is 'Tipo de certificado';
comment on column OPEN.LDC_NORMA.id_org_cert
  is 'Organismo certificador';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_NORMA
  add constraint PK_LDC_NORMA primary key (ID_NORMA, ID_ORG_CERT, ID_TITULACION)
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
alter table OPEN.LDC_NORMA
  add constraint FK_LDC_NORMA foreign key (ID_ORG_CERT, ID_TITULACION)
  references OPEN.LDC_TITULACION (ID_ORG_CERT, ID_TITULACION);
alter table OPEN.LDC_NORMA
  add constraint FK_LDC_NORMA2 foreign key (ID_TIPOCERT)
  references OPEN.LDC_TIPOCERT (ID_TIPOCERT);
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_NORMA to CONSULTA;
grant select on OPEN.LDC_NORMA to MIGRA;
grant insert, update, delete on OPEN.LDC_NORMA to RDMLOPEN;
grant select on OPEN.LDC_NORMA to RSELOPEN;
grant select on OPEN.LDC_NORMA to RSELSYS;
grant select on OPEN.LDC_NORMA to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_NORMA to SYSTEM_OBJ_PRIVS_ROLE;
