column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-2489');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
/*
    OSF-2489: solicitud de apertura acta 219330
              solicita la apertura del acta 219330 la cual fue cerrada por error sin haber 
              cumplido el procedimiento correcto de cargue en onbse para aprobaciones y 
              posterior pago, ya que el sistema no permite el cargue de actas cerradas

    Autor:    German Dario Guevara Alzate - GlobaMVM
    Fecha:    20/03/2024
*/
    csbCaso     CONSTANT VARCHAR2(4000) := 'OSF-2489';
    cnuActa     CONSTANT NUMBER         := 219330;
    
    nuError     NUMBER;
    sbError     VARCHAR2(4000);

BEGIN

    dbms_output.put_line('Inicia Proceso.');
    dbms_output.put_line('----------------------------------------------------');    
    
    -- Ejecuta el procedimiento para abrir el acta
    ldc_prAbrirActaCerrada
    (
        cnuActa,
        csbCaso,
        nuError,
        sbError
    );
    
    IF (nvl(nuError,0) <> 0) THEN
        dbms_output.put_line('Error en el proceso de apertura del Acta '||cnuActa ||': '|| sbError );
        rollback;
    ELSE
        dbms_output.put_line('Proceso de apertura del Acta: '||cnuActa||', fue realizado OK');
        commit;    
    END IF;
    
    dbms_output.put_line('----------------------------------------------------');
    dbms_output.put_line('Fin del Proceso.');
   
EXCEPTION
    WHEN OTHERS THEN
        rollback;
        dbms_output.put_line('Error del proceso. Acta '||cnuActa ||', SQLERRM: '|| SQLERRM );
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/