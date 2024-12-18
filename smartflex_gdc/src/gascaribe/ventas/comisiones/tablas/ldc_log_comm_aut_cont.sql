DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1)
    into nuTab1
    from dba_objects
    where object_name = 'LDC_LOG_COMM_AUT_CONT';

    IF (nuTab1=0) THEN

        execute immediate 'CREATE TABLE "LDC_LOG_COMM_AUT_CONT"
                        (
                         "LDC_LOG_COMM_ID" NUMBER(15,0) NOT NULL,
                         "PACKAGE_ID" NUMBER(15,0),
                         "REGISTER_DATE" DATE,
                         "ERROR_CODE" NUMBER(15,0),
                         "ERROR_MESSAGE" VARCHAR2(2000)
                        )';
                        
        dbms_output.put_line('Tabla LDC_LOG_COMM_AUT_CONT creada correctamente');
     
        execute immediate 'ALTER TABLE "LDC_LOG_COMM_AUT_CONT" ADD CONSTRAINT
                        "PK_LDC_LOG_COMM_AUT_CO" PRIMARY KEY ("LDC_LOG_COMM_ID")
                        USING INDEX ENABLE';

        dbms_output.put_line('Llave primaria creada correctamente');

        execute immediate 'COMMENT ON TABLE LDC_LOG_COMM_AUT_CONT IS ''Log de proceso de liquidacion de comisiones automaticas''';
        execute immediate 'COMMENT ON COLUMN LDC_LOG_COMM_AUT_CONT.LDC_LOG_COMM_ID IS ''Identificador del registro''';
        execute immediate 'COMMENT ON COLUMN LDC_LOG_COMM_AUT_CONT.PACKAGE_ID IS ''Solicitud''';
        execute immediate 'COMMENT ON COLUMN LDC_LOG_COMM_AUT_CONT.REGISTER_DATE IS ''Fecha de registro''';
        execute immediate 'COMMENT ON COLUMN LDC_LOG_COMM_AUT_CONT.ERROR_CODE IS ''Identificador del error''';
        execute immediate 'COMMENT ON COLUMN LDC_LOG_COMM_AUT_CONT.ERROR_MESSAGE IS ''Mensaje de error''';

        execute immediate 'GRANT SELECT, INSERT, DELETE, UPDATE ON LDC_LOG_COMM_AUT_CONT TO SYSTEM_OBJ_PRIVS_ROLE';
        execute immediate 'GRANT SELECT ON LDC_LOG_COMM_AUT_CONT TO RSELOPEN';
        execute immediate 'GRANT SELECT ON LDC_LOG_COMM_AUT_CONT TO reportes';
        execute immediate 'grant select on LDC_LOG_COMM_AUT_CONT to INNOVACIONBI';

     
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/