/*******************************************************************************
    Metodo:         mrgld_parameterLDC_EMAILNOCONSREC.sql
    Descripcion:    Parametro para notificacion de consumos recuperados altos

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
        'LDC_EMAILNOCONSREC' as PARAMETER_ID,
        NULL as NUMERIC_VALUE,
        'molivella@gascaribe.com,cmendoza@gascaribe.com,jbayuelo@gascaribe.com' as VALUE_CHAIN,
        'Emails a notificar consumos recuperados altos, separados por ,' as DESCRIPTION
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