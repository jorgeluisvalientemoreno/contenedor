-- Create table
create table OPEN.LDC_ENCUESTA
(
  orden_id          NUMBER(15) not null,
  grupo_pregunta_id NUMBER(4) not null,
  pregunta_id       NUMBER(4) not null,
  respuesta         VARCHAR2(200) not null
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
comment on table OPEN.LDC_ENCUESTA
  is 'Respuestas a las encuestas por Orden de Trabajo';
-- Add comments to the columns 
comment on column OPEN.LDC_ENCUESTA.orden_id
  is 'Codigo de la Orden de Trabajo';
comment on column OPEN.LDC_ENCUESTA.grupo_pregunta_id
  is 'Codigo del Grupo de Preguntas';
comment on column OPEN.LDC_ENCUESTA.pregunta_id
  is 'Codigo de la pregunta';
comment on column OPEN.LDC_ENCUESTA.respuesta
  is 'Respuesta a la pregunta';
-- Create/Recreate primary, unique and foreign key constraints 
alter table OPEN.LDC_ENCUESTA
  add constraint PK_LDC_ENCUESTA primary key (ORDEN_ID, GRUPO_PREGUNTA_ID, PREGUNTA_ID, RESPUESTA)
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
alter table OPEN.LDC_ENCUESTA
  add constraint FK_ENCUESTA_PREG_GRUP foreign key (GRUPO_PREGUNTA_ID, PREGUNTA_ID)
  references OPEN.LDC_PREGUNTA_GRUPO (GRUPO_PREGUNTA_ID, PREGUNTA_ID);
-- Grant/Revoke object privileges 
grant select on OPEN.LDC_ENCUESTA to MIGRA;
grant insert, update, delete on OPEN.LDC_ENCUESTA to RDMLOPEN;
grant select on OPEN.LDC_ENCUESTA to RSELOPEN;
grant select on OPEN.LDC_ENCUESTA to RSELUSELOPEN;
grant select, insert, update, delete on OPEN.LDC_ENCUESTA to SYSTEM_OBJ_PRIVS_ROLE;
