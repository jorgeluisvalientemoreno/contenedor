/*******************************************************************************
    Método:         OSF-1086Configuracion.sql
    Descripción:    Configuración regla 2004, campo GEN_RELECTURA
    Autor:          Juan Gabriel Catuche Girón 
    Fecha:          04/08/2023

    Historia de Modificaciones
    ==========================
    FECHA           AUTOR               DESCRIPCION
    04/08/2023      jcatuchemvm         OSF-1086: Creación
*******************************************************************************/

BEGIN
    MERGE INTO LDC_OBLEACTI A USING
    (
        SELECT 4 as REGLOBLE, 12 as OBLECODI FROM DUAL UNION
        SELECT 4,59 FROM DUAL UNION
        SELECT 4,71 FROM DUAL UNION
        SELECT 4,79 FROM DUAL UNION
        SELECT 4,80 FROM DUAL UNION
        SELECT 4,82 FROM DUAL
    ) B
    ON (A.REGLOBLE = B.REGLOBLE AND A.OBLECODI = B.OBLECODI)
    WHEN MATCHED THEN
    UPDATE SET 
        A.GEN_RELECTURA = 'S'
    ;
    
    COMMIT;
    
END;
/
