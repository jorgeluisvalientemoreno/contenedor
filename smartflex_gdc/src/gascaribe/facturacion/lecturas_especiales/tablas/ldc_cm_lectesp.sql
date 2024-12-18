/*******************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
    Archivo        ldc_cm_lectesp.sql

    Descripción:   Se altera la tabla ldc_cm_lectesp añadiendo el campo OBSERVACION para
    almacenar el codigo de la observación de no lectura.
    
  
    Historia de Modificaciones
    Fecha           Autor           Modificación
    15-09-2023      jcatuchemvm     OSF-1440: Ajuste forma LECTESP
*******************************************************************************/
Declare 
  nuconta       number;
  sbCommando    varchar2(2000);
BEGIN
    SELECT COUNT(1) INTO nuconta
    FROM DBA_TABLES
    WHERE TABLE_NAME = 'LDC_CM_LECTESP';
  
    IF nuconta = 0 THEN  
        
        DBMS_OUTPUT.PUT_LINE('Tabla LDC_CM_LECTESP no existe en la base de datos' );														
	
    ELSE
        --Adición OBSERVACION
        SELECT COUNT(*) INTO nuconta
        FROM dba_tab_cols
        WHERE table_name  = 'LDC_CM_LECTESP'
        AND owner       = 'OPEN'
        AND column_name = 'OBSERVACION';
    
        IF nuconta = 0 THEN
            sbCommando := 'ALTER TABLE LDC_CM_LECTESP ADD OBSERVACION NUMBER (4)';
            EXECUTE IMMEDIATE sbCommando;

            sbCommando := 'COMMENT ON COLUMN OPEN.LDC_CM_LECTESP.OBSERVACION IS ''Código Observación de no lectura''';        
            EXECUTE IMMEDIATE sbCommando;
            
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_CM_LECTESP, campo OBSERVACION agregado correctamente' );

        ELSE
            DBMS_OUTPUT.PUT_LINE('Tabla LDC_CM_LECTESP ya cuenta con el campo OBSERVACION' );
        END IF;
        
    END IF;
  
    EXECUTE IMMEDIATE 'COMMENT ON COLUMN OPEN.LDC_CM_LECTESP.OBSERVACION        IS ''Código Observación de no lectura''';
    EXECUTE IMMEDIATE 'COMMENT ON TABLE OPEN.LDC_CM_LECTESP                     IS ''Listado Lecturas De Clientes Especiales''';
  
END;
/
