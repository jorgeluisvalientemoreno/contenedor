-- Create table
create table OPEN.LDC_PRODUCT_RED
(
  product_id  NUMBER(15) not null,
  type_red_id NUMBER(10) not null
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the columns 
comment on column OPEN.LDC_PRODUCT_RED.product_id
  is 'Cdigo del producto.';
comment on column OPEN.LDC_PRODUCT_RED.type_red_id
  is 'Codigo de tipo de red.';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_PRODUCT_RED
  add primary key (PRODUCT_ID)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_PRODUCT_RED to REPORTES;
grant select on OPEN.LDC_PRODUCT_RED to RSELOPEN;
grant select on OPEN.LDC_PRODUCT_RED to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_PRODUCT_RED to SYSTEM_OBJ_PRIVS_ROLE;
