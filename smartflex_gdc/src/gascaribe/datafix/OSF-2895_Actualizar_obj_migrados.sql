set serveroutput on size unlimited 
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

    /***********************************************************
    ELABORADO POR:  Adriana Vargas
    EMPRESA:        MVM Ingenieria de Software
    FECHA:          Julio 2024 
    JIRA:           OSF-2895   
    ***********************************************************/
PROMPT =========================================
PROMPT **** Inicia Actualizar registro en entidad master_personalizaciones 
PROMPT 

BEGIN
 --
    dbms_output.put_line('Actualizar registro COMENTARIO = ''MIGRADO ADM_PERSON'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'MIGRADO ADM_PERSON'
     WHERE  NOMBRE in (
        'PROCGENERACUPONASO2001DU_2',
        'PROCGENERACUPONASO2001_2',
        'PROCGENERACUPONASO2001',
        'PROCGENERACUPONASO2001DU'
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
        'LDC_OSF_PROVCOST',
        'WF_DATA_EXTERNAL_COPIA',
        'TEMP_INFO',
        'LDC_FUNDESARROLLO',
        'TRG_AU_AA_AB_ADDRESS_157_268',
        'LDC_SEGUIMIENTO_PROGRAMA',
        'LDC_OSF_REPOCONSUMOS',
        'TRG_AFTER_PAGOSVUM',
        'LDC_LOG_PB_HILOS',
        'LDC_CALIDAD_CARTERA',
        'LDC_SEGUIMIENTO_COBOL',
        'TOTAL_CART_MES_CONC',
        'TRG_LOG_DELETE_CARGOS',
        'LDC_PROCCREASOLICITUDNOTIFI',
        'BAJAR_RECLAMOS_PQR_ESCRITAS', 
        'TRG_AU_AA_AB_ADDRESS_136_236',
        'WF_INSTANCE_TRANS_BACKUP',
        'DROP_WF_INSTANCE_COPIA',
        'TRG_AU_AA_AB_ADDRESS_148_255',
        'REVERSEEXECUTEORDER',
        'TRG_AU_AI_GE_PERSON_225_396',
        'TRG_AU_AI_FA_HISTCOD_239_412',
        'TRGIURLD_SHOPKEEPER',
        'TRGAIURLD_PRICE_LIST',
        'LDC_REGFACPROD',
        'LDC_PRGENTRAMITELARETECPRIO',
        'TRGAIMO_EXECUTOR_LOG_MOT',
        'IC_CARTCOCO_NEW',
        'TGR_PR_PRODUCT_AU_99',
        'LDC_PKGESTIONTARITRANPRUE',
        'LDC_CREA_TRAMITE_CERTTRAB',
        'TRG_LDC_REVCAPUSADA',
        'LDC_MUES_CONSUMOS',
        'LDC_RUTEROSCRM',
        'LDC_LOGORPELEGAVALUSER',
        'LDC_DAT_ORDEN_TRABAJO',
        'LDC_TRGGENORDIMPLECT',
        'LDC_PROCBAJARECLAMOJOB',
        'ATENCION_SOLIC_REV_PER_AUT',
        'LDC_LOGCAMDIRORDER606',
        'TRG_LDC_REVLEGORDER',
        'JOB_CUADRES_BOBEGAS',
        'LDC_OSF_INDICA_CARTE',
        'TRGAUALLOCATEQUOTENTL',
        'LDCI_REGISTERSUSP',
        'LDC_BOCONCIL_USU_FACT',
        'TOTAL_CART_MES_CONC_REFI' );

    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF;
    COMMIT;  
 --
    dbms_output.put_line('Actualizar registro COMENTARIO = ''OPEN'' en master_personalizaciones');
    UPDATE  MASTER_PERSONALIZACIONES 
       SET COMENTARIO = 'OPEN'
     WHERE  NOMBRE in (
        'LD_BCEQUIVALREPORT',
        'PKTBLIC_DETLISIM',
        'LD_BCSELECTIONCRITERIA',
        'IC_BCLISIMPROVGEN',
        'IC_BOLISIMPROVGEN',
        'LD_BCFILEGENERATION',
        'LD_BCGENERATIONRANDOMSAMPLE_3',
        'LD_REPORT_GENERATION',
        'IC_BCLISIMPROVREV',
        'LD_BCNOTIFIMASCR',
        'IC_BSLISIMPROVGEN',
        'PKG_CONSTANTES',
        'XMLDOM',
        'XMLPARSER',
        'XSLPROCESSOR',
        'XMLNODECOVER',
        'XMLATTRCOVER',
        'XMLCHARDATACOVER',
        'XMLDOCUMENTCOVER',
        'XMLDOMIMPLCOVER',
        'XMLDTDCOVER',
        'XMLELEMENTCOVER',
        'XMLENTITYCOVER',
        'XMLNNMCOVER',
        'XMLNODELISTCOVER',
        'XMLNOTATIONCOVER',
        'XMLPARSERCOVER',
        'XMLPICOVER',
        'XMLTEXTCOVER',
        'XSLPROCESSORCOVER',
        'XSLSTYLESHEETCOVER',
        'DBMS_XMLQUERY',
        'DBMS_XMLSAVE',
        'XMLGEN',
        'LDCBI_ESTADOCUENTA',
        'PKTRAMITESRPUSERSSUSPE',
        'GETSECUREINITIALVALUE'
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