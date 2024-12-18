/*******************************************************************************
    Método:         genera_revision_consumocero.sql
    Descripción:    Parámetro para restringir que se generan órdenes de revisión por consumo cero en procedimiento prCalificaConsumoDesvPobl
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          12/07/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR            DESCRIPCION
    12/07/2024      jcatuche         OSF-2494: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'GENERA_REVISION_CONSUMOCERO' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        'N' as VALOR_CADENA,
        'Flag que indica si se generan actividades de revisión por consumo cero' as DESCRIPCION,
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