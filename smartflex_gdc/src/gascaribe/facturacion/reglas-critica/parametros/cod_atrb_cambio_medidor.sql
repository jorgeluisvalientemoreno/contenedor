/*******************************************************************************
    Método:         cod_atrb_cambio_medidor.sql
    Descripción:    Parámetro para atributos de tipos de trabajo de cambio de medidor

    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          04/08/2023

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    04/08/2023      jcatuchemvm         OSF-1086: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'COD_ATRB_CAMBIO_MEDIDOR' as CODIGO,
        NULL AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        '400021,400022' as VALOR_CADENA,
        'Atributos para validar Tipos de trabajo de cambio de medidor OSF-1086' as DESCRIPCION,
        16 PROCESO
        FROM DUAL
    ) B
    ON (A.CODIGO = B.CODIGO)
    WHEN NOT MATCHED THEN 
    INSERT 
    (
        CODIGO, VALOR_NUMERICO, VALOR_FECHA, VALOR_CADENA, DESCRIPCION, USUARIO, TERMINAL, FECHA_CREACION
    )
    VALUES 
    (
        B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION,USER,USERENV('TERMINAL'), SYSDATE
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