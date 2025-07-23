DECLARE
  nuConta NUMBER;
BEGIN

  SELECT COUNT(*)
    INTO nuConta
    FROM dba_tables
   WHERE table_name = 'LDCI_TRANSOMA'
     AND OWNER = 'OPEN';

  IF nuConta = 0 THEN
  
    -- Create table
    EXECUTE IMMEDIATE 'create table OPEN.LDCI_TRANSOMA
(
  trsmcodi NUMBER(11) not null,
  trsmcont NUMBER(4),
  trsmprov NUMBER(15),
  trsmunop NUMBER(15),
  trsmfecr DATE,
  trsmesta NUMBER(1),
  trsmofve VARCHAR2(4),
  trsmvtot NUMBER(13),
  trsmdore NUMBER(11),
  trsmdsre VARCHAR2(18),
  trsmmdpe VARCHAR2(4),
  trsmusmo VARCHAR2(200),
  trsmmpdi NUMBER(8),
  trsmacti VARCHAR2(1) default ''N'',
  trsmsol  VARCHAR2(11),
  trsmtipo NUMBER(4),
  trsmprog VARCHAR2(100),
  order_id NUMBER(15),
  trsmobse VARCHAR2(2000),
  trsmcome VARCHAR2(2000)
)';
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmcodi is ''CODIGO NRO. FRONT Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmcont is ''CODIGO DEL CONTRATISTA Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmprov is ''CENTRO A SOLICITAR (unidad operativa clasificacion Proveedor Logistico) Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmunop is ''CODIGO DE LA UNIDAD OPERATIVA ASOCIADA AL CONTRATISTA SELECCIONADO Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmfecr is ''FECHA DE RECIBIDO Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmesta is ''ESTADO 1- CREADO, 2- ENVIADO. 3 RECIBIDO, 4- ANULADO Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmofve is ''OFICINA DE VENTA Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmvtot is ''VALOR TOTAL Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmdore is ''DOCUMENTO RELACIONADO  Devoluciones''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmdsre is ''DOCUMENTO SAP RELACIONADO Devoluciones''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmmdpe is ''MOTIVO DE DEVOLUCION PEDIDO Devoluciones''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmusmo is ''USUARIO PEGASO QUE MODIFICA EL PEDIDO DE VENTA DE MATERIALES Pedido / Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmmpdi is ''MOTIVO DE VENTA''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmacti is ''S Activo N Desactivado; Para que el job lo tome''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmsol is ''DESCRIPCION''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmtipo is ''1 Solicitud 2 Devolucion''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmprog is ''Programa que modifica el dato o lo crea''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.order_id is ''CODIGO DE ORDEN''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmobse is ''Comentario''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDCI_TRANSOMA.trsmcome is ''COMENTARIO RECHAZO''';
  
    -- Create/Recreate primary, unique and foreign key constraints 
    EXECUTE IMMEDIATE 'alter table OPEN.LDCI_TRANSOMA add constraint LDCI_TRANSOMA_PK primary key (TRSMCODI)';
    EXECUTE IMMEDIATE 'alter table OPEN.LDCI_TRANSOMA add constraint LDCI_TRANSOMA_ESTADO_FK foreign key (TRSMESTA) references OPEN.LDCI_TRANESTA (CODIGO)';
    -- Grant/Revoke object privileges 
    EXECUTE IMMEDIATE 'grant select on OPEN.LDCI_TRANSOMA to MIGRA';
    EXECUTE IMMEDIATE 'grant insert, update, delete on OPEN.LDCI_TRANSOMA to RDMLOPEN';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDCI_TRANSOMA to ROLESELOPEN';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDCI_TRANSOMA to RSELOPEN';
    EXECUTE IMMEDIATE 'grant select on OPEN.LDCI_TRANSOMA to RSELUSELOPEN';
    EXECUTE IMMEDIATE 'grant select, insert, update, delete on OPEN.LDCI_TRANSOMA to SYSTEM_OBJ_PRIVS_ROLE';
  
    ut_trace.trace('Tabla LDCI_TRANSOMA creada ok!', 2);
  
  ELSE

    BEGIN
      EXECUTE IMMEDIATE 'alter table open.LDCI_TRANSOMA modify trsmesta not null';
    exception
      when others then
        dbms_output.put_line('El campo trsmesta de la entidad LDCI_TRANSOMA ya tiene la propiedad NOT NULL');
    END;
  END IF;

END;
/
