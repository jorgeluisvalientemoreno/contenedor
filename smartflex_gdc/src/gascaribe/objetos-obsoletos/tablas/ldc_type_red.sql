-- Create table
create table OPEN.LDC_TYPE_RED
(
  type_red_id NUMBER(10) not null,
  description VARCHAR2(100) not null
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
comment on column OPEN.LDC_TYPE_RED.type_red_id
  is 'Codigo de tipo de red.';
comment on column OPEN.LDC_TYPE_RED.description
  is 'Descripci??n de tipo de red';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_TYPE_RED
  add primary key (TYPE_RED_ID)
  using index 
  tablespace TSD_DEFAULT
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
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_TYPE_RED to REPORTES;
grant select on OPEN.LDC_TYPE_RED to RSELOPEN;
grant select on OPEN.LDC_TYPE_RED to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_TYPE_RED to SYSTEM_OBJ_PRIVS_ROLE;
