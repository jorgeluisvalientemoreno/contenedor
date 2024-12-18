-- Create table
create table LDC_CARGOS_LOG_DELETE
(
  cargcuco NUMBER(10),
  cargnuse NUMBER(10),
  cargconc NUMBER(4),
  cargcaca NUMBER(2),
  cargsign VARCHAR2(2),
  cargpefa NUMBER(6),
  cargvalo NUMBER(13,2),
  cargdoso VARCHAR2(30),
  cargcodo NUMBER(10),
  cargusua NUMBER(15),
  cargtipr VARCHAR2(1),
  cargunid NUMBER(15,4),
  cargfecr DATE,
  cargprog NUMBER(4),
  cargcoll NUMBER(9),
  cargpeco NUMBER(15),
  cargtico NUMBER(4),
  cargvabl NUMBER(13,2),
  cargtaco NUMBER(15),
  Usuario_elimina VARCHAR2(30),
  Fecha_Elimina DATE,
  Terminal_Elimina VARCHAR2(100),
  programa varchar2(200)
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
comment on table LDC_CARGOS_LOG_DELETE
  is 'LDC_CARGOS_LOG_DELETE A FACTURAR';
-- Add comments to the columns 
comment on column LDC_CARGOS_LOG_DELETE.cargcuco
  is 'Cuenta de cobro';
comment on column LDC_CARGOS_LOG_DELETE.cargnuse
  is 'Numero del servicio';
comment on column LDC_CARGOS_LOG_DELETE.cargconc
  is 'Concepto';
comment on column LDC_CARGOS_LOG_DELETE.cargcaca
  is 'Causa del cargo';
comment on column LDC_CARGOS_LOG_DELETE.cargsign
  is 'Signo';
comment on column LDC_CARGOS_LOG_DELETE.cargpefa
  is 'Periodo facturacion';
comment on column LDC_CARGOS_LOG_DELETE.cargvalo
  is 'Valor del cargo';
comment on column LDC_CARGOS_LOG_DELETE.cargdoso
  is 'Documento de soporte';
comment on column LDC_CARGOS_LOG_DELETE.cargcodo
  is 'Consecutivo del documento';
comment on column LDC_CARGOS_LOG_DELETE.cargusua
  is 'IDENTIFICADOR USUARIO';
comment on column LDC_CARGOS_LOG_DELETE.cargtipr
  is 'Tipo de proceso (A/M)';
comment on column LDC_CARGOS_LOG_DELETE.cargunid
  is 'Unidades';
comment on column LDC_CARGOS_LOG_DELETE.cargfecr
  is 'Fecha de creacion';
comment on column LDC_CARGOS_LOG_DELETE.cargprog
  is 'PROGRAMA';
comment on column LDC_CARGOS_LOG_DELETE.cargcoll
  is 'Consecutivo de Llamadas';
comment on column LDC_CARGOS_LOG_DELETE.cargpeco
  is 'PERIODO DE CONSUMO';
comment on column LDC_CARGOS_LOG_DELETE.cargtico
  is 'TIPO DE CONSUMO';
comment on column LDC_CARGOS_LOG_DELETE.cargvabl
  is 'Valor Base de Liquidacion';
comment on column LDC_CARGOS_LOG_DELETE.cargtaco
  is 'ID DE LA ENTIDAD TARIFAS POR CONCEPTO';
-- Create/Recreate indexes 
create index IX_LDC_CARGOS_LOG_DELETE01 on LDC_CARGOS_LOG_DELETE (CARGSIGN)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE010 on LDC_CARGOS_LOG_DELETE (CARGDOSO)
  tablespace TSI_CARGOS
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
create index IX_LDC_CARGOS_LOG_DELETE02 on LDC_CARGOS_LOG_DELETE (CARGCUCO)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE03 on LDC_CARGOS_LOG_DELETE (CARGCONC)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE04 on LDC_CARGOS_LOG_DELETE (CARGNUSE)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE05 on LDC_CARGOS_LOG_DELETE (CARGCACA)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE06 on LDC_CARGOS_LOG_DELETE (CARGPEFA)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE07 on LDC_CARGOS_LOG_DELETE (CARGPROG)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_LDC_CARGOS_LOG_DELETE08 on LDC_CARGOS_LOG_DELETE (CARGUSUA)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_CARG_LOG_CODO on LDC_CARGOS_LOG_DELETE (CARGCODO, CARGSIGN)
  tablespace TSI_CARGOS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 256M
    next 8K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
create index IX_CARG_LOG_CUCO_CONC on LDC_CARGOS_LOG_DELETE (CARGCUCO, CARGCONC, CARGSIGN)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_CARG_LOG_NUSE_CUCO_CONC on LDC_CARGOS_LOG_DELETE (CARGNUSE, CARGCUCO, CARGCONC)
  tablespace TSI_CARGOS
  pctfree 10
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
create index IX_CARG_LOG_TEMPORAL on LDC_CARGOS_LOG_DELETE (CARGPECO, CARGNUSE)
  tablespace TSI_BASICA
  pctfree 0
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
  /
-- Grant/Revoke object privileges 
grant select, insert, update, delete on LDC_CARGOS_LOG_DELETE to INNOVACION;
grant select on LDC_CARGOS_LOG_DELETE to INNOVACIONBI;
grant select on LDC_CARGOS_LOG_DELETE to RSELOPEN;
grant select, insert, update, delete on LDC_CARGOS_LOG_DELETE to SYSTEM_OBJ_PRIVS_ROLE;
/