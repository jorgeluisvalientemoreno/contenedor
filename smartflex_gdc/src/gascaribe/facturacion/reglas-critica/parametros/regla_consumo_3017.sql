/*******************************************************************************
    Método:         regla_consumo_3017.sql
    Descripción:    Parámetro para almacenar el código de la regla 3017, consumo nulo
    Autor:          jcatuche
    Fecha:          20/09/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    20/09/2024      jcatuche            OSF-3181: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'REGLA_CONSUMO_3017' as CODIGO,
        3017 AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        NULL AS VALOR_CADENA,
        'Calificación de consumo nulo, usuarios estimados - lectura' as DESCRIPCION,
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