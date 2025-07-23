-- Create table
create table OPEN.LDC_GRUPO_LOCALIDAD
(
  grlocodi NUMBER(15) not null,
  grupcodi NUMBER(15) not null,
  grloidlo NUMBER(6) not null,
  grloseop NUMBER(6)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_GRUPO_LOCALIDAD
  add constraint PK_LDC_GRUPO_LOCALIDAD primary key (GRLOCODI)
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
alter table OPEN.LDC_GRUPO_LOCALIDAD
  add constraint FK_LDC_GRUP_GRUP_LOCLI foreign key (GRUPCODI)
  references OPEN.LDC_GRUPO (GRUPCODI);
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_GRUPO_LOCALIDAD to REPORTES;
grant select on OPEN.LDC_GRUPO_LOCALIDAD to ROLESELOPEN;
grant select on OPEN.LDC_GRUPO_LOCALIDAD to RSELOPEN;
grant select on OPEN.LDC_GRUPO_LOCALIDAD to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_GRUPO_LOCALIDAD to SYSTEM_OBJ_PRIVS_ROLE;
/