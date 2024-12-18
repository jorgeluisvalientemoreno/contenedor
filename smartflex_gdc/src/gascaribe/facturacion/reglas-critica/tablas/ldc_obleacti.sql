/*******************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
    Archivo        ldc_obleacti.sql

    Descripción:   Se altera la tabla LDC_OBLEACTI añadiendo el campo TIPO_SUSPENSION  y
    GEN_RELECTURA para el tipo de suspensión y el flag para generación de relecturas.
    
  
    Historia de Modificaciones
    Fecha           Autor           Modificación
    03-08-2023      jcatuchemvm     OSF-1086: Ajuste forma LDCACGEOL
*******************************************************************************/
Declare 
  nuconta       number;
  sbCommando    varchar2(2000);
BEGIN
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES
    WHERE TABLE_NAME = 'LDC_OBLEACTI';
  
    IF nuconta = 0 THEN  
        sbCommando := 'CREATE TABLE OPEN.LDC_OBLEACTI
        (
            OBLECODI           NUMBER(4),              
            ACTIVIDAD          NUMBER(15),                 
            MEDIO_RECEPCION    NUMBER(4),
            PERIOD_CONSE       NUMBER(4),                  
            DIAS_GEN_OT        NUMBER(4),
            GEN_NOTI           VARCHAR2(2)           DEFAULT ''N'',                   
            CAUSAL_EXITO       VARCHAR2(1)           DEFAULT ''N'',
            ACTIVIDAD_CRITICA  NUMBER(15),
            REGLOBLE           NUMBER(15),
            ESTACORTE          VARCHAR2(400),
             
            CONSTRAINT PK_LDC_OBLEACTI PRIMARY KEY (OBLECODI, REGLOBLE),
            CONSTRAINT FK_OBLEAC_OBSE  FOREIGN KEY (OBLECODI) REFERENCES OPEN.OBSELECT (OBLECODI),
            CONSTRAINT FK_OBLEAC_REGLA FOREIGN KEY (REGLOBLE) REFERENCES OPEN.LDC_RECROBLE (REOBCODI),
            CONSTRAINT OBLEACTI_CODI_NNUL CHECK (OBLECODI IS NOT NULL),
            CONSTRAINT OBLEACTI_ACTI_NNUL CHECK (ACTIVIDAD IS NOT NULL),
            CONSTRAINT OBLEACTI_PERI_CONSE_NNUL CHECK (PERIOD_CONSE IS NOT NULL),
            CONSTRAINT OBLEACTI_DIAS_GENOT_NNUL CHECK (DIAS_GEN_OT IS NOT NULL),
            CONSTRAINT OBLEACTI_GEN_NOTI_NNUL CHECK (GEN_NOTI IS NOT NULL)
        )';
        
        EXECUTE IMMEDIATE sbCommando;
														
	
    ELSE
        --Adición TIPO_SUSPENSION
        SELECT COUNT(*) INTO nuconta
        FROM dba_tab_cols
        WHERE table_name  = 'LDC_OBLEACTI'
        AND owner       = 'OPEN'
        AND column_name = 'TIPO_SUSPENSION';
    
        IF nuconta = 0 THEN
            sbCommando := 'ALTER TABLE LDC_OBLEACTI ADD TIPO_SUSPENSION VARCHAR2 (400)';
            EXECUTE IMMEDIATE sbCommando;

            sbCommando := 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.TIPO_SUSPENSION IS ''Tipos de suspensión no permitidos''';        
            EXECUTE IMMEDIATE sbCommando;
            
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_OBLEACTI, campo TIPO_SUSPENSION agregado correctamente' );

        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_OBLEACTI ya cuenta con el campo TIPO_SUSPENSION' );
        END IF;
        
        --Adición GEN_RELECTURA
        SELECT COUNT(*) INTO nuconta
        FROM dba_tab_cols
        WHERE table_name  = 'LDC_OBLEACTI'
        AND owner       = 'OPEN'
        AND column_name = 'GEN_RELECTURA';
    
        IF nuconta = 0 THEN
            sbCommando := 'ALTER TABLE LDC_OBLEACTI ADD GEN_RELECTURA VARCHAR2 (1) DEFAULT ''N''';
            EXECUTE IMMEDIATE sbCommando;

            sbCommando := 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.GEN_RELECTURA IS ''Observación genera Relectura''';        
            EXECUTE IMMEDIATE sbCommando;
            
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_OBLEACTI, campo GEN_RELECTURA agregado correctamente' );

        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_OBLEACTI ya cuenta con el campo GEN_RELECTURA' );
        END IF;
    
    END IF;
  
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.OBLECODI           IS ''Observación de No Lectura''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.ACTIVIDAD          IS ''Actividad a Generar''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.MEDIO_RECEPCION    IS ''Medio de recepción''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.PERIOD_CONSE       IS ''Periodos consecutivos con la Observación''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.DIAS_GEN_OT        IS ''Días para validación de órdenes cerradas''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.GEN_NOTI           IS ''Genera Notificación - Spool''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.CAUSAL_EXITO       IS ''Es Causal De Exito- S-Si, N-No''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.ACTIVIDAD_CRITICA  IS ''Actividad De Critica''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.REGLOBLE           IS ''Consecutivo de Configuración de regla''';
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_OBLEACTI.ESTACORTE          IS ''Estados de corte no permitidos''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_OBLEACTI                     IS ''Actividades por Observaciones de No Lectura''';
  
END;
/
