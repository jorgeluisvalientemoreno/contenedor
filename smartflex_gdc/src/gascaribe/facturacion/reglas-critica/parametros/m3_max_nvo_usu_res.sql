/***********************************************************
ELABORADO POR:  Juan Gabriel Catuche Giron
EMPRESA:        MVM Ingenieria de Software
FECHA:          Enero 2024 
JIRA:           OSF-210

Actualiza parametro M3_MAX_NVO_USU_RES de 100 a 500

    
    Archivo de entrada 
    ===================
    NA       
    
    Archivo de Salida 
    ===================
    NA
    
    --Modificaciones    
    12/01/2024 - jcatuchemvm
    Creación
    
***********************************************************/
BEGIN
    MERGE INTO ld_parameter A USING
    (
        SELECT
        'M3_MAX_NVO_USU_RES' as PARAMETER_ID,
        500 AS NUMERIC_VALUE,
        NULL AS VALUE_CHAIN,
        'M3 VALIDOS PARA UN USUARIO NUEVO RESIDENCIAL' DESCRIPTION
        FROM DUAL
    ) B
    ON (A.PARAMETER_ID = B.PARAMETER_ID)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        PARAMETER_ID, NUMERIC_VALUE, VALUE_CHAIN, DESCRIPTION
    )
    VALUES 
    (
        B.PARAMETER_ID, B.NUMERIC_VALUE, B.VALUE_CHAIN, B.DESCRIPTION
    )
    WHEN MATCHED THEN
    UPDATE SET 
        A.NUMERIC_VALUE        = B.NUMERIC_VALUE,
        A.VALUE_CHAIN           = B.VALUE_CHAIN,
        A.DESCRIPTION          = B.DESCRIPTION
    ;
    
    COMMIT;
    
END;
/