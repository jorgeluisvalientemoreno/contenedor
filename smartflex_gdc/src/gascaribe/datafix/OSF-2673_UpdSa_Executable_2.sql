set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

BEGIN
    dbms_output.put_line('Actualizar ejecutable LDEMAIL - Inbox Atencion Usuario');
    UPDATE sa_executable
       SET DESCRIPTION = 'NO USAR - Inbox Atencion Usuario'
     WHERE NAME = 'LDEMAIL'; 
    COMMIT;
    dbms_output.put_line('Ejecutable LDEMAIL Actualizado!');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar ejecutable LDEMAIL - Inbox Atencion Usuario');
END;
/
