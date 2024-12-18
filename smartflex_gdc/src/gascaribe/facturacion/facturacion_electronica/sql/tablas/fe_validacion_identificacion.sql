-- Create table
create table FE_VALIDACION_IDENTIFICACION
(
  id_cliente     NUMBER(10),
  ident_anterior VARCHAR2(15),
  ident_nueva    VARCHAR2(15),
  valido         VARCHAR2(2),
  observacion    VARCHAR2(200)
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table FE_VALIDACION_IDENTIFICACION
  is 'TABLA PARA GUARDAR LAS IDENTIFICACIONES VALIDADAS PARA FACT ELECTRONICA';
-- Add comments to the columns 
comment on column FE_VALIDACION_IDENTIFICACION.id_cliente
  is 'ID Del suscriptor de la tabla ge_subscriber';
comment on column FE_VALIDACION_IDENTIFICACION.ident_anterior
  is 'Identificacion que viene de ser validada';
comment on column FE_VALIDACION_IDENTIFICACION.ident_nueva
  is 'Identificacion corregida';
comment on column FE_VALIDACION_IDENTIFICACION.valido
  is 'Flag que indica si la identificacion esta validada';
comment on column FE_VALIDACION_IDENTIFICACION.observacion
  is 'Observacion luego de la validacion';
-- Create/Recreate indexes 
create index IDX_IDEN_VALIDO on FE_VALIDACION_IDENTIFICACION (ID_CLIENTE, VALIDO)
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;