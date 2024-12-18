/*******************************************************************************
    Método:         cuentas_saldo_descadife.sql
    Descripción:    Parámetro que indica la cantidad de cuentas con saldo máximas para gestionar los descuentos del proceso PRGENEDESCADIFE
    Autor:          jcatuche
    Fecha:          07/10/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    07/10/2024      jcatuche            OSF-3396: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'CUENTAS_SALDO_DESCADIFE' as CODIGO,
        1 AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        NULL as VALOR_CADENA,
        'Cantidad de cuentas con saldo máximas para gestionar descuentos DESCCADIFE' as DESCRIPCION,
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