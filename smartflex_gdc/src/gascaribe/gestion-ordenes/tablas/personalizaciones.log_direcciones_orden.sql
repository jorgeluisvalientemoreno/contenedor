DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
  SELECT COUNT(1) FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  nuExistsTable NUMBER; 

BEGIN

  --Validacion de existencia de entidad
  OPEN cuTabla('log_direcciones_orden');
  FETCH cuTabla INTO nuExistsTable;

    IF (nuExistsTable <> 0) THEN
      /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
      dbms_output.put_Line('La Tabla LOG_DIRECCIONES_ORDEN ya existe, se procede a borrar');
      EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.LOG_DIRECCIONES_ORDEN';
    END IF;    


    EXECUTE IMMEDIATE 'CREATE TABLE "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"
                      (
                          "ORDEN" NUMBER(15),
                          "FECHA_CAMBIO" DATE, 
                          "DIRECCION_ANTERIOR" NUMBER(15), 
                          "DIRECCION_ACTUAL" NUMBER(15),
                          "USUARIO" VARCHAR2(50),
                          "TERMINAL" VARCHAR2(100)
                      )';

    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_DIRECCIONES_ORDEN_01 on PERSONALIZACIONES.LOG_DIRECCIONES_ORDEN(ORDEN)';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_LOG_DIRECCIONES_ORDEN_02 on PERSONALIZACIONES.LOG_DIRECCIONES_ORDEN(FECHA_CAMBIO)';


    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."ORDEN" IS ''Orden''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."FECHA_CAMBIO" IS ''Fecha de cambio de dirección''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."DIRECCION_ANTERIOR" IS ''Dirección Anterior''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."DIRECCION_ACTUAL" IS ''Dirección Actual''';
	  EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."USUARIO" IS ''Usuario''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"."TERMINAL" IS ''Terminal''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE "PERSONALIZACIONES"."LOG_DIRECCIONES_ORDEN"  IS ''Registra el log de cambios de direcciones de la orden''';

    --- Aplica Permisos.
    BEGIN
      pkg_utilidades.prAplicarPermisos('LOG_DIRECCIONES_ORDEN', 'PERSONALIZACIONES');
    END;
    --- Fin.
  CLOSE cuTabla;

END;
/