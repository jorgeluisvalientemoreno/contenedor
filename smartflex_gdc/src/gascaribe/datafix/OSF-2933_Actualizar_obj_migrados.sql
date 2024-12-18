set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Julio 2024 
    JIRA:           OSF-2933   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'GDC_DSLDC_PLAZOS_CERT',
        'GDC_DSLDC_USUARIOS_SUSP_Y_NOTI',
        'GDC_DSUSUARIOS_NO_APLICA_SU_NO',
        'LDC_USUARIOS_SUSP_Y_NOTI',
        'USUARIOS_NO_APLICA_SUSPE_NOTIF',
        'LDC_VISTA_USUARIOS_SUSPENDER',
        'LDC_VISTA_USUARIOS_NOTIFICAR',
        'LDC_PROCCREASOLICITUDNOTIFI',
        'LDC_PROCCREASOLICITUDSUSPADMIN' );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;  
        
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
  
PROMPT **** Termina actualizar registro entidad master_personalizaciones**** 
PROMPT =========================================

set timing off
set serveroutput off
/