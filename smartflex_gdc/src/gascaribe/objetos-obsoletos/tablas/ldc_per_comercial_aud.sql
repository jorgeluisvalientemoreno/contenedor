-- Create table
create table OPEN.LDC_PER_COMERCIAL_AUD
(
  pcauoper VARCHAR2(10) not null,
  pcaufemo DATE not null,
  pcauusua VARCHAR2(30) not null,
  pcauterm VARCHAR2(30),
  pcauanio NUMBER(4) not null,
  pcaumes  NUMBER(2) not null,
  pcaufior DATE,
  pcaufinu DATE,
  pcauffor DATE,
  pcauffnu DATE
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
comment on table OPEN.LDC_PER_COMERCIAL_AUD
  is 'Auditoria de INSERT, UPDATE y DELETE de registros tabla LDC_PER_COMERCIAL';
-- Add comments to the columns 
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauoper
  is 'Operacion Realizada';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcaufemo
  is 'Fecha Operacion';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauusua
  is 'Usuario Modifico';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauterm
  is 'Terminal';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauanio
  is 'A?o del Periodo';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcaumes
  is 'Mes del Periodo';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcaufior
  is 'Fecha Inicial Original';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcaufinu
  is 'Fecha Inicial Nueva';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauffor
  is 'Fecha Final Original';
comment on column OPEN.LDC_PER_COMERCIAL_AUD.pcauffnu
  is 'Fecha Final Nueva';
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_PER_COMERCIAL_AUD to MIGRA;
grant insert, update, delete on OPEN.LDC_PER_COMERCIAL_AUD to RDMLOPEN;
grant select on OPEN.LDC_PER_COMERCIAL_AUD to RSELOPEN;
grant select on OPEN.LDC_PER_COMERCIAL_AUD to RSELSYS;
grant select on OPEN.LDC_PER_COMERCIAL_AUD to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_PER_COMERCIAL_AUD to SYSTEM_OBJ_PRIVS_ROLE;
