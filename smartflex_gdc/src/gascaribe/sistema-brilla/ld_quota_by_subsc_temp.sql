-- Create table
create table LD_QUOTA_BY_SUBSC_TEMP
(
  subscription_id NUMBER(8) not null,
  quota_value     NUMBER(15,2) not null
)
tablespace TSD_DATOS
  pctfree 5
  initrans 2
  maxtrans 255
  storage
  (
    initial 20M
    next 20M
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
-- Add comments to the table 
comment on table LD_QUOTA_BY_SUBSC_TEMP
  is 'Cupo por contrato';
-- Add comments to the columns 
comment on column LD_QUOTA_BY_SUBSC_TEMP.subscription_id
  is 'Identificador del contrato';
comment on column LD_QUOTA_BY_SUBSC_TEMP.quota_value
  is 'Valor del cupo asignado';
-- Create/Recreate indexes 
create index IX_LD_QUOTA_BY_SUBSC_TEMP01 on LD_QUOTA_BY_SUBSC_TEMP (SUBSCRIPTION_ID)
  tablespace TSI_DATOS
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table LD_QUOTA_BY_SUBSC_TEMP
  add constraint PK_LD_QUOTA_BY_SUBSC_TEMP primary key (SUBSCRIPTION_ID);
-- Grant/Revoke object privileges 
grant select on LD_QUOTA_BY_SUBSC_TEMP to CARGAS;
grant select on LD_QUOTA_BY_SUBSC_TEMP to CONSULTA;
grant select, insert, update, delete on LD_QUOTA_BY_SUBSC_TEMP to INNOVACION;
grant select on LD_QUOTA_BY_SUBSC_TEMP to MIGRA;
grant select, insert, update, delete on LD_QUOTA_BY_SUBSC_TEMP to RDLBRILLAAPP;
grant insert, update, delete on LD_QUOTA_BY_SUBSC_TEMP to RDMLOPEN;
grant select on LD_QUOTA_BY_SUBSC_TEMP to RSELOPEN;
grant select on LD_QUOTA_BY_SUBSC_TEMP to RSELSYS;
grant select, insert, update, delete on LD_QUOTA_BY_SUBSC_TEMP to SYSTEM_OBJ_PRIVS_ROLE;
/