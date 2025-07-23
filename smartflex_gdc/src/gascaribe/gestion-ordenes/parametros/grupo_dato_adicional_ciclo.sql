/*******************************************************************************
    Método:         grupo_dato_adicional_ciclo.sql
    Descripción:    Código del grupo de atributos y nombre del atributo del dato adicional para el cambio de ciclo 
    Autor:          jcatuche
    Fecha:          16/12/2024

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    16/12/2024      jcatuche            OSF-3758: Creación
*******************************************************************************/

BEGIN
    MERGE INTO PARAMETROS A USING
    (
        SELECT
        'GRUPO_DATO_ADICIONAL_CICLO' as CODIGO,
        14065 AS VALOR_NUMERICO,
        NULL AS VALOR_FECHA,
        'NUEVO_CICLO' as VALOR_CADENA,
        'Código del grupo de atributos y nombre del atributo que contiene el dato adicional para el cambio de ciclo' as DESCRIPCION,
        4 as PROCESO
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
        B.CODIGO, B.VALOR_NUMERICO, B.VALOR_FECHA, B.VALOR_CADENA, B.DESCRIPCION, B.PROCESO, pkg_session.getUser,pkg_session.fsbgetTerminal, SYSDATE
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