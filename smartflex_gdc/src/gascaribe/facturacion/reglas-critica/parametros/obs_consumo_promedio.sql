/*******************************************************************************
    Método:         obs_consumo_promedio.sql
    Descripción:    Parámetro para observaciones de no lectucta que van generar consumo promedio
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          12/01/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    12/01/2024      jcatuchemvm         OSF-2190: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'OBS_CONSUMO_PROMEDIO' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        '8,38,59,71,79,80,81,82' as VALOR_CADENA,
        'Observaciones lectura validas para consumo promedio OSF-2190' as DESCRIPCION,
        16 as PROCESO
        FROM DUAL
    ) B
    ON (A.CODIGO = B.CODIGO)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        CODIGO, VALOR_NUMERICO, VALOR_FECHA, VALOR_CADENA, DESCRIPCION, PROCESO, USUARIO, TERMINAL, FECHA_CREACION
    )
    VALUES 
    (
        B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION, B.PROCESO, USER,USERENV('TERMINAL'), SYSDATE
    )
    WHEN MATCHED THEN
    UPDATE SET 
        A.VALOR_NUMERICO        = B.VALOR_NUMERICO,
        A.VALOR_FECHA           = B.VALOR_FECHA,
        A.VALOR_CADENA          = B.VALOR_CADENA,
        A.DESCRIPCION           = B.DESCRIPCION,
        A.PROCESO               = B.PROCESO,
        A.FECHA_ACTUALIZACION   = SYSDATE
    ;
    
    COMMIT;
    
END;
/