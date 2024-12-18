DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1)
    into nuTab1
    from dba_objects
    where object_name = 'LDC_CONF_COMM_AUT_CONT';

    IF (nuTab1=0) THEN

        execute immediate 'CREATE TABLE "LDC_CONF_COMM_AUT_CONT"
                        (
                         "LDC_CONF_COMM_ID" NUMBER(4,0) NOT NULL,
                         "COMMERCIAL_PLAN_ID" NUMBER(15,0) NOT NULL,
                         "DEPARTAMENT" NUMBER(6,0) NOT NULL,
                         "CATEGORY_ID" NUMBER(2,0) NOT NULL,
                         "PERCENTAGE" NUMBER(13,2) NOT NULL,
                         "DATE_INIT" DATE NOT NULL,
                         "DATE_END" DATE NOT NULL
                        )';
                        
        dbms_output.put_line('Tabla LDC_CONF_COMM_AUT_CONT creada correctamente');
        
        execute immediate 'ALTER TABLE "LDC_CONF_COMM_AUT_CONT" ADD CONSTRAINT
                            "PK_LDC_CONF_COMM_AUT_CONT" PRIMARY KEY ("LDC_CONF_COMM_ID")
                            USING INDEX ENABLE';

        dbms_output.put_line('Llave primaria creada correctamente');
    
        execute immediate 'COMMENT ON TABLE LDC_CONF_COMM_AUT_CONT IS ''Configuración para liquidacion de comisiones automaticas''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.LDC_CONF_COMM_ID IS ''Identificador del registro''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.COMMERCIAL_PLAN_ID IS ''Plan comercial''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.DEPARTAMENT IS ''Departamento''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.CATEGORY_ID IS ''Categoría''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.PERCENTAGE IS ''Porcentaje de comisión''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.DATE_INIT IS ''Fecha inicial''';
        execute immediate 'COMMENT ON COLUMN LDC_CONF_COMM_AUT_CONT.DATE_END IS ''Fecha final''';
            
        execute immediate 'GRANT SELECT, INSERT, DELETE, UPDATE ON LDC_CONF_COMM_AUT_CONT TO SYSTEM_OBJ_PRIVS_ROLE';
        execute immediate 'GRANT SELECT ON LDC_CONF_COMM_AUT_CONT TO RSELOPEN';
        execute immediate 'GRANT SELECT ON LDC_CONF_COMM_AUT_CONT TO reportes';
        execute immediate 'grant select on LDC_CONF_COMM_AUT_CONT to INNOVACIONBI';
         
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/