set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2883   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_DSPERIODO',
        'LDC_DSPS_MOTIVE_STATUS',
        'LDC_DSPS_PACKAGE_TYPE',
        'LDC_DSPS_PRODUCT_STATUS',
        'LDC_DSSUBCATEG',
        'LDC_PAQUETEANEXOA',
        'LDC_PE_BOGESTLIST',
        'LDC_PKANULSOLICDUPLI',
        'LDC_PKCM_RESCALCVAR',
        'LDC_PKDLRCLPB',
        'LDC_PKFORMVENTAGASFORM',
        'LDC_PKGENGAVBR',
        'LDC_PKGENNOTACOMENER',
        'LDC_PKGENVENFORMASI',
        'LDC_PKGESTIONABONDECONS',
        'LDC_PKGESTIONACARTASREDES',
        'LDC_PKGESTIONITEMS',
        'LDC_PKGPROCREVPERFACT',
        'LDC_PKGRUTCONTCAM',
        'LDC_PKLDCCFA',
        'LDC_PKSATABMIRROR'     );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;  
    --
    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN TEMPORAL'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'OPEN TEMPORAL'
     WHERE  NOMBRE in ( 
        'LDC_PKGPROCEFACTSPOOLFAC',
        'LDC_PKGPROCEFACTSPOOLATENCLI',
        'LDC_PKGPROCEFACTSPOOLCART',
        'LDC_PKGPROCEFACTSPOOLCONSU'  );
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