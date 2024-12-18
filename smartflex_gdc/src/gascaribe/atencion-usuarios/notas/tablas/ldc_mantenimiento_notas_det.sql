-- Create table
create table OPEN.LDC_MANTENIMIENTO_NOTAS_DET
(
  cuenta_cobro NUMBER(10),
  producto     NUMBER(10),
  concepto     NUMBER(4),
  signo        VARCHAR2(2),
  valor        NUMBER(13,2),
  sesion       NUMBER,
  causa_cargo  NUMBER(2)
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
comment on table OPEN.LDC_MANTENIMIENTO_NOTAS_DET
  is 'Cargos a crear en la aprobacion';
-- Add comments to the columns 
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.cuenta_cobro
  is 'Cuenta de Cobro';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.producto
  is 'Servicio Suscrito';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.concepto
  is 'Concepto';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.signo
  is 'signo';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.valor
  is 'Valor del Cargo';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.sesion
  is 'Sesion';
comment on column OPEN.LDC_MANTENIMIENTO_NOTAS_DET.causa_cargo
  is 'Causa cargo';
-- Grant/Revoke object privileges 
grant insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RDMLOPEN;
grant select, insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to REPORTES;
grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to ROLESELOPEN;
grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELOPEN;
grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELSYS;
grant select on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_MANTENIMIENTO_NOTAS_DET to SYSTEM_OBJ_PRIVS_ROLE;
