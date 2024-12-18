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
                        'LDC_CREA_TRAMITE_SER_ING'
                        ,'LDC_OSSEXCLUYEPNO'
                        ,'LDC_PRBORRAVISITAFALLIDA'
                        ,'LDC_PROLIBERAELEMENTOMEDICION'
                        ,'LDC_VALIDA_FECHA_EJECUCION'
                        ,'LDCORGESCOBPREJUCOND'
                        ,'LDCPROCREATRAMITESRP'
                        ,'LDCPROLISTACAUSAL'
                        ,'OS_VISITPACKAGES'                                        
                     );   
    
    --Campo comentario = BORRADO: Se borro el objeto de la BD                
    UPDATE  master_personalizaciones 
    SET comentario = 'BORRADO'
    WHERE  nombre IN (
                        'FRCGETUNIDOPERTECCERT'
                        ,'LDC_ACTFECPERGRADIFE'
                        ,'LDC_ASIGCONTYPRESGDC2'
                        ,'LDC_AUXICIERREVARIOS'
                        ,'LDC_CAMBIOESTDLICE'
                        ,'LDC_CONSULTACERTVIGTEC'
                        ,'LDC_CONSULTACERTVIGTECFE'
                        ,'LDC_ENVIAMAILCERTVENCE'
                        ,'LDC_LLENASUBSIDIOCIERRE_TT'
                        ,'LDC_OPERATING_UNIT'
                        ,'LDC_OSF_SUBSIDIO_TT'
                        ,'LDC_PRGENESOLSACRP'
                        ,'LDCCREAFLUJOSRPSUSADMAR'
                        ,'LDCPROCCREAMARCAASIGAUTO'
                        ,'PROGUARDAASIGOTTEC'                        
                    );   
    
    --Campo comentario = OPEN: Se quedan en el esquema de OPEN (Obsoletos)                
    UPDATE  master_personalizaciones 
    SET comentario = 'OPEN'
    WHERE  nombre IN (
                        'CSE.TRG_LDC_TITULACION'
                        ,'LDC_CERTIFICADO'
                        ,'LDC_NORMA'
                        ,'LDC_TITULACION'
                        ,'LDCTRG_CERTIFICADO_TECNICO'
                     );                      
                    
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