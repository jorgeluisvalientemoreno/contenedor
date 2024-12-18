SET SERVEROUTPUT ON;
COLUMN dt NEW_VALUE vdt
COLUMN db NEW_VALUE vdb
SELECT to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db FROM dual;
SET SERVEROUTPUT ON SIZE UNLIMITED 
SELECT to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio FROM dual;
BEGIN
    dbms_output.put_line('Actualizar registros en master_personalizaciones');
    
    --Campo comentario = MIGRADO ADM_PERSON: Se migro el objeto al esquema ADM_PERSON     
    UPDATE  master_personalizaciones 
    SET comentario = 'MIGRADO ADM_PERSON'
    WHERE  nombre IN (
                        'LDC_PROCONTROL_DUPLICADO'
                        ,'LDC_PROCVALIDAFUNUNIDOPER'
                        ,'LDCI_PROREPLICECOLOCA'
                        ,'LDC_OS_VALIDBILLPERIODBYPROD'
                        ,'LDCI_PROUPDOBSTATUSCERTOIAWS'
                        ,'LDCPROCREATRAMRECSINCERTXML'
                        ,'LDC_VISITAVENTAGASXML'
                        ,'LDC_PRVPMDATA'
                        ,'LDC_PRODEVUELVEVALORESCUOTAS'
                        ,'LDC_PROREG_CT_PROCESS_LOG'                                        
                     );   
    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'LDC_PROCREPBR'
                        ,'LDCPLUGINMARCREPAINTEGR'
                        ,'LDCPLUGINMARCCERTINTEGR'
                        ,'LDCVALIDANOLEGSOLSACSOREF'
                        ,'LDC_PRREGISTRAOTCONTRATO'
                        ,'PR_CREAACTIBYTASKTYPE'
                        ,'LDC_LEGALIZERECONEX'
                        ,'LDC_PRANULACONSECUTIVO'
                        ,'PROCOSTOORDEN_1'
                        ,'LDC_VALMEDI_ORDCARGOCONEC'
                        ,'LECTMOVIL'
                        ,'LDC_VALIDACANTCARACOBS'
                        ,'LDC_PRCAUSALMARCAPRODUCTO'
                        ,'PRC_UD_CLOB_ED_DOCUMENT'
                        ,'LDC_DETREPBR'
                        ,'LDC_DETREPMS'
                        ,'LDC_ENCREPBR'
                        ,'LDC_OTCONTRATOSGDC'
                        ,'LD_LECTMOVIL'                
                    );    

        --Campo comentario = OPEN: objeto versionado como obsoleto
        UPDATE  master_personalizaciones 
        SET comentario = 'OPEN'
        WHERE  nombre IN ('PROCESONOVALIDA');             
                    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('No se pudo actualizar registro en master_personalizaciones, '||sqlerrm);
END;
/
SELECT to_char(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin
  FROM dual;
/