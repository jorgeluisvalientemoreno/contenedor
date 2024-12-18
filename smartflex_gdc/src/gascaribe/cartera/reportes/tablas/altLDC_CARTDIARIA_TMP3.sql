/*******************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).
    Archivo        altLDC_CARTDIARIA_TMP3.sql

    Descripción:   Se altera la tabla LDC_CARTDIARIA_TMP3 agregando el campo VALOR_CASTIGADO
    para el almacenamiento del valor castigado del producto
    
  
    Historia de Modificaciones
    Fecha           Autor           Modificación
    20-12-2022      jcatuchemvm     OSF-747: Ajuste reporte BACADI, agregando el campo valor castigado.
*******************************************************************************/
DECLARE
    sbCommand       varchar2(2000);
    nuCant          number;
    sbTabla         varchar2(200);
BEGIN
    sbTabla := 'LDC_CARTDIARIA_TMP3';
    
    SELECT COUNT(*)
    INTO nuCant
    FROM dba_tab_cols
    WHERE table_name  = sbTabla
    AND owner       = 'OPEN'
    AND column_name = 'VALOR_CASTIGADO';
    
    IF nuCant = 0 THEN
        sbCommand := 'ALTER TABLE '||sbTabla||' ADD VALOR_CASTIGADO NUMBER (13,2)';
        EXECUTE IMMEDIATE sbCommand;

        DBMS_OUTPUT.PUT_LINE('Tabla '||sbTabla||', campo VALOR_CASTIGADO agregado correctamente' );

    ELSE
        DBMS_OUTPUT.PUT_LINE('Tabla '||sbTabla||' ya cuenta con el campo VALOR_CASTIGADO' );
    END IF;
    
END;
/