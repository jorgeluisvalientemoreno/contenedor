set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Junio 2024 
    JIRA:           OSF-2849   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_BOIMPFACTURACONSTRUCTORA',
        'LDC_BOPOLITICASLDC'
   );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT; 
    --

    dbms_output.put_line('Actualizar registro COMENTARIO = ''DEJAR EN OPEN'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'DEJAR EN OPEN'
     WHERE  NOMBRE in (
        'LDC_BOGENORAPOADIC',
        'LDC_BOLDSEMAIL',
		'LDC_BOCOUPONS'
   );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT; 
    --
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'LDC_BOASOBANCARIA2001',
        'LDC_BOCARTERA',        
        'LDC_BOCRMCOTIZACION',
        'LDC_BODOC_INFO_GDC',
        'LDC_BOFACTURADEVENTA',
      --  'LDC_BOFWCERTFREVPERIOD', retirado
        'LDC_BOGESTIONMODSOLI',
        'LDC_BONOTIFICATIONSERVICES',
        'LDC_BOORDENCONCILACION',
        'LDC_BOOTBYQUOTATION',
       -- 'LDC_BOPACKAGE',
       -- 'LDC_BOPICONSTRUCTORA', retirado
       -- 'LDC_BOPICOTIZACOMERCIAL', retirado
        'LDC_BOPROYECTOCONSTRUCTORA',
        'LDC_BOREGISTERNOVELTY_NEWNOV',
        'LDC_BOREPROCESAORD',
       -- 'LDC_BOSUBSCRIPTION', retirado
        'LDC_BOSUSPPORSEGURIDAD',
        'LDC_BOTRASLADO_PAGO'--,
       -- 'LDC_BOUBIGEOGRAFICA' retirado
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