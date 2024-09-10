-- Create table
create table CONTROLREGISTRO
(
  contregi_id      NUMBER not null,
  tipoconre_id     NUMBER,
  cliente_id       NUMBER,
  contacto_id      NUMBER,
  dependencia_id   NUMBER,
  n1_id            NUMBER,
  fecha_creacion   DATE,
  fecha_asignacion DATE,
  fecha_cotizacion DATE,
  fecha_aprobacion DATE,
  fecha_entrega    DATE,
  version_         NUMBER,
  observacion      VARCHAR2(4000),
  estado_id        NUMBER
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table CONTROLREGISTRO
  is 'CONTROL DE REGISTRO PARA DESARROLLO';
-- Add comments to the columns 
comment on column CONTROLREGISTRO.contregi_id
  is 'CODIGO';
comment on column CONTROLREGISTRO.tipoconre_id
  is 'TIPO';
comment on column CONTROLREGISTRO.cliente_id
  is 'CODIGO CLIENTE';
comment on column CONTROLREGISTRO.contacto_id
  is 'CODIGO CONTACTO';
comment on column CONTROLREGISTRO.dependencia_id
  is 'CODIGO DEPENDENCIA';
comment on column CONTROLREGISTRO.n1_id
  is 'CODIGO N1';
comment on column CONTROLREGISTRO.fecha_creacion
  is 'FECHA CREACION';
comment on column CONTROLREGISTRO.fecha_asignacion
  is 'FECHA ASIGNACION';
comment on column CONTROLREGISTRO.fecha_cotizacion
  is 'FECHA COTIZACION';
comment on column CONTROLREGISTRO.fecha_aprobacion
  is 'FECHA APROBACION';
comment on column CONTROLREGISTRO.fecha_entrega
  is 'FECHA ENTREGA';
comment on column CONTROLREGISTRO.version_
  is 'VERSION';
comment on column CONTROLREGISTRO.observacion
  is 'OBSERVACION';
comment on column CONTROLREGISTRO.estado_id
  is 'CODIGO ESTADO';
-- Create/Recreate primary, unique and foreign key constraints 
alter table CONTROLREGISTRO
  add constraint PKCONTREGIID primary key (CONTREGI_ID)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
