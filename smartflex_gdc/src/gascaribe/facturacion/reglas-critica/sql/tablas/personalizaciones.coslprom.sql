/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-2231

Creación de tabla que almacena contratos cuyos productos tienen consumos promedidos por política consumo cero Ref OSF-2190

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    Fecha           Autor           Descripción
    29/01/2024      jcatuchemvm     OSF-2231: Creación
    
***********************************************************/
Declare
  nuconta number;
BEGIN
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES
    WHERE TABLE_NAME = 'COSLPROM';

    IF nuconta = 0 THEN  
        dbms_output.put_line('Creación tabla COSLPROM');

        EXECUTE IMMEDIATE 'CREATE TABLE PERSONALIZACIONES.COSLPROM(  
                                                            CONTRATO 		NUMBER(8),
                                                            PRODUCTO        NUMBER(10),
                                                            PERIODO         NUMBER(6),
                                                            PERICONS        NUMBER(15),
                                                            REGLA           NUMBER(4),
                                                            OBSERVACION     NUMBER(4),
                                                            FECHA           DATE,
                                                            USUARIO         VARCHAR2(50),
                                                            CONSTRAINT CK_COSLPROM_CONTRATO_NNUL CHECK (CONTRATO IS NOT NULL),
                                                            CONSTRAINT CK_COSLPROM_PRODUCTO_NNUL CHECK (PRODUCTO IS NOT NULL),
                                                            CONSTRAINT CK_COSLPROM_PERIODO_NNUL CHECK (PERIODO IS NOT NULL),
                                                            CONSTRAINT CK_COSLPROM_REGLA_NNUL CHECK (REGLA IS NOT NULL),
                                                            CONSTRAINT CK_COSLPROM_OBSERVACION_NNUL CHECK (OBSERVACION IS NOT NULL),
                                                            CONSTRAINT CK_COSLPROM_FECHA_NNUL CHECK (FECHA IS NOT NULL)
                                                    )';
                                                           
            dbms_output.put_line('Creación comentarios a COSLPROM');                                         
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.CONTRATO       IS ''Número del contrato''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.PRODUCTO       IS ''Número del producto''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.PERIODO        IS ''Periodo de facturación''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.PERICONS       IS ''Periodo de consumo''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.REGLA          IS ''Regla con la que se califica el consumo''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.OBSERVACION    IS ''Observación de lectura''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.FECHA          IS ''Fecha de registro''';
            EXECUTE IMMEDIATE 'COMMENT ON COLUMN PERSONALIZACIONES.COSLPROM.USUARIO        IS ''Usuario que registra o actualiza''';
            EXECUTE IMMEDIATE 'COMMENT ON TABLE PERSONALIZACIONES.COSLPROM IS ''Productos sin lecturas facturados con consumo promedio. Ajuste OSF-2190''';
            
            dbms_output.put_line('Creación índices a COSLPROM');
            EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_COSLPROM_01 ON PERSONALIZACIONES.COSLPROM(CONTRATO)';
            EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_COSLPROM_02 ON PERSONALIZACIONES.COSLPROM(PRODUCTO)';
            EXECUTE IMMEDIATE 'CREATE INDEX PERSONALIZACIONES.IDX_COSLPROM_03 ON PERSONALIZACIONES.COSLPROM(PERIODO)';
	
    ELSE
        dbms_output.put_line('Tabla COSLPROM ya existe');
    END IF;

END;
/
PROMPT Otorga Permisos de Ejecución personalizaciones.COSLPROM
begin
    pkg_utilidades.prAplicarPermisos('COSLPROM','PERSONALIZACIONES');
end;
/
