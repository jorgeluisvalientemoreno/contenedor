-- Create table
create table OPEN.LDC_ATECLIREPO
(
  ateclirepo_id    NUMBER(10) not null,
  tipo_reporte     VARCHAR2(2) not null,
  ano_reporte      NUMBER(4) not null,
  mes_reporte      NUMBER(2) not null,
  fecha_aprobacion DATE,
  aprobado         VARCHAR2(1) not null
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
comment on table OPEN.LDC_ATECLIREPO
  is 'Reportes de atencion al cliente';
-- Add comments to the columns 
comment on column OPEN.LDC_ATECLIREPO.ateclirepo_id
  is 'Identificador del Reporte';
comment on column OPEN.LDC_ATECLIREPO.tipo_reporte
  is 'Tipo de reporte formato [A, B, I ] anexo A, anexo B, Itansuca';
comment on column OPEN.LDC_ATECLIREPO.ano_reporte
  is 'A?o del reporte';
comment on column OPEN.LDC_ATECLIREPO.mes_reporte
  is 'Mes del reporte';
comment on column OPEN.LDC_ATECLIREPO.fecha_aprobacion
  is 'Fecha de aprobacion';
comment on column OPEN.LDC_ATECLIREPO.aprobado
  is 'Flag de aprobacion SI[S] NO[N]';
-- Create/Recreate indexes 
create unique index OPEN.LDC_ATECLIREPO_IDX on OPEN.LDC_ATECLIREPO (TIPO_REPORTE, ANO_REPORTE, MES_REPORTE)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_ATECLIREPO
  add constraint LDC_ATECLIREPO_PK primary key (ATECLIREPO_ID)
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
-- Create/Recreate check constraints 
alter table OPEN.LDC_ATECLIREPO
  add constraint CK_APROBADO
  check (APROBADO in ('S','N'));
alter table OPEN.LDC_ATECLIREPO
  add constraint CK_TIPO_REPORTE
  check (TIPO_REPORTE in ('A','B','I'));
