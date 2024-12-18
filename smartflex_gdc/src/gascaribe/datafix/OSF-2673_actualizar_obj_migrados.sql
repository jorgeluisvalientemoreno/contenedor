set serveroutput on size unlimited 
BEGIN
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'LDC_PROVALIREGENSERVNUEVOS_PR',
        'LDC_CREATRAMITEREPARACIONRP',
        'LDC_PRLECTURAVAL',
        'LDC_OS_UDPORDERADDRESS',
        'LDC_OS_UDPREQUESTADDRESS',
        'LDC_CERTIFICATE_RP',
        'OS_PEGENCONTRACTOBLIGAT',
        'LDC_PROREGCALCAMORTANOANO',
        'CHANGESTATUS',
        'LDC_OS_ADDRESSCHANGE'
);

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;
    
    dbms_output.put_line('Actualizar registro COMENTARIO = ''BORRADO'' en master_personalizaciones');
    UPDATE  master_personalizaciones 
       SET COMENTARIO = 'BORRADO'
     WHERE  NOMBRE in (
        'LDC_VALCRITERIORECONEX_TEST',
        'LDC_VALIDA_ITEM_REGULADOR',
        'LDC_PROACTUALIZATIPOMEDIDOR',
        'LDC_PRINSPROYECT',
        'PRTEMPORALCHARGE10444',
        'LDCGENCOMASE_PROCESAR',
        'LDC_GENERA_OT_VISITA_AUTOMA',
        'LDC_LLENASESUCIER_COPIA',
        'LDC_PROCCANTUSUARPORDEUCONC',
        'LDC_PROLDEMAIL',
        'PROCESSVALIDAORDENTRAB',
        'PROANALISUSPENSION',
        'LDC_RESTRATIFICACION',
        'PROMARCAUSUACODPROVEED',
        'LDC_PROELIMINAEQUIPAMENTO',
        -- otros
        'SOLICITUD_VISITA_AUTOMAT',
        'LDC_OSF_USUDECOLO',
        'LDC_ANALISUSP',
        'LDC_PROANALISUSPENSION',
        'LDC_PROANALISUSPENSION2'
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