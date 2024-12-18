-- Create table
create table OPEN.LDC_CERTIFICADO
(
  id_certificado   NUMBER(15) not null,
  id_org_cert      NUMBER(15) not null,
  unidad_operativa NUMBER(15) not null,
  tecnico_unidad   NUMBER(15) not null,
  codigo_rufi_tec  NUMBER(15) not null,
  codigo_rufi_con  NUMBER(15) not null,
  tipo_certificado VARCHAR2(1),
  fecha_ini_vig    DATE not null,
  fecha_fin_vig    DATE not null,
  flag_activo      VARCHAR2(1),
  id_norma         VARCHAR2(20),
  id_titulacion    VARCHAR2(20)
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
comment on table OPEN.LDC_CERTIFICADO
  is 'LDC_certificado';
-- Add comments to the columns 
comment on column OPEN.LDC_CERTIFICADO.id_certificado
  is 'Identificador del certificado';
comment on column OPEN.LDC_CERTIFICADO.id_org_cert
  is 'Organismo certificador';
comment on column OPEN.LDC_CERTIFICADO.unidad_operativa
  is 'Unidad operativa';
comment on column OPEN.LDC_CERTIFICADO.tecnico_unidad
  is 'Tecnico unidad operativa';
comment on column OPEN.LDC_CERTIFICADO.codigo_rufi_tec
  is 'Tecnico rufi';
comment on column OPEN.LDC_CERTIFICADO.codigo_rufi_con
  is 'Contratista rufi';
comment on column OPEN.LDC_CERTIFICADO.tipo_certificado
  is 'Tipo certificado';
comment on column OPEN.LDC_CERTIFICADO.fecha_ini_vig
  is 'Fecha inicial de vigencia';
comment on column OPEN.LDC_CERTIFICADO.fecha_fin_vig
  is 'Fecha final de vigencia';
comment on column OPEN.LDC_CERTIFICADO.flag_activo
  is 'Activo S(i) o N(o)';
comment on column OPEN.LDC_CERTIFICADO.id_norma
  is 'Norma';
comment on column OPEN.LDC_CERTIFICADO.id_titulacion
  is 'Titulacion';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_CERTIFICADO
  add constraint PK_LDC_CERTIFICADO primary key (ID_CERTIFICADO)
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
alter table OPEN.LDC_CERTIFICADO
  add constraint FK_LDC_CERTIFICADO2 foreign key (TECNICO_UNIDAD)
  references OPEN.GE_PERSON (PERSON_ID);
alter table OPEN.LDC_CERTIFICADO
  add constraint FK_LDC_CERTIFICADO4 foreign key (ID_ORG_CERT, ID_TITULACION)
  references OPEN.LDC_TITULACION (ID_ORG_CERT, ID_TITULACION);
-- Create/Recreate check constraints 
alter table OPEN.LDC_CERTIFICADO
  add constraint CK_LDC_CERTIFICADO
  check (TIPO_certificado in ('t','T','N','n'));
alter table OPEN.LDC_CERTIFICADO
  add constraint CK_LDC_CERTIFICADO2
  check (FLAG_ACTIVO in ('S','s','N','n'));
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_CERTIFICADO to CONSULTA;
grant select on OPEN.LDC_CERTIFICADO to MIGRA;
grant insert, update, delete on OPEN.LDC_CERTIFICADO to RDMLOPEN;
grant select on OPEN.LDC_CERTIFICADO to RSELOPEN;
grant select on OPEN.LDC_CERTIFICADO to RSELSYS;
grant select on OPEN.LDC_CERTIFICADO to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_CERTIFICADO to SYSTEM_OBJ_PRIVS_ROLE;
