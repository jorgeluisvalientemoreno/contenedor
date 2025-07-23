SET SERVEROUTPUT ON;
PROMPT Borrado procedimiento adm_person.pkg_clienteestacional
DECLARE
    nuconta NUMBER;
BEGIN

	dbms_output.put_line('Inicia borrado del paquete adm_person.pkg_clienteestacional');
	
    SELECT COUNT(*)
    INTO nuconta
    FROM dba_objects
    WHERE UPPER(object_name) = 'PKG_CLIENTEESTACIONAL'
    AND owner = 'ADM_PERSON'
    AND object_type <> 'SYNONYM';
	
    IF nuconta > 0 THEN
		dbms_output.put_line('Borrando el paquete ADM_PERSON.PKG_CLIENTEESTACIONAL');
        EXECUTE IMMEDIATE 'DROP PACKAGE ADM_PERSON.PKG_CLIENTEESTACIONAL';
	ELSE 
		dbms_output.put_line('El paquete ADM_PERSON.PKG_CLIENTEESTACIONAL no existe');
    END IF;
	
	dbms_output.put_line('Finaliza borrado del paquete adm_person.pkg_clienteestacional');
	
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('No se pudo borrar el procedimiento LDC_CLOSEORDER - ' || sqlerrm);
END;
/