-- Create table
create table OPEN.LDC_LOG_PRODUCT_RED
(
  log_product_red_id NUMBER(10) not null,
  product_id         NUMBER(15) not null,
  type_red_ant       NUMBER(10),
  type_red_act       NUMBER(10) not null,
  fecha              DATE,
  usuario            VARCHAR2(100),
  terminal           VARCHAR2(100) not null
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the columns 
comment on column OPEN.LDC_LOG_PRODUCT_RED.log_product_red_id
  is 'C??digo de la tabla.';
comment on column OPEN.LDC_LOG_PRODUCT_RED.product_id
  is 'Codigo del producto.';
comment on column OPEN.LDC_LOG_PRODUCT_RED.type_red_ant
  is 'Tipo de red anterior';
comment on column OPEN.LDC_LOG_PRODUCT_RED.type_red_act
  is 'Tipo de red actual';
comment on column OPEN.LDC_LOG_PRODUCT_RED.fecha
  is 'Fecha de registro';
comment on column OPEN.LDC_LOG_PRODUCT_RED.usuario
  is 'Usuario que registr?? el producto.';
comment on column OPEN.LDC_LOG_PRODUCT_RED.terminal
  is 'Terminal donde se registr?? la modificaci??n';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_LOG_PRODUCT_RED
  add primary key (LOG_PRODUCT_RED_ID)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_LOG_PRODUCT_RED to REPORTES;
grant select on OPEN.LDC_LOG_PRODUCT_RED to RSELOPEN;
grant select on OPEN.LDC_LOG_PRODUCT_RED to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_LOG_PRODUCT_RED to SYSTEM_OBJ_PRIVS_ROLE;
