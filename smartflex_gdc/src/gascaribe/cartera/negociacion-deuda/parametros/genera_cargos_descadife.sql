/*******************************************************************************
    Método:         genera_cargos_descadife.sql
    Descripción:    Parámetro para controlar la generación de descuentos del proceso PRGENEDESCADIFE
    Autor:          jcatuche
    Fecha:          28/08/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    28/08/2024      jcatuche            OSF-2974: Creación
    16/10/2024      jcatuche            OSF-3478: Actualización valor parámetro, habilita generación de cargos de descuento
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'GENERA_CARGOS_DESCADIFE' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        'S' as VALOR_CADENA,
        'Flag de control para generación de descuentos DESCCADIFE' as DESCRIPCION,
        6 as PROCESO
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