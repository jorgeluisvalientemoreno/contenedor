DECLARE
  nuconta number;
BEGIN
  SELECT COUNT(1)
    INTO nuconta
    FROM DBA_TABLES
   WHERE TABLE_NAME = 'LDC_ORDER';

  IF nuconta = 0 THEN
    -- Create table
    EXECUTE IMMEDIATE 'create table OPEN.LDC_ORDER(
                      order_id   NUMBER(15),
                      package_id NUMBER(15),
                      asignacion NUMBER(15),
                      asignado   VARCHAR2(1) default ''N'',
                      ordeobse   VARCHAR2(4000),
                      ordefere   DATE,
                      ordefebl   DATE,
                      ordebloq   VARCHAR2(1)
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
                      )';
  
    -- Add comments to the table 
    EXECUTE IMMEDIATE 'comment on table OPEN.LDC_ORDER is ''ORDEN PARA ASIGNAR A UNA UNIDAD OPERATIVA''';
  
    -- Add comments to the columns 
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_ORDER.order_id is ''CODIGO ORDEN''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_ORDER.package_id is ''CODIGO PAQUETE''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_ORDER.asignacion is ''NUMERO DE INTENTOS ANTES DE SER ASIGNACDO''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_ORDER.asignado is ''ASIGNADO SI[S] - NO[N]''';
    EXECUTE IMMEDIATE 'comment on column OPEN.LDC_ORDER.ordebloq is ''BOQUEO DE ORDEN''';
  
    -- Create/Recreate indexes 
    EXECUTE IMMEDIATE 'create index OPEN.IDX_LDC_ORDER_01 on OPEN.LDC_ORDER (ORDER_ID, PACKAGE_ID)';
    EXECUTE IMMEDIATE 'create index OPEN.IDX_LDC_ORDER_02 on OPEN.LDC_ORDER (ASIGNADO)';
    EXECUTE IMMEDIATE 'create index OPEN.IDX_LDC_ORDER_03 on OPEN.LDC_ORDER (PACKAGE_ID)';
    EXECUTE IMMEDIATE 'create index OPEN.IDX_LDC_ORDER_04 on OPEN.LDC_ORDER (ORDEBLOQ)';

  ELSE
    dbms_output.put_line('Entidad LDC_ORDER ya existe.');
  END IF;
  -- Grant/Revoke object privileges 
  EXECUTE IMMEDIATE 'grant select on OPEN.LDC_ORDER to MIGRA';
  EXECUTE IMMEDIATE 'grant insert, update, delete on OPEN.LDC_ORDER to RDMLOPEN';
  EXECUTE IMMEDIATE 'grant select on OPEN.LDC_ORDER to RSELOPEN';
  EXECUTE IMMEDIATE 'grant select on OPEN.LDC_ORDER to RSELUSELOPEN';
  pkg_utilidades.prAplicarPermisos('LDC_ORDER','OPEN');

end;
/