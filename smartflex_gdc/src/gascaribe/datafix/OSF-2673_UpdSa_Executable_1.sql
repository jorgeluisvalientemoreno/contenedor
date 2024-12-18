set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');

BEGIN
    dbms_output.put_line('Actualizar ejecutable LDCGENCOMASE - Genera la Liquidacion de Comisiones a Asesores de Venta');
    UPDATE sa_executable
       SET DESCRIPTION = 'NO USAR - Genera la Liquidacion de Comisiones a Asesores de Venta'
     WHERE NAME = 'LDCGENCOMASE'; 
    COMMIT;
    dbms_output.put_line('Ejecutable LDCGENCOMASE Actualizado!');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar ejecutable LDCGENCOMASE - Genera la Liquidacion de Comisiones a Asesores de Venta');
END;
/
