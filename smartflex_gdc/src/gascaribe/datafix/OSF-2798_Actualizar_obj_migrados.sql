set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2798   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
       'LDC_PKACTCOPRSUCA2',
        'LDC_PKANAREFINANOSF',
        'LDC_PKCOSTOINGRESO',
        'LDC_PKG_REPORTS_FACT',
        'LDC_PKGESTIOINTANCIA',
        --'LDC_PKGESTORDECARTA', --retirado
        'LDC_PKGGECOPRFAMAS',
        'LDC_PKGLDCGESTERRRP',
        'LDC_PKGPROCMUCTT',
        'LDC_PRAJUSORDESINACTA',
        'PKBORRADATOSCIERRE',
        'PKBORRADATOSCIERRE_GDC',
        'PKORDENESSINACTA',
        'GDC_BCSUSPENSION_XNO_CERT',
        'IC_BOCOMPLETSERVICEINT_GDCA',
        'LDCI_PKINTERFAZLISTPRECSAP',
        'CC_BOCLAIMINSTANCEDATA_PNA',
        'LD_BOAVAILABLEUNIT',
        'LDC_BCGESTIONTARIFAS',
        'LDC_BOREPORTES'
   );

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