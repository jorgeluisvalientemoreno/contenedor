-- Create table
create table OPEN.LDC_PER_COMERCIAL
(
  percanio NUMBER(4) not null,
  percmes  NUMBER(2) not null,
  percrfin DATE,
  percrffi DATE
)
tablespace TSD_BASICA
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Add comments to the table 
comment on table OPEN.LDC_PER_COMERCIAL
  is 'DEFINE EL PERIODO COMERCIAL';
-- Add comments to the columns 
comment on column OPEN.LDC_PER_COMERCIAL.percanio
  is 'A?o del Periodo comercial';
comment on column OPEN.LDC_PER_COMERCIAL.percmes
  is 'Mes del Periodo comercial';
comment on column OPEN.LDC_PER_COMERCIAL.percrfin
  is 'Fecha inicial del periodo comercial';
comment on column OPEN.LDC_PER_COMERCIAL.percrffi
  is 'Fecha final del periodo comercial';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_PER_COMERCIAL
  add constraint PK_PER_COMERCIAL_KEY primary key (PERCANIO, PERCMES)
  using index 
  tablespace TSI_BASICA
  pctfree 5
  initrans 2
  maxtrans 255
  storage
  (
    initial 16K
    next 8K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_PER_COMERCIAL to MIGRA;
grant insert, update, delete on OPEN.LDC_PER_COMERCIAL to RDMLOPEN;
grant select on OPEN.LDC_PER_COMERCIAL to RSELOPEN;
grant select on OPEN.LDC_PER_COMERCIAL to RSELSYS;
grant select on OPEN.LDC_PER_COMERCIAL to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_PER_COMERCIAL to SYSTEM_OBJ_PRIVS_ROLE;
