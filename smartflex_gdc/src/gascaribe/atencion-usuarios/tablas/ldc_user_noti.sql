-- Create table
create table OPEN.LDC_USER_NOTI
(
  product_id  NUMBER(15) not null,
  correo      VARCHAR2(200) not null,
  notificable VARCHAR2(1) not null
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
-- Add comments to the columns 
comment on column OPEN.LDC_USER_NOTI.product_id
  is 'Código del producto.';
comment on column OPEN.LDC_USER_NOTI.correo
  is 'Correo electrónico.';
comment on column OPEN.LDC_USER_NOTI.notificable
  is 'Autoriza notificación';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_USER_NOTI
  add primary key (PRODUCT_ID)
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
/

