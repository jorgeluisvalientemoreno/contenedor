/*******************************************************************************
    Metodo:         mrgld_parameterLDC_TOPENOTICR.sql.sql
    Descripcion:    Parametro para especificar tope de valor consumos recuperados

    Autor:          Juan Gabriel Catuche Giron 
    Fecha:          22/12/2022

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    22/12/2022      jcatuchemvm         OSF-748: Creacion
*******************************************************************************/

BEGIN
    MERGE INTO LD_PARAMETER A USING
    (
        SELECT
        'LDC_TOPENOTICR' as PARAMETER_ID,
        1000000 as NUMERIC_VALUE,
        '' as VALUE_CHAIN,
        'Tope para notificar consumos recuperados altos' as DESCRIPTION
        FROM DUAL
    ) B
    ON (A.PARAMETER_ID = B.PARAMETER_ID)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        PARAMETER_ID, NUMERIC_VALUE,VALUE_CHAIN,DESCRIPTION
    )
    VALUES 
    (
        B.PARAMETER_ID, B.NUMERIC_VALUE,B.VALUE_CHAIN,B.DESCRIPTION
    )
    WHEN MATCHED THEN
    UPDATE SET 
        A.NUMERIC_VALUE = B.NUMERIC_VALUE,
        A.VALUE_CHAIN = B.VALUE_CHAIN,
        A.DESCRIPTION = B.DESCRIPTION
    ;
    
    COMMIT;
    
END;
/