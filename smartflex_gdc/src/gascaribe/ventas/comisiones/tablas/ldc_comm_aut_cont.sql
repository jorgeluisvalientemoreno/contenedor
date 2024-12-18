DECLARE
    nuTab1 number := 0;
BEGIN
    select count(1)
    into nuTab1
    from dba_objects
    where object_name = 'LDC_COMM_AUT_CONT';

    IF (nuTab1=0) THEN

        execute immediate 'CREATE TABLE "LDC_COMM_AUT_CONT"
                        (
                         "LDC_COMM_ID" NUMBER(15,0) NOT NULL,
                         "LDC_CONF_COMM_ID" NUMBER(4,0) NOT NULL,
                         "PACKAGE_ID" NUMBER(15,0) NOT NULL,
                         "VALUE_COMI" NUMBER(13,2) NOT NULL,
                         "GENERATE_DATE" DATE NOT NULL,
                         "ORDER_ID" NUMBER(15,0)
                        )';
                        
        dbms_output.put_line('Tabla LDC_COMM_AUT_CONT creada correctamente');
     
        execute immediate 'ALTER TABLE "LDC_COMM_AUT_CONT" ADD CONSTRAINT
                        "PK_LDC_COMM_AUT_CONT" PRIMARY KEY ("LDC_COMM_ID")
                        USING INDEX ENABLE';

        dbms_output.put_line('Llave primaria creada correctamente');
     
        execute immediate 'ALTER TABLE "OPEN"."LDC_COMM_AUT_CONT" ADD CONSTRAINT
                        "FK_LDC_COMM_AUT_CONT_01" FOREIGN KEY ("LDC_CONF_COMM_ID")
                        REFERENCES "OPEN"."LDC_CONF_COMM_AUT_CONT" ("LDC_CONF_COMM_ID") ENABLE';

        dbms_output.put_line('Llave foranea creada correctamente');
     
        execute immediate 'ALTER TABLE "OPEN"."LDC_COMM_AUT_CONT" ADD CONSTRAINT
                        "FK_MO_PACK_LDC_COMM" FOREIGN KEY ("PACKAGE_ID")
                    	  REFERENCES "OPEN"."MO_PACKAGES" ("PACKAGE_ID") ENABLE';
                    	  
        execute immediate 'CREATE INDEX "OPEN"."IDX_LDC_COMM_AUT_CONT_01" ON "OPEN"."LDC_COMM_AUT_CONT" ("PACKAGE_ID")';
	  
	    dbms_output.put_line('Llave foranea creada correctamente');

        execute immediate 'COMMENT ON TABLE LDC_COMM_AUT_CONT IS ''Configuración para liquidacion de comisiones automaticas''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.LDC_COMM_ID IS ''Identificador del registro''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.LDC_CONF_COMM_ID IS ''Identificador del registro de configuración''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.PACKAGE_ID IS ''Solicitud''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.VALUE_COMI IS ''Valor de la comisión''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.GENERATE_DATE IS ''Fecha en que se liquidó la comisión''';
        execute immediate 'COMMENT ON COLUMN LDC_COMM_AUT_CONT.ORDER_ID IS ''Identificador de la orden de comisión''';

        execute immediate 'GRANT SELECT, INSERT, DELETE, UPDATE ON LDC_COMM_AUT_CONT TO SYSTEM_OBJ_PRIVS_ROLE';
        execute immediate 'GRANT SELECT ON LDC_COMM_AUT_CONT TO RSELOPEN';
        execute immediate 'GRANT SELECT ON LDC_COMM_AUT_CONT TO reportes';
        execute immediate 'grant select on LDC_COMM_AUT_CONT to INNOVACIONBI';
     
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/