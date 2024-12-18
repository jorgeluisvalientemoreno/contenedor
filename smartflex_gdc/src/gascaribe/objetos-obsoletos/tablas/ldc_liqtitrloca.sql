-- Create table
create table OPEN.LDC_LIQTITRLOCA
(
  id_registro       NUMBER(15) not null,
  tipo_contrato_adm NUMBER(15) not null,
  actividad_pago    NUMBER(15) not null,
  item_pago         NUMBER(15) not null,
  departamento      NUMBER(6) not null,
  localidad         NUMBER(6) not null,
  porcentaje_fijo   NUMBER(15,4) not null
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table OPEN.LDC_LIQTITRLOCA
  is 'Configuracion tipos de contratos administrativos x localidad';
-- Add comments to the columns 
comment on column OPEN.LDC_LIQTITRLOCA.id_registro
  is 'ID';
comment on column OPEN.LDC_LIQTITRLOCA.tipo_contrato_adm
  is 'TIPO CONTRATO ADMINISTRATIVO';
comment on column OPEN.LDC_LIQTITRLOCA.actividad_pago
  is 'ACTIVIDAD PAGO';
comment on column OPEN.LDC_LIQTITRLOCA.item_pago
  is 'ITEM PAGO';
comment on column OPEN.LDC_LIQTITRLOCA.departamento
  is 'DEPARTAMENTO';
comment on column OPEN.LDC_LIQTITRLOCA.localidad
  is 'LOCALIDAD';
comment on column OPEN.LDC_LIQTITRLOCA.porcentaje_fijo
  is 'PORCENTAJE FIJO';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_PK primary key (ID_REGISTRO)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_UK unique (TIPO_CONTRATO_ADM, ACTIVIDAD_PAGO, DEPARTAMENTO, LOCALIDAD)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_FK foreign key (TIPO_CONTRATO_ADM)
  references OPEN.LDC_TIPOCON_ADMINISTRATIVO (ID_TIPOCONTRATO);
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_FK2 foreign key (DEPARTAMENTO)
  references OPEN.GE_GEOGRA_LOCATION (GEOGRAP_LOCATION_ID);
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_FK3 foreign key (LOCALIDAD)
  references OPEN.GE_GEOGRA_LOCATION (GEOGRAP_LOCATION_ID);
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_FK4 foreign key (ACTIVIDAD_PAGO)
  references OPEN.GE_ITEMS (ITEMS_ID);
alter table OPEN.LDC_LIQTITRLOCA
  add constraint LDC_LIQTITRLOCA_FK5 foreign key (ITEM_PAGO)
  references OPEN.GE_ITEMS (ITEMS_ID);
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_LIQTITRLOCA to REPORTES;
grant select, insert, update, delete, alter on OPEN.LDC_LIQTITRLOCA to SYSTEM_OBJ_PRIVS_ROLE;
