-- Create table
create table OPEN.ldc_logerrleorresu
(
  order_id  NUMBER(10),
  ordepadre NUMBER(10),
  proceso   VARCHAR2(50),
  menserror VARCHAR2(4000),
  fechgene  DATE,
  usuario   VARCHAR2(50),
  id        NUMBER(15) not null
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
comment on table OPEN.LDC_LOGERRLEORRESU
  is 'LOG DE ERROR DE LEGALIZACION DE ORDENES DE RECO Y SUSP ADMIN';
-- Add comments to the columns 
comment on column OPEN.LDC_LOGERRLEORRESU.order_id
  is 'NUMERO DE ORDEN';
comment on column OPEN.LDC_LOGERRLEORRESU.ordepadre
  is 'NUMERO DE ORDEN PADRE';
comment on column OPEN.LDC_LOGERRLEORRESU.proceso
  is 'PROCESO';
comment on column OPEN.LDC_LOGERRLEORRESU.menserror
  is 'ERROR GENERADO';
comment on column OPEN.LDC_LOGERRLEORRESU.fechgene
  is 'FECHA DE GENERACION';
comment on column OPEN.LDC_LOGERRLEORRESU.usuario
  is 'USUARIO';
comment on column OPEN.LDC_LOGERRLEORRESU.id
  is 'ID';
-- Create/Recreate indexes 
create index OPEN.IDX_CONSULOG on OPEN.LDC_LOGERRLEORRESU (PROCESO, FECHGENE, ORDER_ID)
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
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_LOGERRLEORRESU
  add constraint PK_LDC_LOGERRLEORRESU primary key (ID)
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
grant select on OPEN.LDC_LOGERRLEORRESU to ROLE_DESARROLLOOSF;
grant select on OPEN.LDC_LOGERRLEORRESU to RSELOPEN;
grant select, insert, update, delete, alter on OPEN.LDC_LOGERRLEORRESU to SYSTEM_OBJ_PRIVS_ROLE;
