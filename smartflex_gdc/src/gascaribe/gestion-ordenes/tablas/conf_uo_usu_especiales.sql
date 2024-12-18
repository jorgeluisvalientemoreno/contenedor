DECLARE
  CURSOR cuTabla(sbTable VARCHAR2) IS
  SELECT COUNT(1) FROM all_tables WHERE upper(TABLE_NAME) = upper(sbTable);

  nuExistsTable NUMBER; 

BEGIN

  --Validacion de existencia de entidad
  OPEN cuTabla('CONF_UO_USU_ESPECIALES');
  FETCH cuTabla INTO nuExistsTable;

    IF (nuExistsTable <> 0) THEN
      /*Si la tabla ya existe, se informa en consola acerca de su existencia*/
      dbms_output.put_Line('La Tabla CONF_UO_USU_ESPECIALES ya existe, se procede a borrar');
      EXECUTE IMMEDIATE 'drop table CONF_UO_USU_ESPECIALES';
    END IF;    


    EXECUTE IMMEDIATE 'CREATE TABLE "OPEN"."CONF_UO_USU_ESPECIALES"
                      (
                          "CODIGO" NUMBER(15),
                          "CICLO" NUMBER(4) NOT NULL, 
                          "SECTOR_OPERATIVO" NUMBER(15) NOT NULL, 
                          "UNIDAD_OPERATIVA" NUMBER(15) NOT NULL
                      ) TABLESPACE  TSD_DEFAULT';

    dbms_output.put_line('APLICANDO LLAVE PRIMARIA...');
    EXECUTE IMMEDIATE 'ALTER TABLE CONF_UO_USU_ESPECIALES ADD CONSTRAINT PK_CONF_UO_USU_ESPECIALES PRIMARY KEY (CODIGO) USING INDEX TABLESPACE TSI_DEFAULT';

    EXECUTE IMMEDIATE 'CREATE INDEX IDX_CONF_UO_USU_ESPECIALES_01 on CONF_UO_USU_ESPECIALES(CICLO,SECTOR_OPERATIVO,UNIDAD_OPERATIVA) TABLESPACE TSI_DEFAULT';


    --- Comentarios de la tabla y campos.
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "OPEN"."CONF_UO_USU_ESPECIALES"."CODIGO" IS ''Código único de registro''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "OPEN"."CONF_UO_USU_ESPECIALES"."CICLO" IS ''Ciclo''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "OPEN"."CONF_UO_USU_ESPECIALES"."SECTOR_OPERATIVO" IS ''Sector operativo''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN "OPEN"."CONF_UO_USU_ESPECIALES"."UNIDAD_OPERATIVA" IS ''Unidad operativa''';
EXECUTE IMMEDIATE 'COMMENT ON TABLE "OPEN"."CONF_UO_USU_ESPECIALES"  IS ''Configuración de unidad operativa para usuarios especiales''';
    --- Aplica Permisos.
    BEGIN
      pkg_utilidades.prAplicarPermisos('CONF_UO_USU_ESPECIALES', 'OPEN');
    END;
    --- Fin.
  CLOSE cuTabla;

END;
/