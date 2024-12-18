-- Create table
create table OPEN.LDC_DATA_ORD_PROGAM
(
  order_id       NUMBER(15) not null,
  programed_date DATE,
  package_id     NUMBER(15),
  address_id     NUMBER(15),
  processed      VARCHAR2(1),
  execution_date DATE
)
tablespace TSD_DEFAULT
  pctfree 10
  initrans 1
  maxtrans 255;
-- Add comments to the table 
comment on table OPEN.LDC_DATA_ORD_PROGAM
  is 'Actividades a asociar a unidades de trabajo bloqueadas';
-- Add comments to the columns 
comment on column OPEN.LDC_DATA_ORD_PROGAM.order_id
  is 'Codigo de la orden que se legalizo';
comment on column OPEN.LDC_DATA_ORD_PROGAM.programed_date
  is 'Fecha programada de ejecucion';
comment on column OPEN.LDC_DATA_ORD_PROGAM.package_id
  is 'Solicitud de la orden';
comment on column OPEN.LDC_DATA_ORD_PROGAM.address_id
  is 'Direccion de la orden';
comment on column OPEN.LDC_DATA_ORD_PROGAM.processed
  is 'Flag de procesada (S/N)';
comment on column OPEN.LDC_DATA_ORD_PROGAM.execution_date
  is 'Fecha de Ejecucion del desbloqueo';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_DATA_ORD_PROGAM
  add constraint PK_LDC_DATA_ORD_PROGAM primary key (ORDER_ID)
  using index 
  tablespace TSD_DEFAULT
  pctfree 10
  initrans 2
  maxtrans 255;
-- Grant/Revoke object privileges 
grant select, insert, update, delete on OPEN.LDC_DATA_ORD_PROGAM to SYSTEM_OBJ_PRIVS_ROLE;
