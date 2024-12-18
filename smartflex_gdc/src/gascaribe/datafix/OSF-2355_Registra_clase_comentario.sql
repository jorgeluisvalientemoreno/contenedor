column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

    CURSOR cuseqClaseComentario
    IS
    SELECT  MAX(COMMENT_CLASS_ID) 
    FROM    GE_COMMENT_CLASS;

    CURSOR cuExisteClase
    IS
    SELECT  comment_class_id
    FROM    GE_COMMENT_CLASS
    WHERE   UPPER(description) = upper('Información de Calidad de la Medición') ;

    nuSecuencia NUMBER;
    nuExiste    GE_COMMENT_CLASS.comment_class_id%TYPE;
BEGIN
    dbms_output.put_line('INICIA datafix OSF-2355');

    OPEN cuseqClaseComentario;
    FETCH cuseqClaseComentario INTO nuSecuencia;
    CLOSE cuseqClaseComentario;

    nuSecuencia := nuSecuencia+1;

    OPEN cuExisteClase;
    FETCH cuExisteClase INTO nuExiste;
    CLOSE cuExisteClase;

    IF (nuExiste IS NULL) THEN
        INSERT INTO GE_COMMENT_CLASS (comment_class_id, description)
        VALUES (nuSecuencia, 'Información de Calidad de la Medición'); 

        dbms_output.put_line('Se inserto la clase de comentario');
    ELSE 
        dbms_output.put_line('La clase ya existe');
    END IF;

    COMMIT;

    dbms_output.put_line('INICIA datafix OSF-2355');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/