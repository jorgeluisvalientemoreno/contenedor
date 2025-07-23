/***************************************************************************
Propiedad Intelectual de Gases del Caribe
Objeto          : SEQ_AUDITORIA_MANOT
Tipo            : Secuencia
Autor           : jcatuche

Autor       Fecha           Caso        Descripcion
jcatuche    06-12-2024      OSF-3332    Creacion
***************************************************************************/
DECLARE
    nuconta NUMBER;
BEGIN
    SELECT COUNT(*) 
    INTO nuconta
    FROM dba_sequences
    WHERE sequence_name = 'SEQ_AUDITORIA_MANOT';

    IF nuconta = 0 THEN
        EXECUTE IMMEDIATE 'CREATE SEQUENCE PERSONALIZACIONES.SEQ_AUDITORIA_MANOT 
                            START WITH 1
                            INCREMENT BY 1
                            MINVALUE 1
                            MAXVALUE 9999999999
                            NOCYCLE NOCACHE';  	
                            
        dbms_output.put_line('Secuencia SEQ_AUDITORIA_MANOT creada');
    ELSE
        dbms_output.put_line('Secuencia SEQ_AUDITORIA_MANOT ya existe');
    END IF;
END;
/
Prompt Otorgando permisos sobre PERSONALIZACIONES.SEQ_AUDITORIA_MANOT
BEGIN
    pkg_utilidades.praplicarpermisos('SEQ_AUDITORIA_MANOT', 'PERSONALIZACIONES');
END;
/    