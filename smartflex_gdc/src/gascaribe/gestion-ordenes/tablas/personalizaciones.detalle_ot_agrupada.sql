DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
  SELECT COUNT(1) FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  nuExistsTable NUMBER; 

BEGIN

  --Validacion de existencia de entidad
  OPEN cuTabla('detalle_ot_agrupada');
  FETCH cuTabla INTO nuExistsTable;

    IF (nuExistsTable <> 0) THEN
      /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
      dbms_output.put_Line('La Tabla DETALLE_OT_AGRUPADA ya existe, se procede a borrar');
      EXECUTE IMMEDIATE 'drop table PERSONALIZACIONES.DETALLE_OT_AGRUPADA';
    END IF;    


    EXECUTE IMMEDIATE 'CREATE TABLE "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"
                      (
                          "ORDEN_AGRUPADORA" NUMBER(15),
                          "ORDEN" NUMBER(15), 
                          "FECHA_PROCESADA" DATE, 
                          "ESTADO" VARCHAR2(2),
                          CONSTRAINT PK_DETALLE_OT_AGRUPADA PRIMARY KEY (ORDEN_AGRUPADORA, ORDEN)
                      )';

    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DT_OT_AGRUPADORA_01 on PERSONALIZACIONES.DETALLE_OT_AGRUPADA(FECHA_PROCESADA)';
    EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_DT_OT_AGRUPADORA_02 on PERSONALIZACIONES.DETALLE_OT_AGRUPADA(ESTADO)';


    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"."ORDEN" IS ''Orden''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"."ORDEN_AGRUPADORA" IS ''Orden Agrupadora''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"."FECHA_PROCESADA" IS ''Fecha de Procesamiento''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"."ESTADO" IS ''Estado del Proceso R-Registrado P - Procesado y N - Procesada NO Valorizada''';
	  EXECUTE IMMEDIATE 'COMMENT ON TABLE "PERSONALIZACIONES"."DETALLE_OT_AGRUPADA"  IS ''Detalle Ordenes por orden agrupadora''';

    --- Aplica Permisos.
    BEGIN
      pkg_utilidades.prAplicarPermisos('DETALLE_OT_AGRUPADA', 'PERSONALIZACIONES');
    END;
    --- Fin.
  CLOSE cuTabla;

END;
/