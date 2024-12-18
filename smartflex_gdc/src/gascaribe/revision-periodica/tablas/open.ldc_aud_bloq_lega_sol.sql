create table OPEN.LDC_AUD_BLOQ_LEGA_SOL
(
  package_id NUMBER(15),
  order_id   NUMBER(15),
  usuario    VARCHAR2(40),
  fecha      DATE,
  maquina    VARCHAR2(100)
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
comment on table OPEN.LDC_AUD_BLOQ_LEGA_SOL
  is 'AUDITORIA DE BLOQUEO PARA ASIGNACION ASIGNACION DE ORDENES';
-- Add comments to the columns 
comment on column OPEN.LDC_AUD_BLOQ_LEGA_SOL.package_id
  is 'SOLICITUD';
comment on column OPEN.LDC_AUD_BLOQ_LEGA_SOL.order_id
  is 'ORDEN';
comment on column OPEN.LDC_AUD_BLOQ_LEGA_SOL.usuario
  is 'USUARIO';
comment on column OPEN.LDC_AUD_BLOQ_LEGA_SOL.fecha
  is 'FECHA';
comment on column OPEN.LDC_AUD_BLOQ_LEGA_SOL.maquina
  is 'MAQUINA';
-- Grant/Revoke object privileges 
grant select, insert, delete on OPEN.LDC_AUD_BLOQ_LEGA_SOL to PERSONALIZACIONES;
grant select on OPEN.LDC_AUD_BLOQ_LEGA_SOL to REPORTES;
grant select on OPEN.LDC_AUD_BLOQ_LEGA_SOL to RSELOPEN;
grant select, insert, update, delete, alter on OPEN.LDC_AUD_BLOQ_LEGA_SOL to SYSTEM_OBJ_PRIVS_ROLE;